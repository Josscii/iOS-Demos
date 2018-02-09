//
//  ViewController.swift
//  UIBarButtonItemPositionDemo
//
//  Created by josscii on 2017/11/7.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

/*
 利用调整 backIndicatorImage 的空白来调整距离
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "hello"
        navigationItem.removeBackTitle()
        navigationController?.navigationBar.setBackImage(image: #imageLiteral(resourceName: "back"), leftMargin: 20)
        
        navigationController?.navigationBar.tintColor = .red
    }
}

extension UINavigationItem {
    /// 去掉 backBarButtonItem 的标题
    func removeBackTitle() {
        backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UINavigationBar {
    /// 设置 backBarButtonItem 的图标并调整位置
    ///
    /// - Parameters:
    ///   - image: 图标
    ///   - leftMargin: 左边距边缘的位置
    func setBackImage(image: UIImage, leftMargin: CGFloat) {
        let realMargin = leftMargin-8
        let contextSize = CGSize(width: realMargin+image.size.width, height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(contextSize, false, 0)
        image.draw(at: CGPoint(x: realMargin, y: 0))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        backIndicatorImage = finalImage
        backIndicatorTransitionMaskImage = finalImage
    }
}
