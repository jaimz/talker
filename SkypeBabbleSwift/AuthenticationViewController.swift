//
//  AuthenticationViewController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 30/11/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import WebKit

class AuthenticationViewController: ViewController, WKNavigationDelegate {

    private var webView: WKWebView?
   
    override func loadView() {
        webView = WKWebView();
        webView?.navigationDelegate = self;
        
        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // NSURL(string: "https://oauth.groupme.com/oauth/authorize?client_id=0ba4cde079b1013365931315e13c79f1")
        if let url = NSURL(string: "https://oauth.groupme.com/oauth/authorize?client_id=VqkAMvOI3ySWOc8PGg0vFud6gdPiyHu1tjHJD85tHI8T9a4Z") {
            let req = NSURLRequest(URL: url);
            webView?.loadRequest(req);
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let app = UIApplication.sharedApplication();
        
        if let url = navigationAction.request.URL {
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                
                if (url.scheme == appDelegate.myDeepLinkScheme && app.canOpenURL(url)) {
                    app.openURL(url);
                    decisionHandler(WKNavigationActionPolicy.Cancel);
                    return;
                }
            }
        }
        
        decisionHandler(WKNavigationActionPolicy.Allow);
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue)
    {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
