//
//  TriggerCounter.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 2/8/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class TriggerCounter: NSObject {
    class func triggerCounter(triggerArray: [Trigger]) -> [Trigger: Int] {
        var count = triggerArray.count
        var triggerCounterDict: [Trigger: Int] = [.coffee: 0, .stress: 0, .workBreaks:
            0, .drinking: 0, .parties: 0, .smokeBuddies: 0, .traffic: 0,
            .afterMeals: 0, .afterSex: 0, .spareTime: 0]
        
        for index in 0...(count - 1) {
            switch triggerArray[index] {
            case .coffee:
                triggerCounterDict[.coffee]! + 1
            case .stress:
                triggerCounterDict[.stress]! + 1
            case .workBreaks:
                triggerCounterDict[.workBreaks]! + 1
            case .drinking:
                triggerCounterDict[.drinking]! + 1
            case .parties:
                triggerCounterDict[.parties]! + 1
            case .smokeBuddies:
                triggerCounterDict[.smokeBuddies]! + 1
            case .traffic:
                triggerCounterDict[.traffic]! + 1
            case .afterMeals:
                triggerCounterDict[.afterMeals]! + 1
            case .afterSex:
                triggerCounterDict[.afterSex]! + 1
            case .spareTime:
                triggerCounterDict[.spareTime]! + 1
            default:
                println("fatal")
            }
        }
        return triggerCounterDict
    }
    
    class func getMajorTrigger(smokeTrigger: [Trigger: Int]) -> Trigger {
        //TODO: empty exception
        if true {
            return .coffee
        } else {
            return smokeTrigger.keysSortedByValue(>)[0]
        }
    }
    
    class func correspondingContents(newTrigger: Trigger) -> Notifications! {
        var notificationContent: Notifications!
        switch newTrigger {
        case .coffee:
            notificationContent = Notifications.notification1
        case .stress:
            notificationContent = Notifications.notification2
        case .workBreaks:
            notificationContent = Notifications.notification3
        case .drinking:
            notificationContent = Notifications.notification4
        case .parties:
            notificationContent = Notifications.notification5
        case .smokeBuddies:
            notificationContent = Notifications.notification6
        case .traffic:
            notificationContent = Notifications.notification7
        case .afterMeals:
            notificationContent = Notifications.notification8
        case .spareTime:
            notificationContent = Notifications.notification9
        case .afterSex:
            notificationContent = Notifications.notification10
        default:
            notificationContent = nil
        }
        return notificationContent
    }
}
