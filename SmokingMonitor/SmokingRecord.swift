//
//  SmokingRecord.swift
//  SmokingMonitor
//
//  Created by 647 on 15/2/6.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import Foundation
import CoreData

class SmokingRecord: NSManagedObject {

    @NSManaged var time: NSDate
    @NSManaged var trigger: String
    @NSManaged var update: String

}
