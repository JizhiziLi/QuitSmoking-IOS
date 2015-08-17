//
//  GraphViewController.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/2/9.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    var dataVisualizationView:DataVisualizationView!
    var graphView:GraphView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //To Do Updata the data
        let TriggerData = [
            ["label" : "Mon",   "value" : 234.0],
            ["label" : "Tues",  "value" : 1000.0],
            ["label" : "Weds",  "value" :712.0],
            ["label" : "Thurs", "value" : 600.0],
            ["label" : "Fri",   "value" : 0.0],
            ["label" : "Sat",   "value" : 150.0],
            ["label" : "Sun",   "value" : 450.0],
            ] as NSArray
        dataVisualizationView = DataVisualizationView(frame:CGRectMake(0,0,view.bounds.width,view.bounds.height*0.3),data:TriggerData)
        dataVisualizationView.backgroundColor = UIColor.blueColor()
        dataVisualizationView.axisLineColor = UIColor.whiteColor()
        view.addSubview(dataVisualizationView)
        let smokingData = [
        ["label" : "Sum", "value" : 12],
        ["label" : "PeakTime",  "value" :"12:40"],
        ["label" : "PeakAmount",  "value" :2],
        ["label" : "majorTrigger", "value" : "break"]
        ]as NSArray
        //To Do Download an array
        graphView = GraphView(frame:CGRectMake(0,view.bounds.height*0.3, view.bounds.width, view.bounds.height*0.7),data:smokingData)
        graphView.backgroundColor = UIColor.redColor()
        view.addSubview(graphView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
