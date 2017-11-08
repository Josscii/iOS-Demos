//
//  ViewController2.swift
//  UIBarButtonItemPositionDemo
//
//  Created by josscii on 2017/11/7.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        navigationItem.hidesBackButton = true
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
//        button.setTitle("back", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.contentHorizontalAlignment = .left
//        button.titleEdgeInsets.left = -8
//        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(pop), for: .touchUpInside)
//        let leftbarbuttonitem = UIBarButtonItem(customView: button)
//        navigationItem.leftBarButtonItem = leftbarbuttonitem
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
    }
}
