//
//  ViewController.swift
//  UIButtonDemo
//
//  Created by josscii on 2017/9/27.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton()
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("哈哈", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(#imageLiteral(resourceName: "love"), for: .normal)
        
        button.contentVerticalAlignment = .top
        button.contentHorizontalAlignment = .left

//        button.contentEdgeInsets.right = 30
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 25)
        
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

