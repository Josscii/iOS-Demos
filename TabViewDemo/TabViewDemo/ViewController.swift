//
//  ViewController.swift
//  TabViewDemo
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

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
        
        tabView1 = TabView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 50), coordinatedScrollView: scrollView)
        tabView1.delegate = self
//        tabView1.backgroundColor = .green
        tabView1.widthType = .selfSizing
        tabView1.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.reuseIdentifier)
        view.addSubview(tabView1)
    }
    
    var items = ["哈哈", "嘻嘻嘻", "嗯", "不要啊啊", "确定", "来抱抱", "不行啊"]
    
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
    func tabView(_ tabView: TabView, indicatorViewWith superView: UIView) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(view)
        view.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        return view
    }
    
    func numberOfItems(in tabView: TabView) -> Int {
        return items.count
    }
    
    func tabView(_ tabView: TabView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = tabView.dequeueReusableCell(withReuseIdentifier: TabItemCell.reuseIdentifier, for: index) as! TabItemCell
        
        cell.titleLabel.text = items[index]
//        cell.isFontSizeProgressiveChange = true
//        cell.selectedFontSize = 18
//        cell.normalFontSize = 15
//        cell.isTextColorProgressiveChange = true
        cell.selectedTextColor = .white
        
        return cell
    }
}

