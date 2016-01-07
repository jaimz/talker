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
    let avatar = LeafAvatar()
    let nameLabel = UILabel()
    let messageLabel = UILabel()
    
    private var _cachedWidth : CGFloat = 0.0
    private var _cachedHeight : CGFloat = 0.0
    
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
    }
    
    
    var message : [ String : JSON ]? = .None {
        didSet {
            nameLabel.text = message?["name"]?.string
            avatar.avatarUrl = message?["avatar_url"]?.string
            messageLabel.text = message?["text"]?.string
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        if size.width == _cachedWidth {
            return CGSize(width: size.width, height: _cachedHeight)
        }
        
        return size
    }
}
