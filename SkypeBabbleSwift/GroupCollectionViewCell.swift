//
//  GroupCollectionViewCell.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 09/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    @IBOutlet var groupNameLabel: UILabel!

    @IBOutlet var groupDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        groupNameLabel.textColor = GMBStyleKit.purple;
        
        groupDescriptionLabel.textColor = GMBStyleKit.purple;
    }

    var groupName : String? {
        didSet {
            self.groupNameLabel.text = groupName;
        }
    }
    
    var groupDescription : String? {
        didSet {
            self.groupDescriptionLabel.text = groupDescription;
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
}