//
//  MessageColllectionViewCellCollectionViewCell.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 16/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit


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
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        
    }
}
