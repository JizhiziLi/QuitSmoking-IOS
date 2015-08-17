//
//  HealthKitCalculate.swift
//  SmokingMonitor
//
//  Created by Jizhizi Li on 10/02/2015.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitCalculate {
    
    
    let healthKitstore:HKHealthStore = HKHealthStore()
    var heartRateAverageInFiveWeeks:Double? = 0.0
    var heartRateAverageInOneWeek:Double? = 0.0
    var bloodPressureDiastolicAverageInFiveWeeks:Double? = 0.0
    var bloodPressureDiastolicAverageInOneWeek:Double? = 0.0
    var bloodPressureSystolicAverageInFiveWeeks:Double? = 0.0
    var bloodPressureSystolicAverageInOneWeek:Double? = 0.0
    
    
    //access the average data of heartRate within past five weeks
    func calculateHeartRateInFiveWeeks(completionHandler:(Double?, NSError?)->()){
        
        let startDate = NSDate(timeIntervalSinceNow: -24*60*60*35)
        let endDate = NSDate()
        
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .DiscreteAverage) { (query, result, error)-> Void in
            if result == nil{
                
                
                completionHandler(nil,error)
                return
                
            }
            
            var averageHeartRateInFiveWeeks = 0.0
            if let quantity = result.averageQuantity(){
                
                averageHeartRateInFiveWeeks = quantity.doubleValueForUnit(HKUnit(fromString: "count/min"))
                
                
                self.heartRateAverageInFiveWeeks = averageHeartRateInFiveWeeks
                
                
                //            println("maybe print here")
                //            println(self.heartRateAverageInFiveWeeks)
                
            }
            
            completionHandler(averageHeartRateInFiveWeeks,error)
            
        }
        healthKitstore.executeQuery(query)
        
    }
    
    
    
    //access the average data of heartRate within past one week
    
    func calculateHeartRateInOneWeek(completionHandler:(Double?, NSError?)->()){
        
        let startDate = NSDate(timeIntervalSinceNow: -24*60*60*7)
        let endDate = NSDate()
        
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .DiscreteAverage) { (query, result, error)-> Void in
            if result == nil{
                
                
                completionHandler(nil,error)
                return
                
            }
            
            var averageHeartRateInOneWeek = 0.0
            if let quantity = result.averageQuantity(){
                
                averageHeartRateInOneWeek = quantity.doubleValueForUnit(HKUnit(fromString: "count/min"))
                
                
                self.heartRateAverageInOneWeek = averageHeartRateInOneWeek
                
                
                //                println("maybe print here")
                //                println(self.heartRateAverageInOneWeek)
                
            }
            
            completionHandler(averageHeartRateInOneWeek,error)
            
        }
        healthKitstore.executeQuery(query)
        
    }
    
    
    
    //access the average data of bloodPressureDiastolic within past five weeks
    func calculateBloodPressureDiastolicInFiveWeeks(completionHandler:(Double?, NSError?)->()){
        
        let startDate = NSDate(timeIntervalSinceNow: -24*60*60*35)
        let endDate = NSDate()
        
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .DiscreteAverage) { (query, result, error)-> Void in
            if result == nil{
                
                
                completionHandler(nil,error)
                return
                
            }
            
            var averageBloodPressureDiastolicInFiveWeeks = 0.0
            if let quantity = result.averageQuantity(){
                
                averageBloodPressureDiastolicInFiveWeeks = quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit())
                
                
                self.bloodPressureDiastolicAverageInFiveWeeks = averageBloodPressureDiastolicInFiveWeeks
                
                
                
                
            }
            
            completionHandler(averageBloodPressureDiastolicInFiveWeeks,error)
            
        }
        healthKitstore.executeQuery(query)
        
    }
    
    
    
    
    
    //access the average data of bloodPressureDiastolic within past one week
    func calculateBloodPressureDiastolicInOneWeek(completionHandler:(Double?, NSError?)->()){
        
        let startDate = NSDate(timeIntervalSinceNow: -24*60*60*7)
        let endDate = NSDate()
        
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .DiscreteAverage) { (query, result, error)-> Void in
            if result == nil{
                
                
                completionHandler(nil,error)
                return
                
            }
            
            var averageBloodPressureDiastolicInOneWeek = 0.0
            if let quantity = result.averageQuantity(){
                
                averageBloodPressureDiastolicInOneWeek = quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit())
                
                
                self.bloodPressureDiastolicAverageInOneWeek = averageBloodPressureDiastolicInOneWeek
                
                
                
                
            }
            
            completionHandler(averageBloodPressureDiastolicInOneWeek,error)
            
        }
        healthKitstore.executeQuery(query)
        
    }
    
    
    
    
    
    
    
    //access the average data of bloodPressureSystolic within past five weeks
    func calculateBloodPressureSystolicInFiveWeeks(completionHandler:(Double?, NSError?)->()){
        
        let startDate = NSDate(timeIntervalSinceNow: -24*60*60*35)
        let endDate = NSDate()
        
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .DiscreteAverage) { (query, result, error)-> Void in
            if result == nil{
                
                
                completionHandler(nil,error)
                return
                
            }
            
            var averageBloodPressureSystolicInFiveWeeks = 0.0
            if let quantity = result.averageQuantity(){
                
                averageBloodPressureSystolicInFiveWeeks = quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit())
                self.bloodPressureSystolicAverageInFiveWeeks = averageBloodPressureSystolicInFiveWeeks
                
            }
            
            completionHandler(averageBloodPressureSystolicInFiveWeeks,error)
            
        }
        healthKitstore.executeQuery(query)
        
    }
    
    
    
    
    //access the average data of bloodPressureSystolic within past one week
    func calculateBloodPressureSystolicInOneWeek(completionHandler:(Double?, NSError?)->()){
        
        let startDate = NSDate(timeIntervalSinceNow: -24*60*60*7)
        let endDate = NSDate()
        
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .DiscreteAverage) { (query, result, error)-> Void in
            if result == nil{
                
                
                completionHandler(nil,error)
                return
                
            }
            
            var averageBloodPressureSystolicInOneWeek = 0.0
            if let quantity = result.averageQuantity(){
                
                averageBloodPressureSystolicInOneWeek = quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit())
                
                self.bloodPressureSystolicAverageInOneWeek = averageBloodPressureSystolicInOneWeek
                
                
            }
            
            completionHandler(averageBloodPressureSystolicInOneWeek,error)
            
        }
        healthKitstore.executeQuery(query)
        
    }
    
    
    
}

