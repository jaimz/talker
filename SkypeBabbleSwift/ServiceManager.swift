//
//  ServiceManager.swift
//  SkypeBabbleSwift
//
//  Created by James O'Brien on 05/12/2015.
//  Copyright © 2015 James O'Brien. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {

    let groupMe = GroupMeAPI()
   
    static let sharedInstance = ServiceManager()
}
