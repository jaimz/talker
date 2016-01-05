//
//  GroupMe.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 02/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias GroupMeCallback = JSON? -> ()

class GroupMeAPI: NSObject {

    // MARK: Notification keys
    let needAuthenticationNotification = "groupme.auth.required";
    let failedAuthenticationNotification = "groupme.auth.failed";
    let haveAccessNotification = "groupme.have.access";
    let haveMeInfoNotification = "groupme.have.me";
    

    // MARK: API communication
    
    // key to store access token against
    private let tokenKey = "groupme.access.token";
    
    
    // Base url of the API server
    private let baseUrl = "https://api.groupme.com/v3";
    
    // Base url for testing
//    private let baseUrl = "http://localhost:8080/fakegm";
   
    
    // Public notification center
    let notifications = NSNotificationCenter();
   
    
    // OAuth access token used to call the API
    var accessToken : String? = .None {
        didSet {
            switch accessToken {
            case .None:
                NSLog("Don't have an accessToken!");
                
            case .Some(let t):
                NSLog("Access token: %@", t);
            }
        }
    }
   
    
    // True if we have an access token
    var haveAccess : Bool {
        get {
            return accessToken != .None;
        }
    }
    
    
    // Access GroupMe. Will initiate an OAuth process if the app
    // does not currently have an access token
    func access() {
        if accessToken == .None {
            let userDefaults = NSUserDefaults.standardUserDefaults();
            if let _tok = userDefaults.objectForKey(tokenKey) as? String {
                accessToken = _tok;
                
                notifications.postNotificationName(haveAccessNotification, object: self);
            } else {
                // No token in the user defaults - need to do oauth
                notifications.postNotificationName(needAuthenticationNotification, object: self);
            }
        } else {
            // Already have an access token
            // TODO: Token may be stale - should do a test request
            notifications.postNotificationName(haveAccessNotification, object: self);
        }
    }
    
    
    // The user  authenticated via OAuth (called by the app delegate when the oauth page
    // redirects to the deeplink)
    func didAuthenticate(newToken: String?) {
        accessToken = newToken;
        
        // TODO: Use KeyChain for storing the access token.
        let defaults = NSUserDefaults.standardUserDefaults();
        var notificationName = haveAccessNotification;
        switch newToken {
        case .None:
            defaults.removeObjectForKey(tokenKey);
            notificationName = failedAuthenticationNotification;
        case .Some(let t):
            defaults.setObject(t, forKey: tokenKey);
        }

        defaults.synchronize();
        
        
        notifications.postNotificationName(notificationName, object: self);
    }
    
    
    private func jsonCompletion(completion: GroupMeCallback)(response: Response<String, NSError>) {
        switch response.result {
        case .Failure(let error):
            NSLog("Error: %@", error.localizedDescription);
            NSLog("%@", response.description);
            break;
        case .Success(let result):
            if let apiResult = pullResult(response, result: result) {
                completion(apiResult)
            } else {
                // nothing - implies an api call error which "pullResult" will
                // already have logged.
            }
            
            break;
        }
    }
    
    // Pull the API call result from the response envelope. Will return .None
    // if an API error has occurred (and will log that error)
    private func pullResult(apiResponse: Response<String, NSError>, result: String) -> JSON? {
        var response : JSON? = .None;
        
        if let dataFromString = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) {
            let responseEnvelope = JSON(data: dataFromString);
            response = responseEnvelope["response"];
            
            if response == .None {
                if let meta = responseEnvelope["meta"].dictionary {
                    if let requestUrl = apiResponse.request?.URL?.URLString {
                        if let code = meta["code"]?.int {
                            print("Bad result \(code) for \(requestUrl)");
                        } else {
                            print("Bad result for \(requestUrl)");
                        }
                    } else {
                        NSLog("Bad result");
                    }
                }
            }
        }
        
        return response;
    }
    
    
    private func req(method: Alamofire.Method, path: String, parameters: [String:AnyObject]?, completion: GroupMeCallback) {
        if (haveAccess == false) {
            NSLog("Request made with no access! (%@)", path);
            return;
        }
        
        let urlString = [ baseUrl, path ].joinWithSeparator("/");
        let callback = jsonCompletion(completion);


        var realParams : [String:AnyObject] = [ "token" : accessToken!];
        switch parameters {
        case .Some(let p):
            for (k, v) in p {
                realParams[k] = v;
            }
            break;
        default:
            break;
        };
        
        
        Alamofire.request(method, urlString, parameters: realParams).validate().responseString(completionHandler: callback);
    }
    
    
    
    // MARK: API methods
    
    func me(completion: GroupMeCallback) {
        req(.GET, path: "users/me", parameters: .None, completion: completion);
    }
    
    func groups(completion: GroupMeCallback) {
        req(.GET, path: "groups", parameters:  .None, completion: completion);
    }
    
    func messages(groupId: String, completion: GroupMeCallback) {
        req(.GET, path: "groups/\(groupId)/messages", parameters: .None, completion: completion)
    }
    
}
