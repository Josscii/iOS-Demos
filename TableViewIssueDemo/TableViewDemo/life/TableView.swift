//
//  TableView.swift
//  ReloadDataDemo
//
//  Created by Josscii on 2017/11/6.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        print("reloadData")
        super.reloadData()
        
        //这里弄到下一个 runloop 就太慢了
        DispatchQueue.main.async {
            print("我也结束啦啦啦啦啦啦")
        }
    }
    
    var layoutPassCount = 0
    var firstLayoutPassEnds = false
    
    override func layoutSubviews() {
        print("layoutSubviews")
        super.layoutSubviews()
        layoutPassCount += 1
        
        if layoutPassCount == 2 {
            firstLayoutPassEnds = true
        }
        
        //通过调用的次数来很不靠谱
        if firstLayoutPassEnds {
            print("结束啦啦啦啦")
        }
    }
    
    override func setNeedsLayout() {
        print("setNeedsLayout")
        super.setNeedsLayout()
    }
    
    override func layoutIfNeeded() {
        print("layoutIfNeeded")
        super.layoutIfNeeded()
    }
    
    override var contentSize: CGSize {
        set {
            //如果我们就是想拿到 contentSize 的话，就可以用这个
            print("更新 contentnSize: \(contentSize)")
            super.contentSize = newValue
        }
        
        get {
            return super.contentSize
        }
    }
}

extension TableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt \(indexPath.row)")
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.dataSource = TableView()
//        tableView.reloadData()
//        tableView.setNeedsLayout()
//        tableView.layoutIfNeeded()
//        DispatchQueue.main.async {
//            print("test")
//        }
    }
}
