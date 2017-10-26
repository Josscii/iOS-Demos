//
//  SketchLabel.swift
//  SketchAndZeplinDemo
//
//  Created by Josscii on 2017/10/26.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class SketchLabel: UILabel {
    
    var lineHeight: CGFloat?
    
    func setText(text: String, lineHeight: CGFloat) {
        self.lineHeight = lineHeight
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributeString = NSAttributedString(string: text, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
        attributedText = attributeString
    }
    
    /// https://stackoverflow.com/questions/3476646/uilabel-text-margin
    override func drawText(in rect: CGRect) {
        guard let lineHeight = lineHeight else {
            fatalError("lineHeight must have value!")
        }
        
        let topInset = (lineHeight - font.pointSize)/2
        var magicAjust: CGFloat = 0
        if topInset == 0 {
            magicAjust = 0
        } else if topInset == 0.5 {
            magicAjust = 0.5
        } else {
            magicAjust = 1
        }
        let insets = UIEdgeInsets.init(top: -topInset + magicAjust, left: 0, bottom: 0, right: 0)
        
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
