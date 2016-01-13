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
    
    private static let _sizingView = SermonViewCell()  //MessageColllectionViewCellCollectionViewCell.loadFromNib()
    
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
            collectionView?.registerClass(SermonViewCell.self, forCellWithReuseIdentifier: MessageCollection.cellReuseId)
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

        if let msgs = messages {
            let idx = (msgs.count - 1) - indexPath.item
            let message = msgs[idx].dictionary
            
            if let c = cell as? SermonViewCell {
                c.message = message;
                if idx % 2 == 1 {
                    c.arrowOrientation = MessageArrowOrientation.Right
                } else {
                    c.arrowOrientation = MessageArrowOrientation.Left
                }
                
                c.setNeedsLayout()
                c.layoutIfNeeded()
            }
        }
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = collectionView.bounds.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)


        if let msgs = messages {
            let idx = (msgs.count - 1) - indexPath.item
            
            MessageCollection._sizingView.message = msgs[idx].dictionary
            return MessageCollection._sizingView.sizeThatFits(CGSize(width: width, height: CGFloat.max))
        }

        return CGSize(width: width, height: 0)
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
