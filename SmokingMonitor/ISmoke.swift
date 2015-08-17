//
//  ISmoke.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 1/25/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit
import CoreData

class ISmoke: NSObject {
    var time: NSDate
    var trigger: Trigger
    
    override init() {
        time = NSDate()
        trigger = .coffee
    }
    
    init(newTrigger: Trigger) {
        time = NSDate()
        trigger = newTrigger
    }
    
    init(time: NSDate, newTrigger: Trigger) {
        self.time = time
        trigger = newTrigger
    }
    
    func addSmokeToMonitor(monitor: Monitor) {
        monitor.addSmokeTime(time)
        monitor.addSmokeTrigger(trigger, newTime: time)
    }
}
