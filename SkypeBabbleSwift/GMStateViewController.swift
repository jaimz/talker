//
//  GMStateViewController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 05/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class GMStateViewController: UINavigationController, UINavigationControllerDelegate {

    let authController = AuthenticationViewController();
    let animController = AnimatedPresentationController();
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController);
        setup();
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    
    func setup() {
        self.delegate = self;

        self.navigationBarHidden = true
        self.toolbarHidden = true;
        ServiceManager.sharedInstance.groupMe.notifications.addObserver(self, selector: "gotGroupMeNotification:", name: .None, object: .None);
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gotGroupMeNotification(notification: NSNotification) {
        let groupMe = ServiceManager.sharedInstance.groupMe
        
        switch notification.name {
        case groupMe.needAuthenticationNotification:
            self.pushViewController(authController, animated: true)
            break;
        default:
            break
        }
    }
   
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == UINavigationControllerOperation.Push) {
            return animController;
        }
        
        return .None;
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
