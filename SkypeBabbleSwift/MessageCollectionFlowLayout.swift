//
//  MessageCollectionFlowLayout.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 04/01/2016.
//  Copyright © 2016 James O'Brien. All rights reserved.
//

import UIKit

class MessageCollectionFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        setupMetrics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMetrics()
    }
    
    
    private func setupMetrics() {
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }

}
