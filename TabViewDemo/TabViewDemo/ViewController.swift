//
//  ViewController.swift
//  TabViewDemo
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

public extension UIColor {
    /// The RGBA components associated with a `UIColor` instance.
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!
        
        switch components.count == 2 {
        case true : return (r: components[0], g: components[0], b: components[0], a: components[1])
        case false: return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }
    
    /**
     Returns a `UIColor` by interpolating between two other `UIColor`s.
     - Parameter fromColor: The `UIColor` to interpolate from
     - Parameter toColor:   The `UIColor` to interpolate to (e.g. when fully interpolated)
     - Parameter progress:  The interpolation progess; must be a `CGFloat` from 0 to 1
     - Returns: The interpolated `UIColor` for the given progress point
     */
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

class TabItemCell: UICollectionViewCell {
    static let reuseIdentifier = "TabItemCell"
    
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        setupFontSizeAndTransform()
    }
    
    override var isSelected: Bool {
        didSet {
            if !isTextColorProgressiveChange {
                if isSelected {
                    titleLabel.textColor = .red
                } else {
                    titleLabel.textColor = .black
                }
            }
            
            if !isFontSizeProgressiveChange {
                if isSelected {
                    titleLabel.font = UIFont.systemFont(ofSize: selectedFontSize)
                } else {
                    titleLabel.font = UIFont.systemFont(ofSize: normalFontSize)
                }
            }
        }
    }
    
    var margin: CGFloat = 8

    // font related
    
    var isFontSizeProgressiveChange = false {
        didSet {
            setupFontSizeAndTransform()
        }
    }
    
    var normalFontSize: CGFloat = 15 {
        didSet {
            setupFontSizeAndTransform()
        }
    }
    
    var selectedFontSize: CGFloat = 18 {
        didSet {
            setupFontSizeAndTransform()
        }
    }
    
    func setupFontSizeAndTransform() {
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
    
    func labelTransform(with progress: CGFloat) {
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
    var isTextColorProgressiveChange = true
    
    var normalTextColor: UIColor = .black {
        didSet {
            titleLabel.textColor = normalTextColor
        }
    }
    
    var selectedTextColor: UIColor = .red
    
    func colorTransform(with progress: CGFloat) {
        let progress = 1 - progress
        titleLabel.textColor = UIColor.interpolate(from: normalTextColor, to: selectedTextColor, with: progress)
    }
}

extension TabItemCell: TabItem {
    func update(with progress: CGFloat) {
        if isFontSizeProgressiveChange {
            labelTransform(with: progress)
        }
        
        if isTextColorProgressiveChange {
            colorTransform(with: progress)
        }
    }
    
    func setup(with widthType: TabViewWidthType) {
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

class ViewController: UIViewController {
    
    var tabView: WYTabView!
    var scrollView: UIScrollView!
    var tabView1: TabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 400, width: view.bounds.width, height: 200))
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(items.count), height: 200)
        view.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .red
        
//        tabView = WYTabView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 100), coordinatedScrollView: scrollView)
//        tabView.delegate = self
//        tabView.backgroundColor = .green
//        tabView.itemWidth = 100
//        view.addSubview(tabView)
        
        tabView1 = TabView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 100), coordinatedScrollView: scrollView)
        tabView1.delegate = self
//        tabView1.backgroundColor = .green
        tabView1.widthType = .fixed(width: 60)
        tabView1.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.reuseIdentifier)
        view.addSubview(tabView1)
    }
    
    var items = ["呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        tabView.reloadData()
    }
}

extension ViewController: WYTabViewDelegate {
    func tabView(_ tabView: WYTabView, updateIndicatorView indicatorView: UIView?, withProgress progress: CGFloat) {
        guard let indicatorView = indicatorView else {
            return
        }
        
        let width = 50 + (80 - 50) * progress
        let x = (100 - width) / 2
        
        indicatorView.frame.size.width = width
        indicatorView.frame.origin.x = x
    }
    
    func tabView(_ tabView: WYTabView, indicatorWithSuperView superView: UIView) -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: (100-50)/2, y: 0, width: 50, height: 2)
        superView.addSubview(view)
        
        return view
    }
    
    func tabView(_ tabView: WYTabView, didSelect itemView: WYTabItemView?, at index: Int) {
        
    }
    
    func numberOfItems(in tabView: WYTabView) -> Int {
        return items.count
    }
    
    func tabView(_ tabView: WYTabView, configureItemAt index: Int, with cell: WYTabItemCell) {
        if let itemView = cell.itemView as? WYSimpleTabItemView {
            itemView.titleLabel.text = items[index]
        } else {
            let itemView = WYSimpleTabItemView()
            itemView.frame = cell.contentView.bounds
            itemView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            itemView.titleLabel.text = items[index]
            cell.contentView.addSubview(itemView)
            cell.itemView = itemView
        }
    }
}

extension ViewController: TabViewDelegate {
//    func tabView(_ tabView: TabView, update indicatorView: UIView?, with progress: CGFloat) {
//        guard let indicatorView = indicatorView,
//            let indicatorSuperView = indicatorView.superview else {
//                return
//        }
//        
//        let w = 10 + (30 - 10) * progress
//        let centerX = indicatorSuperView.frame.width / 2
//        
//        indicatorView.frame.size.width = w
//        indicatorView.center.x = centerX
//    }
//    
//    func tabView(_ tabView: TabView, indicatorViewWith superView: UIView) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .red
//        view.frame = CGRect(x: (superView.frame.width-10)/2, y: 0, width: 10, height: 2)
//        superView.addSubview(view)
//        return view
//    }
    
    func numberOfItems(in tabView: TabView) -> Int {
        return items.count
    }
    
    func tabView(_ tabView: TabView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = tabView.dequeueReusableCell(withReuseIdentifier: TabItemCell.reuseIdentifier, for: index) as! TabItemCell
        
        cell.titleLabel.text = items[index]
//        cell.isFontSizeProgressiveChange = true
        cell.selectedFontSize = 18
        cell.normalFontSize = 15
        
        return cell
    }
}

