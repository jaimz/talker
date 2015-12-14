//
//  ConversationViewController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 11/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConversationViewController: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var participantCountLabel: UILabel!
    @IBOutlet var groupAvatar: LeafAvatar!

    
    private var _groupId : String? = .None;
    private var _groupName : String? = .None;
    private var _participantCount : Int? = .None;
    private var _groupAvatar : String? = .None;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(GMBStyleKit.imageOfBackArrow, forState: UIControlState.Normal);
    }
    
    override func viewWillAppear(animated: Bool) {
        groupNameLabel.text = _groupName ?? "";
        participantCountLabel.text = generateParticipantCountLabel();
        groupAvatar.avatarUrl = _groupAvatar;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForInterfaceBuilder() {
        backButton.setImage(GMBStyleKit.imageOfBackArrow, forState: UIControlState.Normal);
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    private func generateParticipantCountLabel() -> String {
        switch _participantCount {
        case .None:
            return "No group information";
        case .Some(let c):
            let sfx = c == 1 ? "" : "s"
            return "\(c) participant\(sfx)..."
        }
    }
    
    
    var Description : JSON? = .None {
        didSet {
            // TODO(james): Clean up previous group?
            switch Description
            {
            case .Some(let d):
                _groupName = d["name"].string;
                _participantCount = d["members"].count;
                _groupAvatar = d["image_url"].string;
                
                break;
            case .None:
                _groupName = .None;
                _participantCount = .None;
                _groupAvatar = .None;
            }
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
