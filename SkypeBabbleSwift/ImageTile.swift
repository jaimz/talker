//
//  ImageTile.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 24/11/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

let kDefaultCornerRadius = 4.0;

class ImageTile: UIView {

    var image : UIImage? = .None;
    var cornerRadius : CGFloat = 4.0;

    init(image: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
        self.image = .Some(image);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setup();
    }
    
    
    func setup() {
        let imageLayer = CALayer();
        imageLayer.cornerRadius = self.cornerRadius;
        imageLayer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3).CGColor;
        imageLayer.borderWidth = 1.0
        imageLayer.masksToBounds = true;
        imageLayer.frame = CGRect(x: 0,y: 0,width: 20,height: 20);
        imageLayer.backgroundColor = UIColor.greenColor().CGColor;
        
        
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        self.layer.shadowRadius = 4.0;
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.backgroundColor = UIColor.blueColor().CGColor;
        
        self.layer.addSublayer(imageLayer);
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
