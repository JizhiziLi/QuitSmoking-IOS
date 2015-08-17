//
//  DataVisualizationView.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/2/9.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class DataVisualizationView: UIView {
    //Data
    private var data = NSMutableArray()
    //Context Layout
    private var context:CGContextRef?
    //Graph Size
    private var graphWidth:CGFloat = 0
    private var graphHeight:CGFloat = 0
    private var paddingTop:CGFloat = 30.0
    //Graph Style
    var axisBackgroundColor:UIColor!
    var lowPoint:Int = 0
    var highPoint:Int = 0
    var labelFont = UIFont.systemFontOfSize(12)
    var labelColor = UIColor.whiteColor()
    private var labelMargetTop:CGFloat = 15.0
    //Layout
    var marginLeftAndRight:CGFloat = 20
    //Axis Style
    var axisLineColor:UIColor!
    //Trigger Line
    var TriggerLineWidth:CGFloat = 0
    var TriggerLineHeight:CGFloat = 0
    private var locationPercentage:Float = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(frame:CGRect,data:NSArray){
        super.init(frame:frame)
        backgroundColor = UIColor.whiteColor()
        self.data = data.mutableCopy() as! NSMutableArray
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        var context:CGContextRef
        drawBackground(rect)
        for i in 0...data.count-1{
            locationPercentage = (data[i].objectForKey("value")as! Float)/1440.0
            println(locationPercentage)
            drawTriggerLine(rect,location:locationPercentage)
        }
    }
    //The function draw the background
    func drawBackground(rect:CGRect){
        // Graph Size
        context = UIGraphicsGetCurrentContext()
        graphWidth = rect.size.width - marginLeftAndRight
        graphHeight = rect.size.height - paddingTop
        // Axis line
        drawAxis(rect,lineColor:axisLineColor.CGColor)
        // Axis Label
        let zeroLabel = drawLabel("0:00")
        zeroLabel.frame = CGRectMake(marginLeftAndRight, graphHeight+labelMargetTop, 50.0, 15.0)
        addSubview(zeroLabel)
        let tLabel = drawLabel("12:00")
        // TO DO Padding
        tLabel.frame = CGRectMake(marginLeftAndRight+100, graphHeight+labelMargetTop, 50.0, 15.0)
        addSubview(tLabel)
        let fLabel = drawLabel("23:59")
        fLabel.frame = CGRectMake(marginLeftAndRight+200, graphHeight+labelMargetTop, 50.0, 15.0)
        addSubview(fLabel)
    }
    //Drawing Triggr Line
    func drawTriggerLine(rect:CGRect,location:Float){
        let triggerLine = CGPathCreateMutable()
        CGPathMoveToPoint(triggerLine,nil,rect.size.width * CGFloat(location)+marginLeftAndRight,graphHeight-20.0)
        CGPathAddLineToPoint(triggerLine,nil,rect.size.width * CGFloat(location)+marginLeftAndRight, graphHeight)
        CGContextAddPath(context, triggerLine)
        CGContextSetStrokeColorWithColor(context,UIColor.redColor().CGColor)
        CGContextStrokePath(context)
    }
    func drawAxis(rect:CGRect,lineColor:CGColorRef){
        context = UIGraphicsGetCurrentContext()
        let axisPath = CGPathCreateMutable()
        CGPathMoveToPoint(axisPath,nil, marginLeftAndRight,graphHeight)
        CGPathAddLineToPoint(axisPath,nil,graphWidth, graphHeight)
        CGContextAddPath(context, axisPath)
        CGContextSetStrokeColorWithColor(context,lineColor)
        CGContextStrokePath(context)
    }
    func drawLabel(title:NSString)->UILabel{
        let label = UILabel(frame: CGRectZero)
        label.text = title as String
        label.font = labelFont
        label.textColor = labelColor
        label.textAlignment = NSTextAlignment.Center
        label.sizeToFit()
        return label
    }
    // locate the trigger on timeline
    // return Int to describe the percentage
    func locatetheTrigger(index:Int)->Int{
        var percentage:Int = 0
        var timePoint:Int = 0
        timePoint = (data[index].objectForKey("value")as! NSNumber).integerValue
        percentage = timePoint % 24
        return percentage
    }

}
