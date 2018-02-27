//
//  TableViewController.swift
//  NestedScrollViewDemo
//
//  Created by josscii on 2018/2/26.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var innerCanScroll = false
}

extension TableViewController {
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !innerCanScroll {
            scrollView.contentOffset.y = 0
        }
        
        if scrollView.contentOffset.y <= 0  {
            innerCanScroll = false
            scrollView.contentOffset.y = 0
            NotificationCenter.default.post(name: NSNotification.Name.init("change"), object: nil)
        }
        
        scrollView.showsVerticalScrollIndicator = innerCanScroll
    }
    
    
}
