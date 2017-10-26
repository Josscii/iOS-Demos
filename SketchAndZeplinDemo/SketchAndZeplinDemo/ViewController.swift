//
//  ViewController.swift
//  SketchAndZeplinDemo
//
//  Created by Josscii on 2017/10/25.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var sketchLabel: SketchLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let chineseText = "写了这么久的 iOS，基本都是和界面布局打交道，平常在编码的过程中也逐渐积累了一些关于布局的心得，这里做个总结，既是对前面工作的总结，也希望能够给读这篇文章的人一些收获。"
        
        let fontSize: CGFloat = 13
        let lineHeight: CGFloat = 15
        
        sketchLabel = SketchLabel()
        sketchLabel.numberOfLines = 0
        sketchLabel.backgroundColor = .green
        sketchLabel.font = UIFont.systemFont(ofSize: fontSize)
        sketchLabel.setText(text: chineseText, lineHeight: lineHeight)
        view.addSubview(sketchLabel)
        sketchLabel.translatesAutoresizingMaskIntoConstraints = false
        sketchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 41).isActive = true
        sketchLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -41).isActive = true
        sketchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
    }

}
