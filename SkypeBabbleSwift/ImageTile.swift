//
//  ImageTile.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 24/11/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

let kDefaultCornerRadius = 4.0;


@IBDesignable
class ImageTile: UIView {

    private let _imageLayer = CALayer();

    
    init(image: UIImage) {
        self.image = image;
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setup();
    }
    
    @IBInspectable
    var cornerRadius : CGFloat = 4.0 {
        didSet {
            self._imageLayer.cornerRadius = cornerRadius;
            self.layer.cornerRadius = cornerRadius;
        }
    }
    
    var image : UIImage = GMBStyleKit.imageOfFace {
        didSet {
            _imageLayer.contents = image.CGImage;
        }
    }
    
    override func prepareForInterfaceBuilder() {
        image = GMBStyleKit.imageOfFace;
    }
    
    func setup() {
        _imageLayer.cornerRadius = self.cornerRadius;
        _imageLayer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3).CGColor;
        _imageLayer.borderWidth = 1.0
        _imageLayer.masksToBounds = true;
        _imageLayer.frame = CGRect(x: 0,y: 0,width: 20,height: 20);
        _imageLayer.backgroundColor = UIColor.whiteColor().CGColor;

                
        self.layer.cornerRadius = self.cornerRadius;
        DrawingUtils.giveLogoShadow(self.layer);
        
        self.layer.addSublayer(_imageLayer);
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: layer.frame.size);
        _imageLayer.frame = frame;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
