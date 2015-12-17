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
            _imageLayer.contents = avatarImage.CGImage
        }
    }
    
    var avatarUrl : String? = .None {
        didSet {
            if let urlString = avatarUrl {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if let url = NSURL(string: urlString) {
                        let imageData = NSData(contentsOfURL: url)
                        
                        if  let data = imageData {
                            dispatch_async(dispatch_get_main_queue(), {
                                if let image = UIImage(data: data) {
                                    self.avatarImage = image
                                }
                            })
                        }
                    }
                })
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        self.avatarImage = GMBStyleKit.imageOfFace;
    }
    
    
    func setup() {
        calculateLeafPath(self.frame);
        
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
    
    private func calculateLeafPath(frame: CGRect) {
        _leafPath.removeAllPoints()
        
        let w = frame.width;
        let mid = w / 2;
        
        _leafPath.moveToPoint(CGPointMake(w, mid))
        _leafPath.addCurveToPoint(CGPointMake(mid, 0), controlPoint1: CGPoint(x: w, y: (w / 4.4642)), controlPoint2: CGPoint(x: w / 1.2886, y: 0))
        _leafPath.addLineToPoint(CGPoint(x: 2, y: 0))
        _leafPath.addCurveToPoint(CGPoint(x: 0, y: 2), controlPoint1: CGPoint(x: 1, y: 0), controlPoint2: CGPoint(x: 0, y: 1))
        _leafPath.addLineToPoint(CGPoint(x: 0, y: mid))
        _leafPath.addCurveToPoint(CGPoint(x: mid, y: w), controlPoint1: CGPoint(x: 0, y: w / 1.2886), controlPoint2: CGPoint(x: w / 4.4642, y: w))
        _leafPath.addLineToPoint(CGPoint(x: w - 2, y: w))
        _leafPath.addCurveToPoint(CGPoint(x: w, y:  (w - 2)), controlPoint1: CGPoint(x: w, y: w), controlPoint2: CGPoint(x: w, y: w))
        _leafPath.addLineToPoint(CGPoint(x: w, y: mid))
        _leafPath.closePath()
        _leafPath.miterLimit = 4
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        let frame = CGRect(origin: CGPoint(x: 0, y: 0),
            size: layer.frame.size);
        
        calculateLeafPath(frame);
        
        _imageLayer.frame = frame;
        _borderLayer.frame = frame;
    }

}
