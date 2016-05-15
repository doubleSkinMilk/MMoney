//
//  MainPageViewController.swift
//  MMoney
//
//  Created by yuandalu on 16/5/10.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,UIScrollViewDelegate {
    
    lazy var topView:TopView = {
       return TopView.init(frame:CGRect(x:0,y:0,width: MainScreenWidth,height: 20),
            titleItems:["Payments","Income","Other"])
    }()
    
    var payments = PayViewController()
    var income = IncomeViewController()
    var other = OtherViewController()

    lazy var vcScrollView :UIScrollView = {
        let scroll = UIScrollView.init(frame: CGRect(x: 0, y: 20, width: MainScreenWidth, height: MainScreenHeight-20))
        scroll.pagingEnabled = true
        scroll.contentSize = CGSize(width:MainScreenWidth*3,height:0)
        scroll.showsHorizontalScrollIndicator = false
        scroll.delegate = self
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(topView)
        payments.view.frame = CGRect(x: 0, y: 0, width: MainScreenWidth, height: MainScreenHeight-10)
        income.view.frame = CGRect(x: MainScreenWidth, y: 0, width: MainScreenWidth, height: MainScreenHeight-10)
        other.view.frame = CGRect(x: MainScreenWidth*2, y: 0, width: MainScreenWidth, height: MainScreenHeight-10)
        self.view.addSubview(vcScrollView)
        self.vcScrollView.addSubview(payments.view)
        self.vcScrollView.addSubview(income.view)
        self.vcScrollView.addSubview(other.view)
        
        self.addChildViewController(payments)
        self.addChildViewController(income)
        self.addChildViewController(other)
        
    }
    
     func scrollViewDidScroll(scrollView: UIScrollView) {

        topView.titleScroll.contentOffset = CGPoint(x: scrollView.contentOffset.x*((MainScreenWidth-65)/2/MainScreenWidth), y: 0)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
}
