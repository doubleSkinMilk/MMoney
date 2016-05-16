//
//  ChartView.swift
//  MMoney
//
//  Created by yuandalu on 16/5/16.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

enum chartType:String {
    
    case food = "Food"
    case shopping = "Shopping"
    case other = "Other"
    
    func color() -> UIColor {
        switch self {
        case .food:
            return UIColor(hex: 0xEE4D69)
        case .shopping:
            return UIColor(hex: 0xF8B246)
        case .other:
            return UIColor(hex: 0x5BC4F4)
        }
    }
}

class ChartView: UIView {

    lazy var firstLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        let diameter = self.bounds.width
        layer.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeColor = UIColor.whiteColor().CGColor
        layer.lineWidth = 2
        
        let center = CGPoint(x: diameter/2, y: diameter/2)
        let path = UIBezierPath(arcCenter: center, radius: diameter/2, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        layer.path = path.CGPath
        return layer
    }()
    
    lazy var percentLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        let diameter = self.bounds.width
        layer.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineWidth = 10
        layer.lineCap = kCALineCapRound
        
        let center = CGPoint(x: diameter/2, y: diameter/2)
        let path = UIBezierPath(arcCenter: center, radius: diameter/2, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(2*M_PI-M_PI_2), clockwise: true)
        layer.path = path.CGPath
        return layer
    }()

    lazy var itemNamelabel : UILabel  = {
        let diameter = self.bounds.width
        let label = UILabel.init(frame: CGRect(x: 0, y: diameter, width: diameter, height: self.bounds.height-diameter))
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(15)
        label.textAlignment = .Center
        return label
    }()
    
    var lastPercent:NSTimeInterval = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(firstLayer)
        self.layer.addSublayer(percentLayer)
        self.addSubview(itemNamelabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(type:chartType,percent:CGFloat){
        itemNamelabel.text = type.rawValue
        percentLayer.strokeColor = type.color().CGColor
        reloadPercent(percent)
    }
    
    //MARK: - reloadPercent
    
    func reloadPercent(percent:CGFloat){
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.beginTime = 0
        pathAnimation.duration = 0.4
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pathAnimation.fromValue = lastPercent
        pathAnimation.toValue = percent
        
        let pathAnimation1 = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation1.beginTime = 0.4
        pathAnimation1.duration = 0.2
        pathAnimation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        let pathAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation2.beginTime = 0.6
        pathAnimation2.duration = 0.3
        pathAnimation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        if(CGFloat(lastPercent)<percent){
            pathAnimation1.fromValue = percent
            pathAnimation1.toValue = percent-(fabs(percent-CGFloat(lastPercent)))*0.1
            pathAnimation2.fromValue = percent-(fabs(percent-CGFloat(lastPercent)))*0.1
            pathAnimation2.toValue = percent
        }else{
            pathAnimation1.fromValue = percent
            pathAnimation1.toValue = percent+(fabs(percent-CGFloat(lastPercent)))*0.1
            pathAnimation2.fromValue = percent+(fabs(percent-CGFloat(lastPercent)))*0.1
            pathAnimation2.toValue = percent
        }
        
        let group = CAAnimationGroup()
        group.duration = 0.9
        group.animations = [pathAnimation,pathAnimation1,pathAnimation2]
        group.autoreverses = false
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = false

        percentLayer.addAnimation(group, forKey: "strokeEndAnimation")
        
        lastPercent = NSTimeInterval(percent)
    }
    
    
    
    
}
