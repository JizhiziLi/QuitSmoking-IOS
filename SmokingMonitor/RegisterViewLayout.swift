//
//  RegisterViewLayout.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/22.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class RegisterViewLayout:Layout {
    var textFieldMarginTop:CGFloat!
    var textFieldTitleMarginTop:CGFloat!
    var iconWidth:CGFloat!
    var labelNameMarginLeft:CGFloat!
    var textFieldPadding:CGFloat!
    override init(){
        textFieldMarginTop = 10.0
        textFieldTitleMarginTop = 50.0
        iconWidth = 25.0
        labelNameMarginLeft = 10.0
        textFieldPadding = 45.0
        
    }
}