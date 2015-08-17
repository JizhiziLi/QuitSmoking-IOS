//
//  UserSignUp.swift
//  SmokingMonitor
//
//  Created by Jizhizi Li on 10/02/2015.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit
import HealthKit

class UserSignUp {
    var Age: Int!
    var Gender: String
    var Weight: HKQuantitySample?
    var weight: String
    var Height: HKQuantitySample?
    var height: String
    var BloodType: NSString
    var UserName:NSString?
    var Password:NSString?
    var HeartRate: HKQuantitySample?
    var heartRate: String
    var BloodPressureDiastolic: HKQuantitySample?
    var bloodPressureDiastolic: String
    var BloodPressureSystolic: HKQuantitySample?
    var bloodPressureSystolic: String
    
    var HeartRateAverage: HKQuantitySample?
    var HeartRateAverageInFiveWeeks:Double?
    var HeartRateAverageInOneWeek:Double?
    
    var BloodPressureDiastolicAverage: HKQuantitySample?
    var BloodPressureDiastolicAverageInFiveWeeks:Double?
    var BloodPressureDiastolicAverageInOneWeek:Double?
    
    var BloodPreesureSystolicAverage: HKQuantitySample?
    var BloodPressureSystolicAverageInFiveWeeks:Double?
    var BloodPressureSystolicAverageInOneWeek:Double?
    
    var healthKitMaster = HealthKitMaster()
    var healthKitCalculate = HealthKitCalculate()
    
    
    init() {
        Age = 0
        Gender = ""
        Weight = nil
        Height = nil
        weight = ""
        height = ""
        BloodType = ""
        UserName = ""
        Password = ""
        HeartRate = nil
        heartRate = ""
        BloodPressureDiastolic = nil
        bloodPressureDiastolic = ""
        BloodPressureSystolic = nil
        bloodPressureSystolic = ""
        HeartRateAverage = nil
        HeartRateAverageInFiveWeeks = 0.0
        HeartRateAverageInOneWeek = 0.0
        BloodPressureDiastolicAverage = nil
        BloodPressureDiastolicAverageInFiveWeeks = 0.0
        BloodPressureDiastolicAverageInOneWeek = 0.0
        BloodPreesureSystolicAverage = nil
        BloodPressureSystolicAverageInFiveWeeks = 0.0
        BloodPressureSystolicAverageInOneWeek = 0.0
        
        
    }
    
    func Authorize() {
        healthKitMaster.authoriseHealthKit { (authorized, error) -> Void in
            if authorized{
                println("HealthKit authorization received.")
            } else {
                println("Healthkit authorization denied!")
                if error != nil{
                    println("\(error)")
                }
            }
        }
    }
    
