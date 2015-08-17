//
//  NotificationCreator.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 2/6/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class NotificationCreator: NSObject {
    //time and trigger including one month's data
    var time: [NSDate] = []
    var timeInSeconds: [Double] = []
    var trigger: [Trigger] = []
    var notificationTime: (NSDate!, NSDate!, NSDate!) = (nil, nil, nil)
    var notificationContent: (String, String, String) = ("", "", "")
    
    var morningTriggerDict = [Trigger: Int]()//counter of the trigger array
    var afternoonTriggerDict = [Trigger: Int]()
    var eveningTriggerDict = [Trigger: Int]()
    
    var CoreData = CoreDataHelper()
    
    override init() {
        super.init()
        self.getSmokeRecord()
        self.notificationTime = convertThreeSeconds(getNotificationTimeInSeconds())
        self.notificationContent = getNotificationContents()
    }
    
    //get data in core data helper
    func getSmokeRecord() {
        var count: Int
        var smokingRecord: [SmokingRecord]
        
        smokingRecord = CoreData.lGetSmokingRecord("month")
        count = smokingRecord.count
        if count == 0 {
            
        } else {
            for index in 0...(count) {
                time.append(smokingRecord[index].time)
                timeInSeconds.append(smokingRecord[index].time.timeIntervalSince1970 % 86400)
                trigger.append(Trigger(rawValue: smokingRecord[index].trigger)!)
            }
        }
    }
    
//    func combineTimePointsInSeconds(timePoints2: [Double]) -> [Double] {
//        var timePoints2InPastMonth:[Double] = [3423.29482394, 2428.12313604355, 2455.46284604073]
//        //TODO: append all the data to this array
//        //sort this array
//        timePoints2InPastMonth.sort(<)
//        return timePoints2InPastMonth
//    }
    
    func getExpectation(array: [Double]) -> Double {
        var expectation: Double
        var sum: Double = 0
        
        if array.count == 0 {
            return 0
        } else {
            
            for index in 0...(array.count-1) {
                sum += array[index]
            }
            expectation = sum / Double(array.count)//off by one problem
        }
        
        return expectation
    }
    
    func getStdDeviation(array: [Double]) -> Double {
        var stdDeviation: Double
        var sumOfSquares: Double = 0.0
        var expectation: Double = getExpectation(array)
        
        if array.count == 0 {
            return 0
        } else {
            for index in 0...(array.count-1) {
                sumOfSquares += (array[index] - expectation)*(array[index] - expectation)
            }
            stdDeviation = sqrt(sumOfSquares/Double(array.count))
        }
        return stdDeviation
    }
    
    func getNotificationTimeInSeconds() -> (Double, Double, Double) {
        //TODO: design a mode to get notification time and return
        //5 minutes before the routine smoke everyday
        var timePoints = timeInSeconds
        var morningTime = [Double]()
        var afternoonTime = [Double]()
        var eveningTime = [Double]()
        var morningTrigger = [Trigger]()
        var afternoonTrigger = [Trigger]()
        var eveningTrigger = [Trigger]()

        var notificationTime1, notificationTime2, notificationTime3: Double
        
        if timePoints.count == 0 {
            
        } else {
            for index in 0...(timePoints.count - 1) {
                if timePoints[index] >= 28800 && timePoints[index] < 43200 {
                    morningTime.append(timePoints[index])
                    morningTrigger.append(trigger[index])
                    morningTriggerDict = TriggerCounter.triggerCounter(morningTrigger)
                } else if timePoints[index] >= 43200 && timePoints[index] < 64800 {
                    afternoonTime.append(timePoints[index])
                    afternoonTrigger.append(trigger[index])
                    afternoonTriggerDict = TriggerCounter.triggerCounter(afternoonTrigger)
                } else if timePoints[index] >= 64800 && timePoints[index] <= 82800 {
                    eveningTime.append(timePoints[index])
                    eveningTrigger.append(trigger[index])
                    eveningTriggerDict = TriggerCounter.triggerCounter(eveningTrigger)
                }
            }
        }
        
        notificationTime1 = getExpectation(morningTime) - 1.96 * getStdDeviation(morningTime)
        notificationTime2 = getExpectation(afternoonTime) - 1.96 * getStdDeviation(afternoonTime)
        notificationTime3 = getExpectation(eveningTime) - 1.96 * getStdDeviation(eveningTime)
        
        return (notificationTime1, notificationTime2, notificationTime3)
    }
    
    func convertThreeSeconds(timeInSecond: (timeInSecond1: Double, timeInSecond2: Double, timeInSecond3: Double)) -> (NSDate!, NSDate!, NSDate!) {
        var time1, time2, time3: NSDate!
        time1 = convertSecondsToTime(timeInSecond.timeInSecond1)
        time2 = convertSecondsToTime(timeInSecond.timeInSecond2)
        time3 = convertSecondsToTime(timeInSecond.timeInSecond3)
        return (time1, time2, time3)
    }
    
    func convertSecondsToTime(Seconds: Double) -> NSDate! {
        var days = NSDate().timeIntervalSince1970 / 86400
        var daysPlusSeconds = days*86400 + Seconds
        var date = NSDate(timeIntervalSince1970: daysPlusSeconds)
        return date
    }
    
    func getNotificationContents() -> (String, String, String) {
        //check the records in each period and sum up the most common trigger
        //in this period. And return the correspondent notification
        var notificationContent1 = ""
        var notificationContent2 = ""
        var notificationContent3 = ""
        
        notificationContent1 = "\(TriggerCounter.correspondingContents(TriggerCounter.getMajorTrigger(morningTriggerDict)))"
        notificationContent2 = "\(TriggerCounter.correspondingContents(TriggerCounter.getMajorTrigger(afternoonTriggerDict)))"
        notificationContent3 = "\(TriggerCounter.correspondingContents(TriggerCounter.getMajorTrigger(eveningTriggerDict)))"
        
        return (notificationContent1, notificationContent2, notificationContent3)
    }
    
    //update the notification in CoreData
    func updateNotification() -> Int {
        var ind1 = CoreData.lSaveNotification(notificationTime.0, content: notificationContent.0)
        var ind2 = CoreData.lSaveNotification(notificationTime.1, content: notificationContent.1)
        var ind3 = CoreData.lSaveNotification(notificationTime.2, content: notificationContent.2)
        if ind1 + ind2 + ind3 == 3 {
            return 1
        } else {
            return 0
        }
    }
}
