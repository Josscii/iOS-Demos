//
//  ViewController.swift
//  TabViewDemo
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class SimpleTabItemView: UIView, TabItemView {
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    }
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                titleLabel.textColor = .red
            } else {
                titleLabel.textColor = .black
            }
        }
    }
}

class ViewController: UIViewController {
    
    var tabView: WYTabView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 400, width: view.bounds.width, height: 200))
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(items.count), height: 200)
        view.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .red
        
        tabView = WYTabView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 100), coordinatedScrollView: scrollView)
        tabView.delegate = self
        tabView.backgroundColor = .green
        tabView.itemWidth = 100
        view.addSubview(tabView)
    }
    
    var items = ["哈哈", "嘻嘻", "呜呜", "呜呜", "呜呜","呜呜", "呜呜"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tabView.reloadData()
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
    func tabView(_ tabView: TabView, update indicatorView: UIView?, with progress: CGFloat) {
        guard let indicatorView = indicatorView else {
            return
        }
        
        let width = 50 + (80 - 50) * progress
        let x = (100 - width) / 2
        
        indicatorView.frame.size.width = width
        indicatorView.frame.origin.x = x
    }
    
    func tabView(_ tabView: TabView, indicatorViewWith superView: UIView) -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: (100-50)/2, y: 0, width: 50, height: 2)
        superView.addSubview(view)
        
        return view
    }
    
    func tabView(_ tabView: TabView, didSelect itemView: TabItemView?, at index: Int) {
        
    }
    
    func numberOfItems(in tabView: TabView) -> Int {
        return items.count
    }
    
    func tabView(_ tabView: TabView, configureItemViewAt index: Int, with cell: TabItemCell) {
        if let itemView = cell.itemView as? SimpleTabItemView {
            itemView.titleLabel.text = items[index]
        } else {
            let itemView = SimpleTabItemView()
            itemView.frame = cell.contentView.bounds
            itemView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            itemView.titleLabel.text = items[index]
            cell.contentView.addSubview(itemView)
            cell.itemView = itemView
        }
    }
}

