//
//  MessagesBackgroundView.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 05/01/2016.
//  Copyright © 2016 James O'Brien. All rights reserved.
//

import UIKit

class MessagesBackgroundView: UIView {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext();
        CGContextClipToRect(ctx, rect);

        GMBStyleKit.drawMessageListBG(screenWidth: self.bounds.size.width, screenHeight: self.bounds.size.height);
    }


}
