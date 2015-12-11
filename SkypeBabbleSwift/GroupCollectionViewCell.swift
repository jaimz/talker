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
    
    @IBOutlet weak var avatarTile: ImageTile!
    
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
    
    var imageUrl : String? = .None {
        didSet {
            if let urlString = imageUrl {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if let url = NSURL(string: urlString) {
                        let imageData = NSData(contentsOfURL: url)
                        
                        if let data = imageData {
                            dispatch_async(dispatch_get_main_queue(), {
                                if let image = UIImage(data: data) {
                                    self.avatarTile.image = image;
                                }
                            })
                        }
                    }
                })
            }
        }
    }

    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    func bounce() {
        let bounceAnim = AnimHelper.bounceAnimForKeyPath("transform.scale");

        self.layer.addAnimation(bounceAnim, forKey: "bounceScale");
    }
}