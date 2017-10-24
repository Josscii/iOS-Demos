//
//  DrawView.swift
//  UIFontDemo
//
//  Created by Josscii on 2017/10/21.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class DrawView: UIView {
    override func draw(_ rect: CGRect) {
        let juxtaposed = "juxtaposed" as NSString
        juxtaposed.draw(with: rect, options: [.usesLineFragmentOrigin], attributes: nil, context: nil)
    }
}
