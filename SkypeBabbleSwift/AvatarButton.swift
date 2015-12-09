//
//  MeView.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 26/11/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class AvatarButton: UIButton {
    
    private let avatarImageLayer = CALayer();
    private let borderLayer = CALayer();

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func setup() {
        self.avatarImageLayer.contents = avatarImage;
        // TODO(james): Put a "white" color in the stylekit
        borderLayer.borderColor = UIColor.whiteColor().CGColor;
        borderLayer.borderWidth = 2.0;
        
        let logoShadow = GMBStyleKit.logoShadow;
        self.borderLayer.shadowColor = logoShadow.shadowColor?.CGColor;
        self.borderLayer.shadowOffset = logoShadow.shadowOffset;
        self.borderLayer.shadowRadius = logoShadow.shadowBlurRadius;
        self.borderLayer.shadowOpacity = 1.0;
        
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = self.frame.size.width / 2.0;
        
        self.avatarImageLayer.frame = self.frame;
        self.borderLayer.frame = self.frame;
        self.borderLayer.cornerRadius = self.frame.size.width / 2.0;
        
        self.layer.backgroundColor = UIColor.whiteColor().CGColor;

        self.layer.addSublayer(self.avatarImageLayer);
        self.layer.addSublayer(self.borderLayer);
        
        self.addTarget(self, action: "bounceScale", forControlEvents: [ UIControlEvents.TouchDown, UIControlEvents.TouchDragEnter ]);
    }
    
    var avatarImage : UIImage = GMBStyleKit.imageOfFace {
        didSet {
            self.avatarImageLayer.contents = self.avatarImage;
        }
    }
    
    func bounceScale() {
        let skypeBounce = CAKeyframeAnimation(keyPath: "transform.scale");
        skypeBounce.duration = 0.5;
        skypeBounce.calculationMode = kCAAnimationLinear;
        skypeBounce.removedOnCompletion = true;
        skypeBounce.repeatCount = 1;
        skypeBounce.keyTimes = [ 0.0, 0.5636, 0.7818, 1.0 ];
        skypeBounce.values = [ 1.0, 0.88, 1.06, 1.0 ];
        
        skypeBounce.timingFunctions = [ CAMediaTimingFunction(controlPoints: 0.33, 0.0, 0.0, 1.0),
                                        CAMediaTimingFunction(controlPoints: 1.0, 0.0, 0.78, 1.0),
                                        CAMediaTimingFunction(controlPoints: 0.33, 0.0, 0.67, 1.0),
                                        CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        ];
        
        self.layer.addAnimation(skypeBounce, forKey: "scale");
        
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        let layerSize = layer.frame.size;
        let w = layerSize.width;
        let layerFrame = CGRectMake(0.0, 0.0, layerSize.width, layerSize.height);
        
        self.layer.cornerRadius = w / 2.0;
        self.avatarImageLayer.frame = layerFrame;
        self.borderLayer.frame = layerFrame;
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
