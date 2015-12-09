//
//  DrawingUtils.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 09/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class DrawingUtils: NSObject {
    static func giveLogoShadow(layer: CALayer) {
        let ls = GMBStyleKit.logoShadow;
        layer.shadowColor = ls.shadowColor?.CGColor;
        layer.shadowOffset = ls.shadowOffset;
        layer.shadowRadius = ls.shadowBlurRadius;
        layer.shadowOpacity  = 1.0;
    }
}
