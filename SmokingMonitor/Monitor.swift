//
//  Monitor.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 1/25/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class Monitor: NSObject {
    var smokeTimePoint = [NSDate]()
    var smokeTimePointInSecond = [Double]()
    var smokeDict:[Trigger: [Double]] = [.coffee: [], .stress: [], .workBreaks:
        [], .drinking: [], .parties: [], .smokeBuddies: [], .traffic: [],
        .afterMeals: [], .spareTime: []]
    var time: NSDate!
    
    var CoreData = CoreDataHelper()
    
    override init() {
        super.init()
        smokeTimePoint = [NSDate]()
        smokeTimePointInSecond = [Double]()
        smokeDict = [.coffee: [], .stress: [], .workBreaks:
            [], .drinking: [], .parties: [], .smokeBuddies: [], .traffic: [],
            .afterMeals: [], .spareTime: []]
        time = nil
    }
    
    init(time: NSDate) {
        smokeTimePoint = [NSDate]()
        smokeTimePointInSecond = [Double]()
        smokeDict = [.coffee: [], .stress: [], .workBreaks:
            [], .drinking: [], .parties: [], .smokeBuddies: [], .traffic: [],
            .afterMeals: [], .spareTime: []]
        self.time = time
    }
    
    func addSmokeTime(newTime: NSDate) {
        var timeInSecond = newTime.timeIntervalSince1970 % 86400
        smokeTimePointInSecond.append(timeInSecond)
        smokeTimePoint.append(newTime)
        
    }
    
    func addSmokeTrigger(newTrigger: Trigger, newTime: NSDate) {
        var timeInSecond = newTime.timeIntervalSince1970 % 86400
        switch newTrigger {
        case .coffee:
            smokeDict[.coffee]?.append(timeInSecond)
        case .stress:
            smokeDict[.stress]?.append(timeInSecond)
        case .workBreaks:
            smokeDict[.workBreaks]?.append(timeInSecond)
        case .drinking:
            smokeDict[.drinking]?.append(timeInSecond)
        case .parties:
            smokeDict[.parties]?.append(timeInSecond)
        case .smokeBuddies:
            smokeDict[.smokeBuddies]?.append(timeInSecond)
        case .traffic:
            smokeDict[.traffic]?.append(timeInSecond)
        case .afterMeals:
            smokeDict[.afterMeals]?.append(timeInSecond)
        case .spareTime:
            smokeDict[.spareTime]?.append(timeInSecond)
        default:
            println("error")
        }
    }
    
    //update in CoreData
    func updateCoreData(newTime: NSDate, newTrigger: Trigger) -> Int{
        var indicator: Int
        indicator = CoreData.lSaveSmokingRecord(newTime, trigger: "\(newTrigger)")
        if indicator == 0 {
            return 0
        } else {
            return 1
        }
    }
}

