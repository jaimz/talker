//
//  GroupsViewController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 04/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

class GroupsViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        setup();
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }
    
   
    private func setup() {
        ServiceManager.sharedInstance.groupMe.notifications.addObserver(self, selector: "gotGroupMeNotification:", name: .None, object: .None);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Got the user's profile information
    func gotMe(me: JSON?) {
        switch me {
        case .Some(let me):
            if let info = me.dictionary {
                let myName = info["name"]?.string
                switch myName {
                case .Some(let n):
                    NSLog("Name: %@", n);
                    break;
                case .None:
                    NSLog("Lost my name!!!");
                    break;
                }
            }
        case .None:
            NSLog("No me!!!");
            break;
        }
    }

   

    private func printGroup(groupInfo: [String:JSON]) {
        if let groupName = groupInfo["name"]?.string {
            NSLog("Group: %@", groupName);
        }
    }
    
    // Got the list of the user's groups
    private func gotGroups(groups: JSON?) {
        switch (groups) {
        case .Some(let groups):
            if let groupList = groups.array {
                for group in groupList {
                    if let groupInfo = group.dictionary {
                        printGroup(groupInfo);
                    }
                }
            }
            break;
        case .None:
            NSLog("Could not get groups!");
        }
    }

    // Got a notification from the GroupMeAPI notification center
    func gotGroupMeNotification(notification: NSNotification) {
        let groupMe = ServiceManager.sharedInstance.groupMe;
        if (notification.name == groupMe.haveAccessNotification) {
            groupMe.me(gotMe);
            groupMe.groups(gotGroups);
        }
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
