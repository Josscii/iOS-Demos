//
//  ViewController.swift
//  UIFontDemo
//
//  Created by Josscii on 2017/10/20.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sfLabel: UILabel!
    var pfLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let chineseText = "朝辞白帝彩云间，千里江陵一日还。两岸猿声啼不住，轻舟已过万重山。"
        let englishText = "Do any additional setup after loading the view, typically from a nib."
        let width: CGFloat = 200
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10.5
        
        let attribute = NSAttributedString(string: chineseText, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
        
        sfLabel = UILabel()
        sfLabel.numberOfLines = 0
        sfLabel.backgroundColor = .green
        sfLabel.font = UIFont.systemFont(ofSize: 20)
        sfLabel.attributedText = attribute
        sfLabel.frame.size.width = width
        sfLabel.sizeToFit()
        sfLabel.center.x = view.center.x
        sfLabel.frame.origin.y = 300
        view.addSubview(sfLabel)

        // 系统中文字体的真正名字时 .PingFangSC-Regular 前面有 dot，这里是从 xib 看来的
        pfLabel = UILabel()
        pfLabel.numberOfLines = 0
        pfLabel.backgroundColor = .red
        pfLabel.font = UIFont(name: ".PingFangSC-Regular", size: 20)
        pfLabel.attributedText = attribute
        pfLabel.frame.size.width = width
        pfLabel.sizeToFit()
        pfLabel.center.x = view.center.x
        pfLabel.frame.origin.y = 400
        view.addSubview(pfLabel)
    }

}

