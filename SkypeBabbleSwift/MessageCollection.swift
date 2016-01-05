//
//  MessageCollection.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 18/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageCollection: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private static let cellReuseId = "messageCollectionCell"
    
    private static let _sizingView = MessageColllectionViewCellCollectionViewCell.loadFromNib()
    
    var conversationID : String? = .None
    
    
    init(messages: [JSON]? = .None) {
        super.init()
        self.messages = messages;
    }
    
    var messages : [JSON]? = .None {
        didSet {
            collectionView?.reloadData();
        }
    }
    
    weak var collectionView : UICollectionView? = .None {
        didSet {
            collectionView?.registerNib(UINib(nibName: "MessageColllectionViewCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MessageCollection.cellReuseId)
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let m = messages {
            return m.count
        }
        
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MessageCollection.cellReuseId, forIndexPath: indexPath)
        
        let idx = indexPath.item;
        if let message = messages?[idx].dictionary {
            if let c = cell as? MessageColllectionViewCellCollectionViewCell {
                c.configureWithMessage(message);
                if idx % 2 == 1 {
                    c.arrowOrientation = MessageArrowOrientation.Right
                }
            }
        }
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let messageIdx = indexPath.item;
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = collectionView.bounds.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        var result = CGSize(width: width, height: 0.0)

        if let message = messages?[messageIdx].dictionary {
            MessageCollection._sizingView.configureWithMessage(message)
            MessageCollection._sizingView.setNeedsLayout()
            MessageCollection._sizingView.layoutIfNeeded()
            result.height = MessageCollection._sizingView.bounds.height
        }

        return result
    }
    
    func gotInitialMessages(messages: JSON?) {
        if let cv = self.collectionView {
            self.messages = messages?["messages"].array;
            cv.reloadData()
        }
    }
    
    func loadInitialMessages() {
        if let groupId = self.conversationID {
            ServiceManager.sharedInstance.groupMe.messages(groupId, completion: gotInitialMessages)
        }
    }
}
