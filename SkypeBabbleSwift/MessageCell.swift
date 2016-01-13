//
//  MessageCell.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 06/01/2016.
//  Copyright © 2016 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageCell: UICollectionViewCell {
    let avatarSize : CGFloat = 28.0
    let avatarInset : CGFloat = 17.0
    let labelPad : CGFloat = 8.0
    
    let arrowView = MessageArrowView()
    let avatar = LeafAvatar()
    let nameLabel = UILabel()
    let messageLabel = UILabel()
    
    var arrowOrientation : MessageArrowOrientation = MessageArrowOrientation.Right {
        didSet {
            arrowView.orientation = arrowOrientation
            if arrowOrientation == MessageArrowOrientation.Left {
                nameLabel.textAlignment = NSTextAlignment.Right
            } else {
                nameLabel.textAlignment = NSTextAlignment.Left
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureWithMessage(message: [String : JSON]?) {
        nameLabel.text = message?["name"]?.string ?? ""
        avatar.avatarUrl = message?["avatar_url"]?.string ?? ""
        messageLabel.text = message?["text"]?.string ?? ""
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var result = CGSize(width: size.width, height: CGFloat.max)
        
        return result
    }
    
    override func layoutSubviews() {
        
    }
    
}