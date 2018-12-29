//
//  TextKitLabel.swift
//  TextKitDemo
//
//  Created by josscii on 2017/9/26.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

// https://gist.github.com/preble/ab98fabda985b054126e
class TextSorage: NSTextStorage {
    private var storage = NSTextStorage()
    
    override var string: String {
        return storage.string
    }
    
//    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [String : Any] {
//        return storage.attributes(at: location, effectiveRange: range)
//    }
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        beginEditing()
        storage.replaceCharacters(in: range, with: str)
        edited(.editedCharacters, range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
//    override func setAttributes(_ attrs: [String : Any]?, range: NSRange) {
//        beginEditing()
//        storage.setAttributes(attrs, range: range)
//        edited(.editedAttributes, range: range, changeInLength: 0)
//        endEditing()
//    }
}

class TextKitLabel: UIView {
    
    var textContainer: NSTextContainer!
    var layoutManager: NSLayoutManager!
    var textStorage: TextSorage!
    
    var text: String? {
        didSet {
            if let text = text {
                textStorage.setAttributedString(NSAttributedString(string: text))
            }
        }
    }
    
    var attributeText: NSAttributedString? {
        didSet {
            if let attributeText = attributeText {
                textStorage.setAttributedString(attributeText)
            }
        }
    }
    
//    var font: UIFont = UIFont.systemFont(ofSize: 17) {
//        didSet {
//            textStorage.addAttributes([NSFontAttributeName: font], range: allGlyphsRange)
//        }
//    }
    
    var allGlyphsRange: NSRange {
        return NSRange.init(location: 0, length: layoutManager.numberOfGlyphs-1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textContainer = NSTextContainer(size: frame.size)
        
        layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        textStorage = TextSorage()
        textStorage.addLayoutManager(layoutManager)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textContainer.size = bounds.size
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.red.setFill()
        UIBezierPath(rect: rect).fill()
        
        if let highlightRange = highlightRange {
            let highlightRect = layoutManager.boundingRect(forGlyphRange: highlightRange, in: textContainer)
            
            UIColor.green.setFill()
            UIBezierPath(rect: highlightRect).fill()
        }
        
        layoutManager.drawBackground(forGlyphRange: allGlyphsRange, at: .zero)
        layoutManager.drawGlyphs(forGlyphRange: allGlyphsRange, at: .zero)
    }
    
    var highlightRange: NSRange?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer)
            highlightRange = NSRange.init(location: glyphIndex, length: 1)
            
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer)
            highlightRange = NSRange.init(location: glyphIndex, length: 1)
            
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlightRange = nil
        
        setNeedsDisplay()
    }
}















