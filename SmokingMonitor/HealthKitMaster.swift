//
//  HealthKitMaster.swift
//  SmokingMonitor
//
//  Created by Jizhizi Li on 10/02/2015.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitMaster{
    let kUnknownString = "Unknown"
    let healthKitStore:HKHealthStore = HKHealthStore()
    
 
    //Request authorisation from Hk Store && Decide what to read from or write to HK store
    func authoriseHealthKit(completion: ((success:Bool, error:NSError!)->Void)!) {
        
        //Choose types want to read from HK Store
        
        let healthKitTypesToRead = NSSet(array: [
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth),
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType),
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic)
            // HKObjectType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierBloodPressure)
            ])
        //Choose types want to write to HK Store
        
        let healthKitTypesToWrite = NSSet(array: [
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
            //  HKObjectType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierBloodPressure)
            ])
        
        //Return error when the HK store is not available for the device(for instance, iPad)
        if !HKHealthStore.isHealthDataAvailable(){
            let error = NSError(domain: "futureStar.appname", code: 2, userInfo:[NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if(completion != nil) {
                completion(success:false,error:error)
            }
            return
        }
        
        //Request HealthKit authorization
        healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToWrite as Set<NSObject>, readTypes: healthKitTypesToRead as Set<NSObject>) { (success, error) -> Void in
            if completion != nil {
                completion(success:success,error:error)
            }
        }
    }
    
    //Read profile information from user HK Store
    func readProfile()->(age:Int!, biologicalsex:HKBiologicalSexObject?, bloodtype:HKBloodTypeObject?) {
        var error:NSError?
        var age:Int!
        //Request birthday and calculate age
        if let birthday = healthKitStore.dateOfBirthWithError(&error) {
            let today = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let differenceComponents = NSCalendar.currentCalendar().components(.YearCalendarUnit, fromDate: birthday, toDate: today, options: NSCalendarOptions(0))
            
            age = differenceComponents.year
        }
        if error != nil {
            println("Error occurs when reading Birthday: \(error)")
        }
        //Read biological sex
        var biologicalSex:HKBiologicalSexObject? = healthKitStore.biologicalSexWithError(&error)
        if error != nil {
            println("Error occurs when reading Biological Sex: \(error)")
        }
        //Read blood type
        
        var bloodType:HKBloodTypeObject? = healthKitStore.bloodTypeWithError(&error)
        if error != nil {
            println("Error occurs when reading Blood Type: \(error)")
        }
        //Return the information in a tuple
        return(age, biologicalSex, bloodType)
    }
    
    func convertHKSexToString(biologicalSex: HKBiologicalSex?) -> String {
        var biologicalSexText = kUnknownString
        
        if biologicalSex != nil {
            switch biologicalSex! {
            case .Female:
                biologicalSexText = "Female"
            case .Male:
                biologicalSexText = "Male"
            default:
                break
            }
        }
        
        return biologicalSexText
    }
    
    func convertHKBloodTypeToString(bloodType:HKBloodType?) -> String {
        var bloodTypeText = kUnknownString
        
        if bloodType != nil {
            switch( bloodType! ) {
            case .APositive:
                bloodTypeText = "A+"
            case .ANegative:
                bloodTypeText = "A-"
            case .BPositive:
                bloodTypeText = "B+"
            case .BNegative:
                bloodTypeText = "B-"
            case .ABPositive:
                bloodTypeText = "AB+"
            case .ABNegative:
                bloodTypeText = "AB-"
            case .OPositive:
                bloodTypeText = "O+"
            case .ONegative:
                bloodTypeText = "O-"
            default:
                break;
            }
        }
        return bloodTypeText;
    }
    
    
    //Read the wanted sample from HK Store
    func readMostRecentSample(sampleType:HKSampleType, completion: ((HKSample!,NSError!)->Void)!) {
        
        //Build the predicate
        let past = NSDate.distantPast() as! NSDate
        let now = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate: now, options: .None)
        //Build the sort descriptor to return samples in descending order
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        //Limit the number of samples returned by query(here set to just 1 which means the most recent)
        let limit = 1
        //Build samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
            {(sampleQuery, results, error) -> Void in
                if let queryError = error{
                    completion(nil,error)
                    return
                }
                //Get the first sample
                let mostRecentSample = results.first as? HKQuantitySample
                //Execute the completion closure
                if completion != nil {
                    completion(mostRecentSample,nil)
                }
        }
        //Execute the Query
        self.healthKitStore.executeQuery(sampleQuery)
    }
    
    
    
    
    
    //Read the data in past detail time
    func readIntervalSampleInOneMonth(sampleType:HKSampleType, completion: ((HKSample!,NSError!)->Void)!) {
        
        //Build the predicate
        
        //make the past time be one month ago
        let past = NSDate(timeIntervalSinceNow: -24*60*60*3)
        
        let now = NSDate()
        
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate: now, options: .None)
        //Build the sort descriptor to return samples in descending order
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        //Limit the number of samples returned by query(here set to just 1 which means the most recent)
        let limit = mostRecentPredicate.accessibilityElementCount()
        
        // let limit = 100
        //Build samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
            {(sampleQuery, results, error) -> Void in
                if let queryError = error{
                    completion(nil,error)
                    return
                }
                
                //the amount of data within one month
                let amount = results.reverse().count
                
                //Get the first sample
                let mostRecentSample = results.first as? HKQuantitySample
                let secondRecentSample = results.last as? HKQuantitySample
                
                if amount == 0{
                    println("have no data in heartRate")
                }
                else{
                    let try = results.reverse()[amount-1] as? HKQuantitySample
                    let allRecentSample = results.reverse() as Array
                    
                    
                    if completion != nil {
                        //completion(mostRecentSample,nil)
                        //completion(secondRecentSample,nil)
                        completion(try,nil)
                    }
                }
                
                
                
                
        }
        //Execute the Query
        self.healthKitStore.executeQuery(sampleQuery)
    }
    
    
}