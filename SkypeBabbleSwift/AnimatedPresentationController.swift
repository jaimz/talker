//
//  AnimatedPresentationController.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 13/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class AnimatedPresentationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    override init() {
        super.init();
        NSLog("Initing navigation controller delegate");
    }
    
    
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return AnimHelper.AnimationDuration;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) {
            if let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) {
                if let containerView = transitionContext.containerView() {
                    containerView.addSubview(toViewController.view);
                }
                
                toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController);
                toViewController.view.alpha = 0;
                toViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
                
                UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
//                    fromViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
                    toViewController.view.alpha = 1;
                    toViewController.view.transform = CGAffineTransformIdentity;
                    }, completion: { (finished: Bool) in
                        fromViewController.view.transform = CGAffineTransformIdentity;
                        transitionContext.completeTransition(finished);
                })
            }
        }
    }
}
