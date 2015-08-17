//
//  GraphView.swift
//  SmokingMonitor
//
//  Created by Minjiexie on 15/1/29.
//  Copyright (c) 2015年 futureStar. All rights reserved.
//

import UIKit

class GraphView: UIView {
    //Data
    private var data = NSMutableArray()
    init(frame:CGRect,data:NSArray){
        super.init(frame:frame)
        self.data = data.mutableCopy() as! NSMutableArray
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func drawRect(rect: CGRect) {
    }
}
