//
//  ViewController.swift
//  ReloadDataDemo
//
//  Created by Josscii on 2017/11/6.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tableView = TableView(frame: view.bounds, style: .plain)
        print("init")
        view.addSubview(tableView)
        print("added to view")
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
    }
}

