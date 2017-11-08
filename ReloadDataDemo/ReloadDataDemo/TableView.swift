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
    }
    
    override func layoutSubviews() {
        print("layoutSubviews")
        super.layoutSubviews()
    }
    
    override func setNeedsLayout() {
        print("setNeedsLayout")
        super.setNeedsLayout()
    }
    
    override func layoutIfNeeded() {
        print("layoutIfNeeded")
        super.layoutIfNeeded()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.dataSource = TableView()
//        tableView.reloadData()
//        tableView.setNeedsLayout()
//        tableView.layoutIfNeeded()
//        DispatchQueue.main.async {
            print("test")
//        }
    }
}
