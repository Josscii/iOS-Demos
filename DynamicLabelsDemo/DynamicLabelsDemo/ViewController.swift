//
//  ViewController.swift
//  DynamicLabelsDemo
//
//  Created by Josscii on 2017/8/7.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let v = DynamicLabelsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(v)
        
        v.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        v.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        v.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        var strings: [String] = []
        strings.append("哈哈，我觉得你说得太对了！")
        strings.append("当前版本暂不支持查看此消息，请在手机上查看。")
        strings.append("厉害")
        strings.append("不行吧")
        strings.append("得了吧你")
        
        v.setup(with: strings)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

