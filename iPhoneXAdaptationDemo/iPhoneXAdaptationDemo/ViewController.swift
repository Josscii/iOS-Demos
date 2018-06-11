//
//  ViewController.swift
//  iPhoneXAdaptationDemo
//
//  Created by josscii on 2018/4/2.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.isHidden = true
//
//        let label = UILabel()
//        label.text = "ggg"
//        view.addSubview(label)
//        label.sizeToFit()
        
//        edgesForExtendedLayout
//        extendedLayoutIncludesOpaqueBars
        
//        tableView2 = UITableView(frame: CGRect(x: 0, y: 34, width: 300, height: view.bounds.height-300))
//        tableView2.backgroundColor = .red
//        view.addSubview(tableView2)
//        tableView2.delegate = self
//        tableView2.dataSource = self
//        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView2.isHidden = true
        
//        tableView2.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.init(item: tableView2, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
//        NSLayoutConstraint.init(item: tableView2, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint.init(item: tableView2, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
//        NSLayoutConstraint.init(item: tableView2, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        
//        view1 = UIView()
//        view.addSubview(view1)
//
//        view1.frame = CGRect(x: 0, y: 30, width: view.bounds.width, height: 400)
//
//        view2 = UIView()
//        view1.addSubview(view2)
//
//        view2.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 400)
    }
    
    var view1: UIView!
    var view2: UIView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            print(tableView.adjustedContentInset)
//            print(view.safeAreaInsets)
//            print(view1.safeAreaInsets)
//            print(view2.safeAreaInsets)
        } else {
//            print(tableView2.contentInset)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "😇😍😍"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

