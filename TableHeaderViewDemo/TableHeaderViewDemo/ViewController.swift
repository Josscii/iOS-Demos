//
//  ViewController.swift
//  TableHeaderViewDemo
//
//  Created by josscii on 2017/8/7.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

enum Constants {
    static let tableHeaderViewHeight: CGFloat = 200
}

class ViewController: UIViewController {
    
    var tableView: UITableView!
    lazy var tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Constants.tableHeaderViewHeight))
        view.backgroundColor = .red
        
        let subView = UIView()
        subView.backgroundColor = .green
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        
        subView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        subView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // 不用 tableHeaderView 的原因是，tableHeaderView 的 Y 值无法改变
//        tableView.tableHeaderView = tableHeaderView
        tableView.contentInset.top = Constants.tableHeaderViewHeight
        tableView.addSubview(tableHeaderView)
        
        view.addSubview(tableView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = min(scrollView.contentOffset.y, -Constants.tableHeaderViewHeight)
        
        tableHeaderView.frame.size.height = -offset
        tableHeaderView.frame.origin.y = offset
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "row\(indexPath.row)"
        
        return cell
    }
}

