//
//  GroupsView.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 09/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class GroupsView: UIView {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let appFrame = UIScreen.mainScreen().bounds;
        let ctx = UIGraphicsGetCurrentContext();
        CGContextClipToRect(ctx, rect);
        GMBStyleKit.drawGroupsScreenBG(screenWidth: appFrame.width, screenHeight: appFrame.height)
    }

}
