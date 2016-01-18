//
//  MessageEditorBacking.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 14/01/2016.
//  Copyright © 2016 James O'Brien. All rights reserved.
//

import UIKit

@IBDesignable
class MessageEditorBacking: UICollectionViewCell {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext();
        CGContextClipToRect(ctx, rect);
        
        GMBStyleKit.drawTextField(screenWidth: self.bounds.size.width, textFieldHeight: self.bounds.size.height)
    }
    
}
