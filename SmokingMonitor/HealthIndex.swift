//
//  HealthIndex.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 2/4/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

class HealthIndex: NSObject {
    var suggestionList:[String] = [] //array which indicates what suggestions should it give
    
    
    func calculateIndex() -> Double {
        //TODO: design a model to calculate the index
        var index: Double = 100
        var HR: Double
        var BP: Double
        var Step: Double
        var Sleep: Double
        var Smoke: Double
        Smoke = decideSmoke()
        HR = decideHeartRate()
        BP = decideBloodPressure()
        Step = decideStep()
        Sleep = decideSleep()
        
        index = (HR + BP + Step + Sleep)/4
        return index
    }
    
    func getSmokeAmountThisWeek() -> Double {
        var smokeAmountThisWeek = 0.0
        return smokeAmountThisWeek
    }
    
    func getAverageSmokeAmountLastFiveWeeks() -> Double {
        var averageSmokeAmountLastFiveWeeks = 20.0
        return averageSmokeAmountLastFiveWeeks
    }
    
    func decideSmoke() -> Double {
        //TODO: design a model to decide how healthy is the person by smoking amount and improvement
        //If smoke amount increases 0-10% this week -30
        //If smoke amount increases 10-20% this week -50
        //If smoke amount increases more than 20% this week get 0
        //If smoke amount is more than the smoke target -50
        var _Smoke: Double = 100.0
        var smokeAmountThisWeek: Double = getSmokeAmountThisWeek()
        var averageSmokeAmountLastFiveWeeks: Double = getAverageSmokeAmountLastFiveWeeks()
        
        if smokeAmountThisWeek > (5 * 7.0) {//Smoke Target instead of 5
            _Smoke -= 50.0
        }
        
        if (smokeAmountThisWeek / averageSmokeAmountLastFiveWeeks > 1.20) {
            _Smoke = 0.0
        } else if (smokeAmountThisWeek / averageSmokeAmountLastFiveWeeks > 1.10) {
            _Smoke -= 50
        } else if (smokeAmountThisWeek / averageSmokeAmountLastFiveWeeks > 1.00) {
            _Smoke -= 30
        }
        
        if _Smoke < 0 {
            _Smoke = 0
        }
        
        return _Smoke
    }
    
    //get average heart rate for user in past 5 weeks excluding this week
    func getPastAverageHeartRate() -> Double {
        var pastAverageHeartRate = 0.0
        return pastAverageHeartRate
    }
    
    //get average heart rate up to now in this week
    func getCurrentAverageHeartRate() -> Double {
        var currentAverageHeartRate = 0.0
        return currentAverageHeartRate
    }
    
    func decideHeartRate() -> Double {
        //TODO: design a model to decide how healthy is the person
        //If heart rate increases 0-5% this week, give suggestions and -1
        //If heart rate increases 5-10% this week, give suggestions and -2
        //If heart rate decreases 0-5% this week, give suggestions -> good
        //If heart rate decreases 5-10% this week, be careful
        //Next Version: If heart rate pattern has strange turbulations??
        var pastAverageHeartRate = 0.0
        var currentAverageHeartRate = 0.0
        pastAverageHeartRate = getPastAverageHeartRate()
        currentAverageHeartRate = getCurrentAverageHeartRate()
        
        var _HeartRate: Double = 100.0
        if (currentAverageHeartRate/pastAverageHeartRate > 1.05) {
            _HeartRate -= 50.0
            addSuggestion(.heartRate_1)
        } else if (currentAverageHeartRate/pastAverageHeartRate > 1.0) {
            _HeartRate -= 20.0
            addSuggestion(.heartRate_1)
        } else if (currentAverageHeartRate/pastAverageHeartRate < 0.95) {
            _HeartRate -= 20.0
            addSuggestion(.heartRate_2)
        }
        
        return _HeartRate
    }
    
    func getPastAverageBloodPressure() -> Double {
        var pastAverageBloodPressure = 0.0
        return pastAverageBloodPressure
    }
    
    func getCurrentAverageBloodPressure() -> Double {
        var currentAverageBloodPressure = 0.0
        return currentAverageBloodPressure
    }
    
    func decideBloodPressure() -> Double {
        //TODO: design a model to decide how healthy is the person-BP
        //If current average blood pressure is > 160, give suggestions and -2
        //If current average blood pressure is > 140, give suggestions and -1
        //If average blood pressure increases 0-5%, give suggestions and -1
        //If average blood pressure increases 5-10%, give suggstions and -2
        //If average blood pressure drops 0
        
        var pastAverageBloodPressure = 0.0
        var currentAverageBloodPressure = 0.0
        pastAverageBloodPressure = getPastAverageBloodPressure()
        currentAverageBloodPressure = getCurrentAverageHeartRate()
        
        var _BloodPressure: Double = 100.0
        if currentAverageBloodPressure > 160 {
            _BloodPressure -= 50.0
            addSuggestion(.bloodPressure_2)
        } else if currentAverageBloodPressure > 140 {
            _BloodPressure -= 20.0
            addSuggestion(.bloodPressure_2)
        }
        if currentAverageBloodPressure/pastAverageBloodPressure > 1.05 {
            _BloodPressure -= 50.0
            addSuggestion(.bloodPressure_1)
        } else if (currentAverageBloodPressure/pastAverageBloodPressure > 1.00) {
            _BloodPressure -= 20.0
            addSuggestion(.bloodPressure_1)
        } else if (currentAverageBloodPressure/pastAverageBloodPressure < 0.90) {
            return min(0, max(-1, _BloodPressure+1))
        }
        
        return _BloodPressure
    }
    
    //get average steps in past 5 weeks
    func getPastAverageSteps() -> Int {
        var pastAverageSteps = 900
        return pastAverageSteps
    }
    
    func getCurrentAverageSteps() -> Int {
        var currentAverageSteps = 900
        return currentAverageSteps
    }
    
    func decideStep() -> Double {
        //TODO: design a model to decide how healthy is the person-Step
        //steps in this week decreases >5%, give suggestions -2
        //steps in this week decreases <5%, give suggestions -1
        //steps less than 1000 per day, give suggestions -1
        
        var pastAverageSteps:Double = 0
        var currentAverageSteps:Double = 0
        pastAverageSteps = Double(getPastAverageSteps())
        currentAverageSteps = Double(getCurrentAverageSteps())
        
        var _Steps: Double = 100.0
        if currentAverageSteps < 1000 {
            _Steps -= 30.0
            addSuggestion(.step_1)
        }
        if currentAverageSteps/pastAverageSteps < 0.95 {
            _Steps -= 50.0
            addSuggestion(.step_2)
        } else if currentAverageSteps/pastAverageSteps < 1.00 {
            _Steps -= 20.0
            addSuggestion(.step_2)
        }
        
        return _Steps
    }
    
    func decideSleep() -> Double {
        //TODO: design a model to decide how healthy is the person-Sleep
        return 100.0
    }
    
    func addSuggestion(newSuggestion: Suggestions) -> Bool {
        println(newSuggestion.rawValue)
        suggestionList.append(newSuggestion.rawValue)
        println(suggestionList)
        return true
    }
    
    //return the suggestion list array as required
    func getSuggestion() -> [String] {
        println(suggestionList.count)
        return suggestionList
    }

}
