//
//  Plot.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 2/1/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class Plot: NSObject {
    var time: [NSDate] = []
    var trigger: [Trigger] = []
    
    var CoreData = CoreDataHelper()
    
    //get smoke record from CoreData
    func getSmokeRecord() {
        var count: Int
        var smokingRecord: [SmokingRecord]
        
        smokingRecord = CoreData.lGetSmokingRecord("day")
        count = smokingRecord.count
        for index in 0...(count-1) {
            time.append(smokingRecord[index].time)
            trigger.append(Trigger(rawValue: smokingRecord[index].trigger)!)
        }
    }
    
    func plotTimePointByDay() -> [NSDate] {
        return time
    }
    
    func plotTriggerByDay() -> [Trigger] {
        return trigger
    }
    
    func plotAmountByWeek() -> [Int] {
        //TODO: calculate the amount of cig. for each day in past 7 days
        //TODO: Read from database
        return [3, 5, 9, 4, 6, 3, 6]
    }
    
    func plotAmountByMonth() -> [Int] {
        //TODO: calculate the amount of cig. for each week in past 4 weeks
        //TODO: Read from database
        return [30, 42, 27, 36]
    }
    
    func plotTriggerByDay() -> [Trigger: Int] {
        //TODO: calculate the amount of cig. for each trigger for each day
        //TODO: sort the amounts from large to small, return the first 5
        return [Trigger.coffee: 0]
    }
    
    func plotTriggerByWeek() -> [Trigger: Int] {
        //TODO: calculate the amount of cig. for each trigger in the past week
        //TODO: sort the amounts from large to small, return the first 5
        return [Trigger.coffee: 15, Trigger.afterSex: 7, Trigger.traffic: 5, Trigger.stress: 5, Trigger.workBreaks: 4]
    }
    
    func plotTriggerByMonth() -> [Trigger: Int] {
        //TODO: calculate the amount of cig. for each trigger in the past month
        //TODO: sort the amounts from large to small, return the first 5
        return [Trigger.coffee: 40, Trigger.afterSex: 35, Trigger.traffic: 30, Trigger.stress: 15, Trigger.workBreaks: 15]
    }
}
