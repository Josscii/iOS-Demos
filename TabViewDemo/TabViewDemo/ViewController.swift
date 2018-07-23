//
//  ViewController.swift
//  TabViewDemo
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

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
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.transform = CGAffineTransform(scaleX: 15 / 18, y: 15 / 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 8).isActive = true
//        NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -8).isActive = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .red
            } else {
                titleLabel.textColor = .black
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                titleLabel.textColor = .red
            } else {
                titleLabel.textColor = .black
            }
        }
    }
}

extension TabItemCell: TabItem {
    func update(with progress: CGFloat) {
        let scale: CGFloat = 18.0/15-1
        let scale1 = 1 - scale * progress
        titleLabel.transform = CGAffineTransform.init(scaleX: scale1, y: scale1)
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
        tabView1.widthType = .fixed(width: 80)
        tabView1.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.reuseIdentifier)
        view.addSubview(tabView1)
    }
    
    var items = ["yes", "no", "fuck", "test", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无", "呜呜无"]
    
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
        
        return cell
    }
}

