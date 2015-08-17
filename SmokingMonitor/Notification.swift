//
//  Notification.swift
//  SmokingMonitor
//
//  Created by 647 on 15/2/6.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import Foundation
import CoreData

class Notification: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var time: NSDate

}
