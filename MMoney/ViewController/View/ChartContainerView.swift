//
//  ChartContainerView.swift
//  MMoney
//
//  Created by yuandalu on 16/5/16.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class ChartContainerView: UIView {
    
    var charts:[ChartView] = []
    
    lazy var effectView : UIVisualEffectView = {
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = self.frame
        visualEffectView.alpha = 0
        return visualEffectView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex:0x222645)
        self.addSubview(effectView)
    }
    
    func loadData(type:[chartType],percent:[CGFloat]){
        let width = MainScreenWidth*0.213
        let marge = (MainScreenWidth - width * CGFloat(type.count)) / CGFloat(type.count+1)
        for (i,item) in type.enumerate() {
            let chart = ChartView.init(frame: CGRect(x: marge+CGFloat(i)*(marge+width), y: (self.bounds.height-width*1.375)/2, width: width, height: width*1.375))
            chart.loadData(item,percent:percent[i])
            
            charts.append(chart)
            self.addSubview(chart)
        }
        self.bringSubviewToFront(effectView)
    }
    
    func reloadPercent(percents:[CGFloat]){
        for (i,percent) in percents.enumerate() {
            charts[i].reloadPercent(percent)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
