//
//  ViewController.swift
//  UIBarButtonItemPositionDemo
//
//  Created by josscii on 2017/11/7.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
//        button.setTitle("back", for: .normal)
//        button.backgroundColor = .red
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "我的", style: .bordered, target: nil, action: nil)
        
        navigationItem.title = "hello"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
        navigationController?.navigationBar.tintColor = .red
    }
}

