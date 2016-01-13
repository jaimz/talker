//
//  MessageArrowView.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 17/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit


@IBDesignable
class MessageArrowView: UIView {
    
    var orientation : MessageArrowOrientation = MessageArrowOrientation.Left {
        didSet {
            setNeedsDisplay()
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        switch orientation {
        case MessageArrowOrientation.Right:
            GMBStyleKit.drawPeakRight(screenWidth: rect.width)
            break;
        default:
            GMBStyleKit.drawPeakLeft(screenWidth: rect.width)
            break;
        }
    }
}
