//
//  SermonViewCell.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 07/01/2016.
//  Copyright © 2016 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

enum MessageArrowOrientation {
    case Left
    case Right
}

class SermonViewCell: UICollectionViewCell {
    private static let avatarSize : CGFloat = 28.0
    private static let avatarInset : CGFloat = 17.0
    private static let labelPad : CGFloat = 8.0
    private static let avatarMargin = avatarSize + avatarInset + labelPad
    
    let arrowView = MessageArrowView()
    let avatar = LeafAvatar(frame: CGRect(origin: CGPointZero, size: CGSize(width: SermonViewCell.avatarSize, height: SermonViewCell.avatarSize)))
    let nameLabel = UILabel()
    let messageLabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureViews() {
        nameLabel.numberOfLines = 1;
        nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        nameLabel.font = UIFont.systemFontOfSize(15.0)
        nameLabel.textColor = GMBStyleKit.purple80
        
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        messageLabel.font = UIFont.systemFontOfSize(15.0)
        messageLabel.textColor = GMBStyleKit.purple
        
        self.contentView.addSubview(arrowView)
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(messageLabel)
    }
    
    
    var message : [ String : JSON ]? = .None {
        didSet {
            nameLabel.text = message?["name"]?.string
            avatar.avatarUrl = message?["avatar_url"]?.string
            messageLabel.text = message?["text"]?.string
        }
    }
    
    var arrowOrientation : MessageArrowOrientation = MessageArrowOrientation.Left {
        didSet {
            self.arrowView.orientation = arrowOrientation
            nameLabel.textAlignment = NSTextAlignment.Right
            self.setNeedsLayout()
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {

        var height = SermonViewCell.avatarSize
        let avatarMargin = SermonViewCell.avatarSize + SermonViewCell.avatarInset + SermonViewCell.labelPad
        let contentWidth = size.width - (avatarMargin * 2)
        
        if contentWidth <= 0 {
            return CGSize(width: 0, height: 0)
        }
        
        let infHeight = CGSize(width: contentWidth, height: CGFloat.max)
        
        if let m = messageLabel.text {
            let messageStr = m as NSString
            let messageSize = messageStr.boundingRectWithSize(infHeight,
                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil)
            
            height += messageSize.height
        }
        
        height += 17 + 4
        
        return CGSize(width: size.width, height: height);
    }
    
    override func layoutSubviews() {
        let bounds = self.bounds
        
        self.arrowView.frame = CGRect(origin: CGPoint(x: 0, y: 4.0), size: CGSize(width: self.bounds.width, height: 10))
        
        let avatarX = arrowOrientation == MessageArrowOrientation.Right ? SermonViewCell.avatarInset : bounds.width - (SermonViewCell.avatarInset + SermonViewCell.avatarSize);
        
        self.avatar.frame = CGRect(origin: CGPoint(x: avatarX, y: 0), size: CGSize(width: SermonViewCell.avatarSize, height: SermonViewCell.avatarSize))
        
        let avatarMargin = SermonViewCell.avatarSize + SermonViewCell.avatarInset + SermonViewCell.labelPad
        let contentWidth = bounds.width - (avatarMargin * 2)
        let infHeight = CGSize(width: contentWidth, height: CGFloat.max)
        var y : CGFloat = 12.0 + 4.0
        
        let nameSize = self.nameLabel.sizeThatFits(infHeight)
        nameLabel.frame = CGRect(origin: CGPoint(x: SermonViewCell.avatarMargin, y: 16), size:nameSize)
        y += nameSize.height + 5
        
        let messageSize = _messageLabelSize(infHeight)
        messageLabel.frame = CGRect(origin: CGPoint(x: SermonViewCell.avatarMargin, y: y), size: messageSize)
    }
    
    private func _messageLabelSize(size: CGSize ) -> CGSize {
        var result = CGRect(x: 0, y: 0, width: size.width, height: 0)
        
        if let m = messageLabel.text {
            let messageStr = m as NSString
            result = messageStr.boundingRectWithSize(size,
                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil)
        }
        
        return result.size
    }
}
