//
//  ViewController2.swift
//  ScrollTableViewDemo
//
//  Created by Josscii on 2017/10/1.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIScrollViewDelegate {

    var scrollView1: CustomScrollView!
    var scrollView2: UIScrollView!
    var tableView1: CustomTableView!
    var tableView2: CustomTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView1 = CustomScrollView(frame: view.bounds)
        scrollView1.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 300)
        scrollView1.backgroundColor = .red
        scrollView1.delegate = self
        scrollView1.showsVerticalScrollIndicator = false
        scrollView1.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView1)
        
        scrollView2 = UIScrollView(frame: view.bounds)
        scrollView2.frame.origin.y = 300
        scrollView2.contentSize = CGSize(width: view.bounds.width * 2, height: view.bounds.height)
        scrollView2.backgroundColor = .green
        scrollView2.delegate = self
        scrollView2.isPagingEnabled = true
        scrollView2.showsVerticalScrollIndicator = false
        scrollView2.contentInsetAdjustmentBehavior = .never
        scrollView1.addSubview(scrollView2)
        
        tableView1 = CustomTableView(frame: view.bounds, outerScrollView: scrollView1)
        tableView1.frame.size.height -= 50
        tableView1.contentInsetAdjustmentBehavior = .never
//        tableView1.showsVerticalScrollIndicator = false
        scrollView2.addSubview(tableView1)
        
        tableView2 = CustomTableView(frame: view.bounds, outerScrollView: scrollView1)
        tableView2.frame.size.height -= 50
        tableView2.frame.origin.x = view.bounds.width
        tableView2.contentInsetAdjustmentBehavior = .never
//        tableView2.showsVerticalScrollIndicator = false
        scrollView2.addSubview(tableView2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView1.contentOffset.y = min(250, scrollView1.contentOffset.y)
        
        if scrollView2.contentOffset.x > 0 {
            if tableView2.contentOffset.y > 0 {
                scrollView1.contentOffset = CGPoint(x: 0, y: 250)
            }
        } else {
            if tableView1.contentOffset.y > 0 {
                scrollView1.contentOffset = CGPoint(x: 0, y: 250)
            }
        }
    }
}
