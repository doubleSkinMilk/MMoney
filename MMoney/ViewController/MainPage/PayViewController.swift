//
//  PayViewController.swift
//  MMoney
//
//  Created by 范译文 on 16/5/10.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {
    
    let cellIdentifier = "cellIdentifier"
    
    lazy var chartContainer :ChartContainerView = {
        let container = ChartContainerView.init(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: MainScreenWidth*0.373))
        container.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        container.layer.position = CGPoint(x: MainScreenWidth/2, y: 0)
        return container
    }()
    
    lazy var payTable : UITableView = {
        let table =  UITableView.init(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: MainScreenHeight-20) , style: .Plain)
        table.backgroundColor = UIColor.clearColor()
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .None
        
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: MainScreenWidth*0.373))
        headerView.backgroundColor = UIColor.clearColor()
        table.tableHeaderView = headerView
        
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(chartContainer)
        self.view.addSubview(payTable)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        chartContainer.loadData([chartType.food,chartType.shopping,chartType.other], percent: [0.2,0.3,0.5])
    }
}

extension PayViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView === payTable {
            if scrollView.contentOffset.y >= 0 {
                let contentOffsetY = scrollView.contentOffset.y >= 0.05 ? scrollView.contentOffset.y:0
                chartContainer.effectView.alpha = fabs(contentOffsetY/chartContainer.bounds.height)
            }
            if scrollView.contentOffset.y <= 0 {
                let contentOffsetY = scrollView.contentOffset.y <= 0 ? -scrollView.contentOffset.y:0
                let factor = (chartContainer.bounds.height+contentOffsetY)/chartContainer.bounds.height
                chartContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, factor, factor)
            }
        }
    }
}

extension PayViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: cellIdentifier)
        }
        if let tempcell = cell {
            tempcell.textLabel?.text = "花了好多好多好多钱"
            return tempcell
        }else{
            return UITableViewCell()
        }
    }
}

