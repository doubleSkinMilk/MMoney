//
//  TopView.swift
//  MMoney
//
//  Created by yuandalu on 16/5/10.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class TopView: UIView {
    
    let titleScroll = UIScrollView()
    
    convenience init(frame: CGRect,titleItems:[String]) {
        self.init(frame:frame)
        self.buideTitleView(titleItems)
        self.backgroundColor = UIColor.blackColor()
    }
    
    func buideTitleView(titleItems:[String]) -> Void {
        
        let redView = UIView.init(frame: CGRect(x: (MainScreenWidth-50)/2, y: 0, width: 50, height: 3))
        redView.backgroundColor = UIColor.redColor()
        self.addSubview(redView)

        titleScroll.frame = CGRect(x: 0, y: 5, width:MainScreenWidth, height: MainScreenHeight)
        titleScroll.backgroundColor = UIColor.clearColor()
        titleScroll.scrollEnabled = false
        self.addSubview(titleScroll)
        
        var lastX:CGFloat = 65.0
        let marge = (MainScreenWidth-65*3)/2
        
        for title in titleItems{
            let titleLabel = UILabel.init()
            titleLabel.frame = CGRect(x: lastX+marge, y: 0, width: 65, height: 15)
            titleLabel.text = title
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.font = UIFont.boldSystemFontOfSize(13)
            titleLabel.textAlignment = .Center
            lastX = CGRectGetMaxX(titleLabel.frame)
            titleScroll.addSubview(titleLabel)
        }
        titleScroll.contentSize = CGSize(width: lastX, height: 0)

    }
    
}
