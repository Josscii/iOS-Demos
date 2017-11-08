//
//  ViewController.swift
//  SlidePageViewControllerDemo
//
//  Created by josscii on 2017/11/8.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let viewController = ViewController2()
        viewController.view.backgroundColor = .red
        viewController.view.isUserInteractionEnabled = false
        let viewController2 = ViewController2()
        viewController2.view.backgroundColor = .yellow
        let viewController3 = ViewController2()
        viewController3.view.backgroundColor = .blue
        let viewController4 = ViewController2()
        viewController4.view.backgroundColor = .brown
        
        let slidePageViewController = SlidePageViewController()
        slidePageViewController.viewControllers = [viewController, viewController2, viewController3, viewController4]
        navigationController?.pushViewController(slidePageViewController, animated: true)
    }
}

