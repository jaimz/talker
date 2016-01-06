//
//  MessageColllectionViewCellCollectionViewCell.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 16/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

enum MessageArrowOrientation {
    case Left
    case Right
}

class MessageColllectionViewCellCollectionViewCell: UICollectionViewCell {
    
    let avatarSize : CGFloat = 28.0;
    let avatarInset : CGFloat = 17.0;
    let labelPad : CGFloat = 8.0;
    
    @IBOutlet var arrowView: MessageArrowView!
    @IBOutlet var avatar: LeafAvatar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!

    var arrowOrientation : MessageArrowOrientation = MessageArrowOrientation.Left {
        didSet {
            self.arrowView.orientation = arrowOrientation;
            nameLabel.textAlignment = NSTextAlignment.Right
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = GMBStyleKit.purple80;
        messageLabel.textColor = GMBStyleKit.purple;
    }
    
    func configureWithMessage(message : [String : JSON]?) {
        nameLabel.text = message?["name"]?.string ?? ""
        avatar.avatarUrl = message?["avatar_url"]?.string ?? ""
        messageLabel.text = message?["text"]?.string ?? ""
    }

    override func layoutSubviews() {
        let bounds = self.bounds;
        
        self.arrowView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.width, height: 10));

        let avatarX = arrowOrientation == MessageArrowOrientation.Right ? avatarInset : bounds.width - (avatarInset + avatarSize);
        
        self.avatar.frame = CGRect(origin: CGPoint(x: avatarX, y: 0), size: CGSize(width: avatarSize, height: avatarSize));
        
        let avatarMargin = avatarSize + avatarInset + labelPad;
        let contentWidth = bounds.width - (avatarMargin) * 2;
        
        let infHeight = CGSize(width: contentWidth, height: CGFloat.max);
        let nameSize = self.nameLabel.sizeThatFits(infHeight);
        let messageSize = self.messageLabel.sizeThatFits(infHeight);
        
        nameLabel.frame = CGRect(origin: CGPoint(x: avatarMargin, y: 12), size: nameSize)
        
        NSLog("Message size h: %f (%f)", messageSize.height, contentWidth)
        messageLabel.frame = CGRect(origin: CGPoint(x: avatarMargin, y: 12 + nameSize.height), size: messageSize)
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var result = CGSize(width: size.width, height: CGFloat.max)
        
        var height = avatarSize
        //let avatarMargin = avatarSize + avatarInset + labelPad
        //let contentWidth = bounds.width - (avatarMargin * 2)
        let nameSize = self.nameLabel.sizeThatFits(result)
        let messageSize = self.messageLabel.sizeThatFits(result)
        
        height += (12 + nameSize.height)
        height += messageSize.height
        
        result.height = height
        
        return result
    }
    
    func loadViewFromNib() -> UIView {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    static func loadFromNib() -> MessageColllectionViewCellCollectionViewCell {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        
        return nib.instantiateWithOwner(self, options: nil).first as! MessageColllectionViewCellCollectionViewCell
    }
}