    func updateHeight() {
        // 1. Construct an HKSampleType for Height
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
        
        // 2. Call the method to read the most recent Height sample
        healthKitMaster.readMostRecentSample(sampleType, completion: {
            (mostRecentHeight, error) -> Void in
            
            if( error != nil )
            {
                println("Error reading height from HealthKit Store: \(error.localizedDescription)")
                return;
            }
            
            var heightLocalizedString = "Unknown"
            self.Height = mostRecentHeight as? HKQuantitySample;
            // 3. Format the height to display it on the screen
            if let meters = self.Height?.quantity.doubleValueForUnit(HKUnit.meterUnit()) {
                let heightFormatter = NSLengthFormatter()
                heightFormatter.forPersonHeightUse = true;
                heightLocalizedString = heightFormatter.stringFromMeters(meters);
            }
            
            // 4. Update UI. HealthKit use an internal queue. We make sure that we interact with the UI in the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.height = heightLocalizedString
                println(self.height)
            });
        })
    }
    
    func updateWeight() {
        // 1. Construct an HKSampleType for weight
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        // 2. Call the method to read the most recent weight sample
        healthKitMaster.readMostRecentSample(sampleType, completion: { (mostRecentWeight, error) -> Void in
            if( error != nil ) {
                println("Error reading weight from HealthKit Store: \(error.localizedDescription)")
                return;
            }
            var weightLocalizedString = "Unknown"
            // 3. Format the weight to display it on the screen
            self.Weight = mostRecentWeight as? HKQuantitySample;
            if let kilograms = self.Weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo)) {
                let weightFormatter = NSMassFormatter()
                weightFormatter.forPersonMassUse = true;
                weightLocalizedString = weightFormatter.stringFromKilograms(kilograms)
            }
            // 4. Update UI in the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.weight = weightLocalizedString
                println(self.weight)
            })
        })
    }
    
    
    
    func updateHeartRate() {
        // 1. Construct an HKSampleType for heartRate
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
        
        healthKitMaster.readIntervalSampleInOneMonth(sampleType, completion: { (mostRecentHeartRate, error) -> Void in
            if( error != nil){
                println("Error reading heartRate from HealthKit Store \(error.localizedDescription)")
                return;
            }
            var heartRateLocalizedString = "Unknown"
            
            self.HeartRate = mostRecentHeartRate as? HKQuantitySample;
            if let bmp = self.HeartRate?.quantity.doubleValueForUnit(HKUnit(fromString: "count/min")){
                
                let heartRateFormatter = NSNumberFormatter()
                //??????Question here
                heartRateFormatter.isAccessibilityElement = true;
                heartRateLocalizedString = heartRateFormatter.stringForObjectValue(bmp)!
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.heartRate = heartRateLocalizedString
                
                println(self.heartRate)})
            
        })
        
        
    }
    
    
    
    
    
    
    
    
    func updateBloodPressureDiastolic() {
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic)
        healthKitMaster.readMostRecentSample(sampleType, completion: { (mostRecentBloodPressureDistolic, error) -> Void in
            if( error != nil){
                println("Error reading BloodPressureDiastolic from HealthKit Store \(error.localizedDescription)")
                return;
            }
            
            var bloodPressureDiastolicLocalizedString = "Unknown"
            
            self.BloodPressureDiastolic = mostRecentBloodPressureDistolic as? HKQuantitySample;
            if let distolic = self.BloodPressureDiastolic?.quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit()){
                
                let bloodPressureDiastolicFormatter = NSNumberFormatter()
                bloodPressureDiastolicFormatter.isAccessibilityElement = true;
                bloodPressureDiastolicLocalizedString = bloodPressureDiastolicFormatter.stringForObjectValue(distolic)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.bloodPressureDiastolic = bloodPressureDiastolicLocalizedString
                println(self.bloodPressureDiastolic)
            })
            
            
            
        })
        
    }
    
    func updateBloodPressureSystolic() {
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic)
        healthKitMaster.readMostRecentSample(sampleType, completion: { (mostRecentBloodPressureSystolic, error) -> Void in
            if( error != nil){
                println("Error reading BloodPressureSystolic from HealthKit Store \(error.localizedDescription)")
                return;
            }
            
            var bloodPressureSystolicLocalizedString = "Unknown"
            
            self.BloodPressureSystolic = mostRecentBloodPressureSystolic as? HKQuantitySample;
            if let systolic = self.BloodPressureSystolic?.quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit()){
                
                let bloodPressureSystolicFormatter = NSNumberFormatter()
                bloodPressureSystolicFormatter.isAccessibilityElement = true;
                bloodPressureSystolicLocalizedString = bloodPressureSystolicFormatter.stringForObjectValue(systolic)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.bloodPressureSystolic = bloodPressureSystolicLocalizedString
                println(self.bloodPressureSystolic)
            })
            
            
            
        })
        
    }
    
    
    
    
    func accessHeartRateAverageInFiveWeeks(){
        
        
        healthKitCalculate.calculateHeartRateInFiveWeeks({ (AverageForHeartRate, error) -> () in
            
            if( error != nil){
                println("Error reading heartRate from HealthKit Store \(error?.localizedDescription)")
                return;
            }
            var heartRateLocalizedString = "Unknown"
            
            self.HeartRateAverageInFiveWeeks = AverageForHeartRate
            
            if let bmp = self.HeartRateAverage?.quantity.doubleValueForUnit(HKUnit(fromString: "count/min")){
                
                let heartRateFormatter = NSNumberFormatter()
                //??????Question here
                heartRateFormatter.isAccessibilityElement = true;
                heartRateLocalizedString = heartRateFormatter.stringForObjectValue(bmp)!
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println(self.HeartRateAverageInFiveWeeks)
                
            })
            
        })
        
        
        
    }
    
    
    
    func accessHeartRateAverageInOneWeek(){
        
        
        healthKitCalculate.calculateHeartRateInOneWeek({ (AverageForHeartRate, error) -> () in
            
            if( error != nil){
                println("Error reading heartRate from HealthKit Store \(error?.localizedDescription)")
                return;
            }
            var heartRateLocalizedString = "Unknown"
            
            self.HeartRateAverageInOneWeek = AverageForHeartRate
            
            if let bmp = self.HeartRateAverage?.quantity.doubleValueForUnit(HKUnit(fromString: "count/min")){
                
                let heartRateFormatter = NSNumberFormatter()
                //??????Question here
                heartRateFormatter.isAccessibilityElement = true;
                heartRateLocalizedString = heartRateFormatter.stringForObjectValue(bmp)!
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println(self.HeartRateAverageInOneWeek)
                
            })
            
        })
        
        
        
    }
    
    
    func accessBloodPressureDiastolicAverageInFiveWeeks() {
        
        healthKitCalculate.calculateBloodPressureDiastolicInFiveWeeks({ (AverageForBloodPressureDiastolic,error) -> () in
            if( error != nil){
                println("Error reading BloodPressureDiastolic from HealthKit Store \(error?.localizedDescription)")
                return;
            }
            
            var bloodPressureDiastolicLocalizedString = "Unknown"
            
            self.BloodPressureDiastolicAverageInFiveWeeks = AverageForBloodPressureDiastolic
            
            
            if let distolic = self.BloodPressureDiastolicAverage?.quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit()){
                
                let bloodPressureDiastolicFormatter = NSNumberFormatter()
                bloodPressureDiastolicFormatter.isAccessibilityElement = true;
                bloodPressureDiastolicLocalizedString = bloodPressureDiastolicFormatter.stringForObjectValue(distolic)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println(self.BloodPressureDiastolicAverageInFiveWeeks)
            })
            
            
            
        })
        
    }
    
    
    
    
    func accessBloodPressureDiastolicAverageInOneWeek() {
        
        healthKitCalculate.calculateBloodPressureDiastolicInOneWeek({ (AverageForBloodPressureDiastolic,error) -> () in
            if( error != nil){
                println("Error reading BloodPressureDiastolic from HealthKit Store \(error?.localizedDescription)")
                return;
            }
            
            var bloodPressureDiastolicLocalizedString = "Unknown"
            
            self.BloodPressureDiastolicAverageInOneWeek = AverageForBloodPressureDiastolic
            
            
            if let distolic = self.BloodPressureDiastolicAverage?.quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit()){
                
                let bloodPressureDiastolicFormatter = NSNumberFormatter()
                bloodPressureDiastolicFormatter.isAccessibilityElement = true;
                bloodPressureDiastolicLocalizedString = bloodPressureDiastolicFormatter.stringForObjectValue(distolic)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println(self.BloodPressureDiastolicAverageInOneWeek)
            })
            
            
            
        })
        
    }
    
    
    
    
    
    
    func accessBloodPressureSystolicAverageInFiveWeeks() {
        
        healthKitCalculate.calculateBloodPressureSystolicInFiveWeeks({ (AverageForBloodPressureSystolic,error) -> () in
            if( error != nil){
                println("Error reading BloodPressureSystolic from HealthKit Store \(error?.localizedDescription)")
                return;
            }
            
            var bloodPressureSystolicLocalizedString = "Unknown"
            
            self.BloodPressureSystolicAverageInFiveWeeks = AverageForBloodPressureSystolic
            
            
            if let systolic = self.BloodPreesureSystolicAverage?.quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit()){
                
                let bloodPressureSystolicFormatter = NSNumberFormatter()
                bloodPressureSystolicFormatter.isAccessibilityElement = true;
                bloodPressureSystolicLocalizedString = bloodPressureSystolicFormatter.stringForObjectValue(systolic)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println(self.BloodPressureSystolicAverageInFiveWeeks)
            })
            
            
            
        })
        
    }
    
    
    
    func accessBloodPressureSystolicAverageInOneWeek() {
        
        healthKitCalculate.calculateBloodPressureSystolicInOneWeek({ (AverageForBloodPressureSystolic,error) -> () in
            if( error != nil){
                println("Error reading BloodPressureSystolic from HealthKit Store \(error?.localizedDescription)")
                return;
            }
            
            var bloodPressureSystolicLocalizedString = "Unknown"
            
            self.BloodPressureSystolicAverageInOneWeek = AverageForBloodPressureSystolic
            
            
            if let systolic = self.BloodPreesureSystolicAverage?.quantity.doubleValueForUnit(HKUnit.millimeterOfMercuryUnit()){
                
                let bloodPressureSystolicFormatter = NSNumberFormatter()
                bloodPressureSystolicFormatter.isAccessibilityElement = true;
                bloodPressureSystolicLocalizedString = bloodPressureSystolicFormatter.stringForObjectValue(systolic)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println(self.BloodPressureSystolicAverageInOneWeek)
            })
            
        })
        
    }
    
    
    
}
