//
//  LayoutClass.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/20.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class Layout {
    //Button
    var LongButtonHeight:CGFloat!
    //TextField
    var textFieldHeight:CGFloat!
    //Font
    var titleSize:CGFloat!
    var HelveticaTitle:String!
    //Margin
    var marginLeft:CGFloat!
    init(){
        //TextField
        textFieldHeight = 31.0
        //Title
        titleSize = 14.0
        HelveticaTitle = "Helvetica"
        //Margin
        marginLeft = 40.0
        LongButtonHeight = 35.0
    }
}
