//
//  IncomeViewController.swift
//  MMoney
//
//  Created by 范译文 on 16/5/10.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {

    lazy var headView : UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: MainScreenWidth*0.373))
        view.backgroundColor = UIColor(hex:0x222645)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
