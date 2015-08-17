//
//  Trigger.swift
//  SmokingMonitor
//
//  Created by Raymond Shi on 1/25/15.
//  Copyright (c) 2015 futureStar. All rights reserved.
//

import UIKit

enum Trigger: String, RawRepresentable{
    case coffee = "Coffee"
    case stress = "Stress"
    case workBreaks = "Work Breaks"
    case drinking = "Drinking"
    case parties = "Parties"
    case smokeBuddies = "Smoke Buddies"
    case traffic = "Traffic"
    case afterMeals = "After Meals"
    case afterSex = "After Sex"
    case spareTime = "Spare Time"
    
    //TODO: How to dynamically define this enum
}