//
//  ViewController.swift
//  TabViewDemo
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tabView: TabView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView = TabView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 100))
        tabView.delegate = self
        tabView.backgroundColor = .green
        //        tabView.widthType = .fixed(width: 50)
        view.addSubview(tabView)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 400, width: view.bounds.width, height: 200))
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(items.count), height: 200)
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .red
    }
    
    var items = ["哈哈", "嘻嘻", "呜呜"]
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabView.updateTabView(with: scrollView)
    }
}

extension ViewController: TabViewDelegate {
    func tabView(_ tabView: TabView, didSelect itemView: TabItemView, at index: Int) {
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentOffset.x = CGFloat(index) * self.scrollView.bounds.width
        }
    }
    
    func tabView(_ tabView: TabView, configureIndicatorViewWith superView: UIView) {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 2)
        superView.addSubview(view)
    }
    
    func numberOfItems(in tabView: TabView) -> Int {
        return items.count
    }
    
    func tabView(_ tabView: TabView, configureItemViewAt index: Int, with cell: TabItemCell) {
        if let itemView = cell.itemView as? SimpleTabItemView {
            itemView.label.text = items[index]
        } else {
            let itemView = SimpleTabItemView()
            itemView.frame = cell.contentView.bounds
            itemView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            itemView.label.text = items[index]
            cell.contentView.addSubview(itemView)
            cell.itemView = itemView
        }
    }
}

