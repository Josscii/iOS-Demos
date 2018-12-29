//
//  TKLabel.swift
//  Demo
//
//  Created by Josscii on 2018/11/5.
//  Copyright © 2018 Josscii. All rights reserved.
//

import UIKit

class TKLabel: UITextView {
    convenience init() {
        self.init(frame: .zero)
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        isSelectable = false
        isEditable = false
        isScrollEnabled = false
        textContainerInset = .zero
        textContainer.lineBreakMode = .byTruncatingTail
    }
    
    var numberOfLines: Int {
        set {
            textContainer.maximumNumberOfLines = newValue
        }
        get {
            return textContainer.maximumNumberOfLines
        }
    }
    
    var attributesMap: [String: [NSAttributedString.Key: Any]] = [:]
    var highlightAttributesMap: [String: [NSAttributedString.Key: Any]] = [:]
    var clickBlock: ((String) -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let characterIndex = layoutManager.characterIndex(for: location,
                                                          in: textContainer,
                                                          fractionOfDistanceBetweenInsertionPoints: nil)
        
        var rangeMap: [String: NSRange] = [:]
        for (key,_) in highlightAttributesMap {
            do {
                let regex = try NSRegularExpression(pattern: key, options: [])
                let totalRange = NSRange(location: 0, length: text.count)
                let matches = regex.matches(in: text, options: [], range: totalRange)
                let range = matches.map { $0.range }.filter { $0.contains(characterIndex) }.first
                if let range = range {
                    rangeMap[key] = range
                }
            } catch {
                
            }
        }
        highlightRanges = rangeMap
        
        var rectMap: [String: [CGRect]] = [:]
        for (key,value) in rangeMap {
            var rects: [CGRect] = []
            let glyphRange = layoutManager.glyphRange(forCharacterRange: value, actualCharacterRange: nil)
            layoutManager.enumerateEnclosingRects(forGlyphRange: glyphRange,
                                                  withinSelectedGlyphRange: glyphRange,
                                                  in: textContainer) { (rect, _) in
                rects.append(rect)
            }
            if rects.count > 0 {
                rectMap[key] = rects
            }
            clickBlock?(text)
        }
        highlightRects = rectMap
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        reset()
    }
    
    private var highlightRanges: [String: NSRange] = [:]
    private var highlightRects: [String: [CGRect]] = [:]
    
    override var text: String! {
        didSet {
            reset()
        }
    }
    
    func reset() {
        highlightRanges = [:]
        highlightRects = [:]
        setNeedsDisplay()
    }
    
    var moreLabel: UILabel? {
        didSet {
            if let label = moreLabel {
                label.isHidden = true
                label.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expand))
                label.addGestureRecognizer(tapGesture)
                addSubview(label)
            }
        }
    }
    
    @objc func expand() {
        textContainer.maximumNumberOfLines = 0
        textContainer.exclusionPaths = []
        moreLabel?.isHidden = true
        moreAction?()
    }
    
    var moreAction: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        var truncatedLineRect: CGRect?
        layoutManager.enumerateLineFragments(forGlyphRange: glyphRange) { (rect, _, _, range, stop) in
            let truncatedRange = self.layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: NSMaxRange(range)-1)
            if truncatedRange.location != NSNotFound {
                truncatedLineRect = rect
                stop.pointee = true
            }
        }
        
        if let rect = truncatedLineRect, let moreLabel = moreLabel {
            textContainer.exclusionPaths = [UIBezierPath(rect: CGRect(x: frame.width-90, y: rect.minY, width: rect.width, height: rect.height))]
            moreLabel.frame = CGRect(x: frame.width-100, y: rect.minY, width: rect.width, height: rect.height)
            moreLabel.isHidden = false
        }
    }
    
    override func draw(_ rect: CGRect) {
        let attributedStr: NSMutableAttributedString
        if let attributedText = attributedText {
            attributedStr = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attributedStr = NSMutableAttributedString(string: text)
        }
        let totalRange = NSRange(location: 0, length: text.count)
        attributedStr.addAttribute(.foregroundColor, value: textColor ?? .black, range: totalRange)
        attributedStr.addAttribute(.font, value: font ?? .systemFont(ofSize: 17), range: totalRange)
        
        if highlightRanges.count > 0 {
            if let context = UIGraphicsGetCurrentContext() {
                for (key, value) in highlightRects {
                    if let back = highlightAttributesMap[key]?[.backgroundColor] as? UIColor {
                        context.setFillColor(back.cgColor)
                        value.forEach { rect in
                            let path = UIBezierPath(roundedRect: rect, cornerRadius: 2)
                            context.addPath(path.cgPath)
                            context.fillPath()
                        }
                    }
                }
            }
            
            for (key, value) in highlightRanges {
                if let fore = highlightAttributesMap[key]?[.foregroundColor] as? UIColor {
                    attributedStr.addAttribute(.foregroundColor, value: fore, range: value)
                }
            }
        }
        
        for (key, value) in attributesMap {
            do {
                let regex = try NSRegularExpression(pattern: key, options: [])
                let totalRange = NSRange(location: 0, length: text.count)
                let matches = regex.matches(in: text, options: [], range: totalRange)
                let ranges = matches.map { $0.range }
                for range in ranges {
                    attributedStr.addAttributes(value, range: range)
                }
            } catch {
                
            }
        }
        
        attributedText = attributedStr
        
        super.draw(rect)
    }
}
