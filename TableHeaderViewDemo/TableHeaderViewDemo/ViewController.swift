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
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

enum HeaderStyle: String {
    case tableHeaderView = "tableHeaderView"
    case customView = "customView"
}

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    lazy var tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.tableHeaderViewHeight))
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 2
        self.addSubView(to: view)
        return view
    }()
    
    lazy var customView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: -Constants.tableHeaderViewHeight, width: Constants.screenWidth, height: Constants.tableHeaderViewHeight))
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 2
        self.addSubView(to: view)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Lenna.png"))
        imageView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.tableHeaderViewHeight)
        return imageView
    }()
    
    func addSubView(to view: UIView) {
        let subView = UIView()
        subView.backgroundColor = .green
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        
        subView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        subView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    var headerStyle: HeaderStyle = .tableHeaderView {
        didSet {
            if headerStyle == .tableHeaderView {
                useTableHeaderView()
            } else {
                useCustomView()
            }
            title = headerStyle.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "tableViewHeader"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "change style", style: .plain, target: self, action: #selector(changeStyle))
        
        // tableView
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        useTableHeaderView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if headerStyle == .tableHeaderView {
            let contentOffsetY = min(scrollView.contentOffset.y, 0)
            imageView.frame.origin.y = contentOffsetY
            imageView.frame.size.height = Constants.tableHeaderViewHeight - contentOffsetY
        } else {
            let contentOffsetY = min(scrollView.contentOffset.y + scrollView.contentInset.top + 64, 0)
            print(contentOffsetY)
            customView.frame.origin.y = -Constants.tableHeaderViewHeight
            customView.frame.size.height = Constants.tableHeaderViewHeight - contentOffsetY
            imageView.frame = customView.bounds
        }
    }
    
    func changeStyle() {
        headerStyle = headerStyle == .tableHeaderView ? .customView : .tableHeaderView
    }
}

extension ViewController {
    // 采用 tableHeaderView + 改变其 subView 的 frame 的方式
    func useTableHeaderView() {
        imageView.removeFromSuperview()
        imageView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.tableHeaderViewHeight)
        customView.removeFromSuperview()
        tableView.contentInset.top = 0
        tableHeaderView.addSubview(imageView)
        tableView.tableHeaderView = tableHeaderView
    }
    
    // 采用 tableView 的 subView + 设置 contentInset 的方式
    func useCustomView() {
        imageView.removeFromSuperview()
        imageView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.tableHeaderViewHeight)
        tableView.tableHeaderView = nil
        customView.addSubview(imageView)
        tableView.addSubview(customView)
        tableView.contentInset.top = Constants.tableHeaderViewHeight
        tableView.contentOffset.y = -Constants.tableHeaderViewHeight
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

