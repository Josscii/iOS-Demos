//
//  TabItemCell.swift
//  TabViewDemo
//
//  Created by Josscii on 2018/7/24.
//  Copyright © 2018 josscii. All rights reserved.
//

import UIKit

public class TabItemCell: UICollectionViewCell {
    public static let reuseIdentifier = "TabItemCell"
    
    public var titleLabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
        contentView.addSubview(titleLabel)
        setupFontSizeAndTransform()
    }
    
    override public var isSelected: Bool {
        didSet {
            if !isTextColorProgressiveChange {
                if isSelected {
                    titleLabel.textColor = selectedTextColor
                } else {
                    titleLabel.textColor = normalTextColor
                }
            }
            
            if !isFontSizeProgressiveChange && selectedFontSize != normalFontSize {
                if isSelected {
                    titleLabel.font = UIFont.systemFont(ofSize: selectedFontSize)
                } else {
                    titleLabel.font = UIFont.systemFont(ofSize: normalFontSize)
                }
            }
        }
    }
    
    public var margin: CGFloat = 8
    
    // font related
    
    public var isFontSizeProgressiveChange = false {
        didSet {
            setupFontSizeAndTransform()
        }
    }
    
    public var normalFontSize: CGFloat = 17 {
        didSet {
            setupFontSizeAndTransform()
        }
    }
    
    public var selectedFontSize: CGFloat = 17 {
        didSet {
            setupFontSizeAndTransform()
        }
    }
    
    private func setupFontSizeAndTransform() {
        if isFontSizeProgressiveChange && (normalFontSize != selectedFontSize) {
            if selectedFontSize > normalFontSize {
                titleLabel.font = UIFont.systemFont(ofSize: selectedFontSize)
                
                let scale = normalFontSize / selectedFontSize;
                titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
            } else {
                titleLabel.font = UIFont.systemFont(ofSize: normalFontSize)
                titleLabel.transform = .identity
            }
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: normalFontSize)
            titleLabel.transform = .identity
        }
    }
    
    private func labelTransform(with progress: CGFloat) {
        let scale: CGFloat
        if selectedFontSize > normalFontSize {
            scale = 1 - (selectedFontSize / normalFontSize - 1) * progress
        } else {
            let progress =  1 - progress
            scale = 1 - (normalFontSize / selectedFontSize - 1) * progress
        }
        
        titleLabel.transform = CGAffineTransform.init(scaleX: scale, y: scale)
    }
    
    // text color related
    
    public var isTextColorProgressiveChange = false
    
    public var normalTextColor: UIColor = .black {
        didSet {
            titleLabel.textColor = normalTextColor
        }
    }
    
    public var selectedTextColor: UIColor = .red
    
    private func colorTransform(with progress: CGFloat) {
        titleLabel.textColor = UIColor.interpolate(from: selectedTextColor, to: normalTextColor, with: progress)
    }
}

extension TabItemCell: TabItem {
    public func update(with progress: CGFloat) {
        if isFontSizeProgressiveChange {
            labelTransform(with: progress)
        }
        
        if isTextColorProgressiveChange {
            colorTransform(with: progress)
        }
    }
    
    public func setup(with widthType: TabViewWidthType) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        switch widthType {
        case .selfSizing:
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: margin).isActive = true
            NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -margin).isActive = true
        default:
            NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        }
    }
}

private extension UIColor {
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!
        
        switch components.count == 2 {
        case true : return (r: components[0], g: components[0], b: components[0], a: components[1])
        case false: return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }
    
    static func interpolate(from fromColor: UIColor, to toColor: UIColor, with progress: CGFloat) -> UIColor {
        let fromComponents = fromColor.components
        let toComponents = toColor.components
        
        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
