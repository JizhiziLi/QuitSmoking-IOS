//
//  Date.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 1/26/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class Date: NSObject {
    class func from(#year:Int, month:Int, day:Int) -> NSDate {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        var gregorian = NSCalendar(identifier:NSGregorianCalendar)
        var date = gregorian?.dateFromComponents(c)
        return date!
    }
    
    class func parse(dateStr:String, format:String="yyyy-MM-dd") -> NSDate {
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format
        return dateFmt.dateFromString(dateStr)!
    }
}

class Week: Equatable, Hashable {
    var weekFirstDay = Date.from(year: 2014, month: 12, day: 20)
    var weekLastDay = Date.from(year: 2014, month: 12, day: 27)
    
    var hashValue: Int {
        get {
            return "\(self.weekFirstDay)".hashValue
        }
    }
    
    init(newWeekFirstDay: NSDate, newWeekLastDay: NSDate) {
        self.weekFirstDay = newWeekFirstDay
        self.weekLastDay = newWeekLastDay
        println("\(self.weekFirstDay), \(self.weekLastDay)")
    }
    
    init(newWeekFirstDay: NSDate) {
        self.weekFirstDay = newWeekFirstDay
        println("\(self.weekFirstDay)")
    }
}

func == (lhs: Week, rhs: Week) -> Bool {
    if lhs.weekFirstDay == rhs.weekFirstDay {
        return true
    } else {
        return false
    }
}

class Month: Equatable, Hashable{
    var monthFirstDay = Date.parse("2014-12-01", format: "yyyy-MM-dd")
    var monthLastDay = Date.parse("2014-12-31", format: "yyyy-MM-dd")
    
    var hashValue: Int {
        get {
            return "\(self.monthFirstDay)".hashValue
        }
    }
    
    init(newMonthFirstDay: NSDate, newMonthLastDay: NSDate) {
        self.monthFirstDay = newMonthFirstDay
        self.monthLastDay = newMonthLastDay
        println("\(self.monthFirstDay), \(self.monthLastDay)")
    }
    
    init(newMonthFirstDay: NSDate) {
        self.monthFirstDay = newMonthFirstDay
        println("\(self.monthFirstDay)")
    }
}

func == (lhs: Month, rhs: Month) -> Bool {
    if lhs.monthFirstDay == rhs.monthFirstDay {
        return true
    } else {
        return false
    }
}
