//
//  UserInfo.swift
//  SmokingMonitor
//
//  Created by 647 on 15/2/6.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import Foundation
import CoreData

class UserInfo: NSManagedObject {

    @NSManaged var password: String
    @NSManaged var userName: String

}
