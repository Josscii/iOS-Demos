//
//  ViewController.swift
//  UIScrollViewAndUIControlDemo
//
//  Created by josscii on 2018/2/9.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: 0, height: 2000)
        view.addSubview(scrollView)
        scrollView.delaysContentTouches = false
        
        button = UIButton(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        button.setTitle("哈哈", for: .normal)
        button.setTitle("嘻嘻", for: .highlighted)
        button.backgroundColor = .red
        scrollView.addSubview(button)
        
        button.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
    }
    
    @objc func didTap(sender: UIButton) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

