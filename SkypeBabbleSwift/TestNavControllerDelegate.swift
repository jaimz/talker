//
//  TestNavControllerDelegate.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 13/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class TestNavControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    override init() {
        super.init();
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return .None;
    }
}
