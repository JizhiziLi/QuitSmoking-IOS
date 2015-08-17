//
//  CoreDataHelper.swift
//  SmokingMonitor
//
//  Created by 647 on 15/2/6.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper{
    
    let managedContext : NSManagedObjectContext
    
    init(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext!
    }
    
    //local register, input uesrname and password
    //if username already exist in database, return 2
    //if fail to save, return 0. if succeed, return 1
    func lRegister(name : String, pwd : String) -> Int{
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        let predicate = NSPredicate(format: "userName = %@", name)
        fetchRequest.predicate = predicate
        var error : NSError?
        let fetchResult = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [UserInfo]
        if(fetchResult.count != 0){
            return 2
        }
        else{
            let entity = NSEntityDescription.entityForName("UserInfo", inManagedObjectContext: managedContext)
            let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! UserInfo
            user.userName = name
            user.password = pwd
            if !managedContext.save(&error){
                return 0
            }
            else{
                return 1
            }
        }
    }
    
    //local login input username and password
    //if exist return 1. else return 0
    func lLogin(name : String, pwd : String) -> Int{
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        let predicate = NSPredicate(format: "userName = %@ AND password = %@", name, pwd)
        fetchRequest.predicate = predicate
        var error : NSError?
        let fetchResult = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [UserInfo]
        if fetchResult.count == 1{
            return 1
        }
        else{
            return 0
        }
    }
    
    //local save smoking record, input trigger
    //automatically record current time and update status as "n"
    //if fail return 0, if succeed return 1
    func lSaveSmokingRecord(time: NSDate, trigger : String) -> Int{
        let entity = NSEntityDescription.entityForName("SmokingRecord", inManagedObjectContext: managedContext)
        let record = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! SmokingRecord
        record.time = time
        record.trigger = trigger
        record.update = "n"
        var error : NSError?
        if !managedContext.save(&error){
            return 0
        }
        else{
            return 1
        }
    }
    
    //local get smoking record, input time interval("day", "week", "month")
    //return smoking record as array
    func lGetSmokingRecord(interval : String) -> [SmokingRecord]{
        let fetchRequest = NSFetchRequest(entityName: "SmokingRecord")
        var timeInterval : NSTimeInterval
        switch interval{
        case "day" :
            timeInterval = -3600*24
        case "week" :
            timeInterval = -3600*24*7
        case "month" :
            timeInterval = -3600*24*30
        default:
            timeInterval = 0
        }
        let beginDate = NSDate(timeIntervalSinceNow: timeInterval)
        let predicate = NSPredicate(format: "time >= %@", beginDate)
        fetchRequest.predicate = predicate
        var error : NSError?
        let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [SmokingRecord]
        return fetchResults
    }
    
    //local save notification, input time and content
    //if fail return 0. if succeed return 1
    func lSaveNotification(time : NSDate, content : String) -> Int{
        let entity = NSEntityDescription.entityForName("Notification", inManagedObjectContext: managedContext)
        let notification = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Notification
        notification.time = time
        notification.content = content
        var error : NSError?
        if !managedContext.save(&error){
            return 0
        }
        else{
            return 1
        }
    }
}
