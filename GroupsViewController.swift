//
//  GroupsViewController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 04/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

class GroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let cellReuseId = "groupCell";
    
    @IBOutlet var groupsLabel: UILabel!
    @IBOutlet var createDMButton: UIButton!
    
    @IBOutlet var createGroupButton: UIButton!
    
    @IBOutlet var groupsCollectionView: UICollectionView!
    
    @IBOutlet weak var userAvatar: LeafAvatar!
    
    
    // TODO(james): should be in a separate data source class
    private var groupsList : [JSON]? = .None;
    
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
        
        self.createDMButton.setImage(GMBStyleKit.imageOfSingleBubble, forState: UIControlState.Normal)
        self.createGroupButton.setImage(GMBStyleKit.imageOfDualBubble, forState: UIControlState.Normal)
        
        let nib = UINib(nibName: "GroupCollectionViewCell", bundle: .None);
        

        self.groupsCollectionView.registerNib(nib, forCellWithReuseIdentifier: cellReuseId);
        
        self.groupsCollectionView.delegate = self;
        self.groupsCollectionView.dataSource = self;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Got the user's profile information
    func gotMe(me: JSON?) {
        if let me = me {
            if let avatarUrl = me["image_url"].string {
                self.userAvatar.avatarUrl = avatarUrl;
            }
        }
        
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
            self.groupsList = groups.array;
            
            // TODO(james): Proper localisation & pluralisation...
            let groupCount = groups.count
            var groupSfx = "s"
            if groups.count == 1 {
                groupSfx = ""
            }
            
            self.groupsLabel.text  = "You are a member of \(groupCount) group\(groupSfx)"
            
            self.groupsCollectionView.reloadData();
            
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

    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0) {
            if let groups = groupsList {
                return groups.count;
            }
        }
        
        return 0;
    }
    
    
    // Mark: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.groupsCollectionView.dequeueReusableCellWithReuseIdentifier(cellReuseId, forIndexPath: indexPath);
        
        if let groupCell = cell as? GroupCollectionViewCell {
            if let groups = groupsList {
                let groupDesc = groups[indexPath.row];
                groupCell.groupName = groupDesc["name"].string;
                groupCell.groupDescription = groupDesc["description"].string;
                groupCell.imageUrl = groupDesc["image_url"].string;
            }
        }
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = self.groupsCollectionView.cellForItemAtIndexPath(indexPath) as? GroupCollectionViewCell {
            
            if let groups = groupsList {
                let groupDesc = groups[indexPath.row];
                prepareGroupViewController(groupDesc);
                
                cell.bounce();
                AnimHelper.DispatchAfterAnimDuration {
                    
                }
            }
        }
    }

    
    func prepareGroupViewController(groupDesc: JSON) {
        
    }
}
