//
//  HealthIndexCircle.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/22.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit
import QuartzCore

class HealthIndexCircle: UIView {
    //Background layer
    override func layoutSubviews() {
        super.layoutSubviews()
        CreateCircle()
    }
    func CreateCircle(){
        layoutRingLayer()
        layoutBackgroundLayer()
        updateLayerProperties()
    }
    var BackgroundLayer:CAShapeLayer!
    var BackgroundLayerColor:UIColor = UIColor.blackColor(){
        didSet{ updateLayerProperties()}
    }
    //Ring Layer
    var RingLayer:CAShapeLayer!
    var RingThickness:CGFloat = 2.0
    var RingColor = UIColor.blueColor()
    var RingProgress:CGFloat = 10.0/100.0{
        didSet{updateLayerProperties()}
    }
    var lineWidth:CGFloat = 1.0
    func layoutRingLayer() {
        if RingProgress == 0{
            if RingLayer != nil{
                RingLayer.strokeEnd = 0.0
            }
        }
        if RingLayer == nil{
            RingLayer = CAShapeLayer()
            layer.addSublayer(RingLayer)
            let dx = RingThickness / 2.0
            let rect = CGRectInset(bounds, dx, dx)
            let path = UIBezierPath(ovalInRect: rect)
            RingLayer.transform = CATransform3DMakeRotation(CGFloat(-(M_PI/2)), 0, 0, 1)
            RingLayer.strokeColor = RingColor.CGColor
            RingLayer.path = path.CGPath
            RingLayer.fillColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0).CGColor
            RingLayer.lineWidth = RingThickness
            RingLayer.strokeStart = 0.0
        }
        RingLayer.strokeEnd = RingProgress
        RingLayer.frame = layer.bounds
    }
    func layoutBackgroundLayer() {
        if BackgroundLayer == nil{
            BackgroundLayer = CAShapeLayer()
            layer.addSublayer(BackgroundLayer)
            let rect = CGRectInset(bounds, lineWidth/2.0, lineWidth/2.0)
            let path = UIBezierPath(ovalInRect:rect)
            BackgroundLayer.path = path.CGPath
            BackgroundLayer.fillColor = BackgroundLayerColor.CGColor
            BackgroundLayer.lineWidth = lineWidth
        }
        BackgroundLayer.frame = layer.bounds
    }
    func updateLayerProperties(){
        //Update the ring progress
        if RingLayer != nil {
            RingLayer.strokeEnd = RingProgress / 100.0
        }
        //Update the Color
        if BackgroundLayer != nil {
            BackgroundLayer.fillColor = BackgroundLayerColor.CGColor
        }
    }
    
}

