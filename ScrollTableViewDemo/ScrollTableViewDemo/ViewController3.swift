//
//  ViewController3.swift
//  ScrollTableViewDemo
//
//  Created by Josscii on 2017/11/21.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    var scrollView1: SelfDelegateScrollView!
    var tableView1: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView1 = SelfDelegateScrollView(frame: view.bounds)
        scrollView1.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 300)
        scrollView1.backgroundColor = .red
        scrollView1.showsVerticalScrollIndicator = false
        scrollView1.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView1)
        
        tableView1 = UITableView(frame: view.bounds)
//        tableView1.frame.size.height -= 50
        tableView1.frame.origin.y = 300
        tableView1.contentInsetAdjustmentBehavior = .never
        tableView1.delegate = self
        tableView1.dataSource = self
        //        tableView1.showsVerticalScrollIndicator = false
        scrollView1.addSubview(tableView1)
        
        SyncScrollViewManager.shared.outerScrollView = scrollView1
        SyncScrollViewManager.shared.innerScrollView = tableView1
        SyncScrollViewManager.shared.changeHeight = 300
        
        let block: @convention(block) (AspectInfo)->Void = {
            _ in
            print("hello")
        }
        
        let handlePan: Selector = "handlePan:"
        try! tableView1.aspect_hook(handlePan, with: [.positionBefore], usingBlock: block)
    }
}

extension ViewController3: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }
}

class SelfDelegateScrollView: UIScrollView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}

class SelfDelegateTableView: UITableView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
