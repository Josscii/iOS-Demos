//
//  ViewController.swift
//  TableViewDemo
//
//  Created by josscii on 2018/2/7.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

/*
 测试 tableView 算高、加载 cell 和 estimatedRowHeight 的关系
 */

class ViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = 100
        print(UITableViewAutomaticDimension)
        
        
        /*
         iOS 11
         -1 用默认值 44 来计算高度和预加载 cell，默认
         0 计算所有 cell 高度，只加载屏幕内 cell
         >0 用 estimatedRowHeight 来计算高度和预加载 cell
         
         < iOS 11
         <= 0 计算所有 cell 高度，只加载屏幕内 cell，默认
         >0 用 estimatedRowHeight 来计算高度和预加载 cell
         */
    }
    
    @IBAction func reload(_ sender: Any) {
        
        /*
         
         Call this method to reload all the data that is used to construct the table, including cells, section headers and footers, index arrays,
         and so on. For efficiency, the table view redisplays only those rows that are visible. It adjusts offsets if the table shrinks as a result
         of the reload. The table view’s delegate or data source calls this method when it wants the table view to completely reload its data. It
         should not be called in the methods that insert or delete rows, especially within an animation block implemented with calls to
         beginUpdates() and endUpdates().
 
         */
        
        tableView.reloadData()
    }
    
    var addArr: [String] = []
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellAdd = cell.pointerString
        
        if addArr.contains(cellAdd) {
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .black
            addArr.append(cellAdd)
        }
        
        cell.textLabel?.text = "row \(indexPath.row) add \(cellAdd)"
        print("cell row \(indexPath.row)")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("height row \(indexPath.row)")
        return 100
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100;//CGFloat(arc4random_uniform(50) + 200)
//    }
}

public extension NSObject {
    public var pointerString: String {
        return String(format: "%p", self)
    }
}
