//
//  GroupCollectionFlowLayout.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 09/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class GroupCollectionFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init();
        self.setup();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setup();
    }
    
    private func setup() {
        self.minimumLineSpacing = 20.0;
        self.minimumInteritemSpacing = 10.0;
        self.itemSize = CGSize(width: 140.0, height: 200.0);
        self.scrollDirection = UICollectionViewScrollDirection.Vertical;
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 44.0, bottom: 0.0, right: 44.0);
    }
}
