//
//  ViewController.swift
//  ScrollTableViewDemo
//
//  Created by Josscii on 2017/10/1.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView1: UIScrollView!
    var tableView1: UITableView!
    var tableView2: UITableView!
    var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        edgesForExtendedLayout  = .init(rawValue: 0)
        
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 290))
        headerView.backgroundColor = UIColor.green
        headerView.layer.zPosition = 1
        
        view.addSubview(headerView)
        
        scrollView1 = UIScrollView(frame: view.bounds)
        scrollView1.contentSize = CGSize(width: view.bounds.width * 2, height: view.bounds.height)
        scrollView1.backgroundColor = .red
        scrollView1.delegate = self
        scrollView1.showsVerticalScrollIndicator = false
        scrollView1.bounces = false
        scrollView1.isPagingEnabled = true
        scrollView1.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView1)
        
        tableView1 = UITableView(frame: view.bounds)
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.contentInsetAdjustmentBehavior = .never
//        tableView1.showsVerticalScrollIndicator = false
        scrollView1.addSubview(tableView1)

        tableView2 = UITableView(frame: view.bounds)
        tableView2.contentInsetAdjustmentBehavior = .never
        tableView2.frame.origin.x = view.bounds.width
        tableView2.delegate = self
        tableView2.dataSource = self
//        tableView2.showsVerticalScrollIndicator = false
        scrollView1.addSubview(tableView2)
        
        tableView1.contentInset.top = 290
        tableView2.contentInset.top = 290
        tableView1.scrollIndicatorInsets.top = 300
        tableView2.scrollIndicatorInsets.top = 300
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != scrollView1 {
            headerView.frame.origin.y = max(-(290 + scrollView.contentOffset.y), -250)
            
            if scrollView.contentOffset.y < -40 {
                if scrollView == tableView1 {
                    tableView2.contentOffset = scrollView.contentOffset
                }
                
                if scrollView == tableView2 {
                    tableView1.contentOffset = scrollView.contentOffset
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }
}

