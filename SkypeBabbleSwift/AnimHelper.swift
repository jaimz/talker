//
//  AnimHelper.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 11/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class AnimHelper: NSObject {
    static let AnimationDuration = 0.3
    
    static func bounceAnimForKeyPath(keyPath: String) -> CAAnimation {
        let bounceAnim = CAKeyframeAnimation(keyPath: keyPath);
        
        bounceAnim.duration = AnimationDuration;
        bounceAnim.calculationMode = kCAAnimationLinear;
        bounceAnim.removedOnCompletion = true;
        bounceAnim.repeatCount = 1;
        bounceAnim.keyTimes = [ 0.0, 0.5636, 0.7818, 1.0];
        bounceAnim.values = [1.0, 0.95, 1.06, 1.0];
        bounceAnim.timingFunctions = [
            CAMediaTimingFunction(controlPoints: 0.33, 0.0, 0.0, 1.0),
            CAMediaTimingFunction(controlPoints: 1.0, 0.0, 0.78, 1.0),
            CAMediaTimingFunction(controlPoints: 0.33, 0.0, 0.67, 1.0),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        ];
        
        return bounceAnim;
    }
    
    static func DispatchAfterAnimDuration(completion: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(AnimationDuration * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), completion)
    }
}
