//
//  LeafAvatar.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 09/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

@IBDesignable
class LeafAvatar: UIView {

    private let _leafPath = UIBezierPath();
    private let _imageLayer = CALayer();
    private let _borderLayer = CAShapeLayer();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setup();
    }
    
    init(image: UIImage) {
        self.avatarImage = image;
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
    }
    
    
    var avatarImage : UIImage = GMBStyleKit.imageOfFace {
        didSet {
            _imageLayer.contents = avatarImage.CGImage;
        }
    }
    
    override func prepareForInterfaceBuilder() {
        self.avatarImage = GMBStyleKit.imageOfFace;
    }
    
    
    func setup() {
        _leafPath.moveToPoint(CGPointMake(50, 25))
        _leafPath.addCurveToPoint(CGPointMake(25, -0), controlPoint1: CGPointMake(50, 11.2), controlPoint2: CGPointMake(38.8, -0))
        _leafPath.addLineToPoint(CGPointMake(2, -0))
        _leafPath.addCurveToPoint(CGPointMake(-0, 2), controlPoint1: CGPointMake(0.9, -0), controlPoint2: CGPointMake(-0, 0.9))
        _leafPath.addLineToPoint(CGPointMake(-0, 25))
        _leafPath.addCurveToPoint(CGPointMake(25, 50), controlPoint1: CGPointMake(-0, 38.8), controlPoint2: CGPointMake(11.2, 50))
        _leafPath.addLineToPoint(CGPointMake(48, 50))
        _leafPath.addCurveToPoint(CGPointMake(50, 48), controlPoint1: CGPointMake(49.1, 50), controlPoint2: CGPointMake(50, 49.1))
        _leafPath.addLineToPoint(CGPointMake(50, 25))
        _leafPath.closePath()
        _leafPath.miterLimit = 4;
        
        let mask = CAShapeLayer();
        mask.path = _leafPath.CGPath;
        mask.fillColor = UIColor.blackColor().CGColor;
        
        _borderLayer.path = _leafPath.CGPath;
        _borderLayer.lineWidth = 1.0;
        _borderLayer.lineCap = kCALineCapRound;
        _borderLayer.lineJoin = kCALineJoinRound;
        _borderLayer.strokeColor = UIColor.whiteColor().CGColor;
        _borderLayer.fillColor = UIColor.clearColor().CGColor;
        
        _imageLayer.contents = avatarImage.CGImage;
        _imageLayer.backgroundColor = UIColor.whiteColor().CGColor;
        _imageLayer.contentsGravity = kCAGravityResizeAspectFill;
        _imageLayer.mask = mask;
        
        self.layer.addSublayer(_imageLayer);
        self.layer.addSublayer(_borderLayer);
        
        let logoShadow = GMBStyleKit.logoShadow;
        self.layer.shadowColor = logoShadow.shadowColor?.CGColor;
        self.layer.shadowOffset = logoShadow.shadowOffset;
        self.layer.shadowRadius = logoShadow.shadowBlurRadius;
        self.layer.shadowOpacity = 1.0;
        
        self.layer.shadowPath = _leafPath.CGPath;
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        let frame = CGRect(origin: CGPoint(x: 0, y: 0),
            size: layer.frame.size);
        
        _imageLayer.frame = frame;
        _borderLayer.frame = frame;
    }

}
