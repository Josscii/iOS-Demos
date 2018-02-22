//
//  ViewController.swift
//  TabBarDemo
//
//  Created by josscii on 2018/2/11.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // UITabBarItem
        // UIBarButtonItem
        
        let tabBarItemView = tabBarItem.value(forKey: "view") as? UIView
        let badge = tabBarItemView?.value(forKey: "badge") as? UIView
        badge?.backgroundColor = .green
        
        tabBarItem.badgeValue = "45"
        
        tabBarController?.tabBar.frame.size.height = 30
    }
}

