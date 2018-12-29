//
//  ViewController.swift
//  TextKitDemo
//
//  Created by josscii on 2017/9/26.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//        let at = NSTextAttachment()
//        at.image = #imageLiteral(resourceName: "boy-aquariuss-icon")
//        at.bounds = CGRect(x: 20, y: 10, width: 5, height: 5)
//        let attachment = NSAttributedString.init(attachment: at)
//
//        print(attachment)
//
//        let attributeString = NSMutableAttributedString(string: "aaaaaaaaaa")
//        attributeString.replaceCharacters(in: NSRange.init(location: 0, length: 1), with: attachment)
//        attributeString.addAttributes([NSStrokeColorAttributeName: UIColor.red, NSBackgroundColorAttributeName: UIColor.green, NSStrokeWidthAttributeName: 2], range: NSRange(location: 1, length: 2))
//
//        label.attributedText = attributeString
        
        
        let label = TextKitLabel(frame: CGRect(x: 20, y: 100, width: 300, height: 300))
        label.text = "关关雎鸠，在河之洲。窈窕淑女，君子好逑。参差荇菜，左右流之。窈窕淑女，寤寐求之。求之不得，寤寐思服。悠哉悠哉，辗转反侧。参差荇菜，左右采之。窈窕淑女，琴瑟友之。参差荇菜，左右芼之。窈窕淑女，钟鼓乐之。"
//        label.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(label)
    }
}
