//
//  ConversationViewController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 11/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    @IBOutlet var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(GMBStyleKit.imageOfBackArrow, forState: UIControlState.Normal);
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
