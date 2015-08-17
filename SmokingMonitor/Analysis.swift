//
//  Analysis.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 1/26/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class Analysis: NSObject {
    var amountByDay = [NSDate: Int]()
    var amountByWeek = [Week: Int]()
    var amountByMonth = [Month: Int]()
    
    var triggerToday = [Trigger: Int]()
    
    var triggerByDay = [Trigger: [NSDate: Int]]()
    var triggerByWeek = [Trigger: [Week: Int]]()
    var triggerByMonth = [Trigger: [Month: Int]]()
    
    var smokeIndex: Int
    var smokeSuggestion: Suggestions!
    
    var peakTime: NSDate!
    var peakAmount: Int! = 0
    var majorTrigger: Trigger!
    
    var notificationTime: NSDate!
    var notificationContents: Notifications!
    
    var suggestionList:[String] = []
    
    override init() {
        self.amountByDay = [Date.from(year: 2014, month: 12, day: 01): 0]
        self.amountByWeek = [Week(newWeekFirstDay: Date.parse("2014-12-01", format: "yyyy-MM-dd")):0]
        self.amountByMonth = [Month(newMonthFirstDay: Date.parse("2014-12-01", format: "yyyy-MM-dd")):0]
        self.triggerByDay = [Trigger.coffee: [Date.from(year: 2014, month: 12, day: 01): 0]]
        self.triggerByWeek = [Trigger.coffee: [Week(newWeekFirstDay: Date.from(year: 2014, month: 12, day: 01)): 0]]
        self.triggerByMonth = [Trigger.coffee: [Month(newMonthFirstDay: Date.from(year: 2014, month: 12, day: 01)): 0]]
        
        self.smokeIndex = 0
        self.smokeSuggestion = nil
        self.peakTime = nil
        self.peakAmount = 0
        self.majorTrigger = nil
        
        self.notificationTime = nil
        self.notificationContents = nil
        
        self.suggestionList = []
    }
    
    //init a health index object
    var healthIndexObj = HealthIndex()
    
    func calculateIndex() -> Double {
        var healthIndex: Double = 0.0
        healthIndex = healthIndexObj.calculateIndex()
        
        return healthIndex
    }
    
    func getSuggestion() -> [String] {
        suggestionList = healthIndexObj.getSuggestion()
        return suggestionList
    }
    
    func plotAmountByDay() -> [Int] {
        //TODO: Think about and understand how does HealthKit achieve this
        return [0]
    }
    
    private func countToday() -> Int {
        var counter = 0
        return counter
    }
    
    
    
    //init a plot object
    var plotObj = Plot()
    
    
        
    func isEarlierTime(date1: NSDate, date2: NSDate) -> Bool {
        return date1.earlierDate(date2).isEqualToDate(date1)
    }
    
    func getPeakTime(smokeTimePoint: [NSDate]) -> NSDate {
        //TODO: design a method to calculate which time interval is the "busy hour"
        
        var i, j: Int
        var counter: [Int] = [0]
        var max: Int = 0
        var k: Int = 0
        for i in 0...smokeTimePoint.count {
            var timeLimit = NSDate(timeInterval: 3600.0, sinceDate: smokeTimePoint[i])
            if isEarlierTime(smokeTimePoint[i], date2: timeLimit) {
                counter[i] += 1
            }
        }
        for j in 0...smokeTimePoint.count {
            if counter[j] > max {
                max = counter[j]
                k = j
            }
        }
        return smokeTimePoint[k]
    }
    
    func getPeakAmount(smokeTimePoint: [NSDate]) -> Int {
        var peakTime:NSDate = getPeakTime(smokeTimePoint)
        var timeLimit = NSDate(timeInterval: 3600.0, sinceDate: peakTime)
        var counter:Int = 0
        
        for i in 0...smokeTimePoint.count {
            if isEarlierTime(smokeTimePoint[i], date2: timeLimit) && !(isEarlierTime(smokeTimePoint[i], date2: peakTime)) {
                counter += 1
            }
        }
        return counter
    }
    
    func getMajorTriggerToday() -> String {
        var majorTrigger = TriggerCounter.getMajorTrigger(triggerToday)
        return majorTrigger.rawValue
    }
    
    
    //Notifications
    var newNotification = NotificationCreator()
    
    func getNotificationTime() -> (Double, Double, Double) {
        return newNotification.getNotificationTimeInSeconds()
    }
    
    func getNotificationContents() -> (String, String, String) {
        return ("", "", "")
    }
}
