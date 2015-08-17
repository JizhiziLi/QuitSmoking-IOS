//
//  RegisterTopView.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/28.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class RegisterTopView: UIView {
    var CircleMarginLeft:CGFloat!
    var CirclePaddingLeft:CGFloat!
    var CircleMarginTop:CGFloat!
    var CircleStrokeColor:UIColor!
    var CircleOneFillinColor:UIColor!
    var CircleTwoFillinColor:UIColor!
    var CircleThreeFillinColor:UIColor!
    var CirclePathWidth:CGFloat!
    var CircleR:CGFloat!
    var LinePathWidth:CGFloat!
    var LineStartMarginLeft:CGFloat!
    var LineEndMarginLeft:CGFloat!
    var LineMarginTop:CGFloat!
    var LineStrokeColor:UIColor!
    override func drawRect(rect: CGRect) {
        //DrawingLine
        var contextLine = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(contextLine,LinePathWidth)
        CGContextSetStrokeColorWithColor(contextLine,LineStrokeColor.CGColor)
        CGContextMoveToPoint(contextLine,LineStartMarginLeft, LineMarginTop)
        CGContextAddLineToPoint(contextLine,LineEndMarginLeft, LineMarginTop)
        CGContextStrokePath(contextLine)
        //DrawingCircles
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,CirclePathWidth)
        CGContextSetStrokeColorWithColor(context,
            CircleStrokeColor.CGColor)
        var CircleOne = CGRectMake(CircleMarginLeft,CircleMarginTop,CircleR,CircleR)
        CGContextAddEllipseInRect(context, CircleOne)
        CGContextStrokePath(context)
        CGContextSetFillColorWithColor(context,CircleOneFillinColor.CGColor)
        CGContextFillEllipseInRect(context,CircleOne)
        var CircleTwo = CGRectMake(CircleMarginLeft+CirclePaddingLeft,CircleMarginTop,CircleR,CircleR)
        CGContextAddEllipseInRect(context, CircleTwo)
        CGContextStrokePath(context)
        CGContextSetFillColorWithColor(context,CircleTwoFillinColor.CGColor)
        CGContextFillEllipseInRect(context,CircleTwo)
        var CircleThree = CGRectMake(CircleMarginLeft+2*CirclePaddingLeft,CircleMarginTop,CircleR,CircleR)
        CGContextAddEllipseInRect(context, CircleThree)
        CGContextStrokePath(context)
        CGContextSetFillColorWithColor(context,CircleThreeFillinColor.CGColor)
        CGContextFillEllipseInRect(context,CircleThree)
        
        
    }
    
}

