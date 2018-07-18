//
//  ViewController4.swift
//  TableViewDemo
//
//  Created by josscii on 2018/7/12.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController5: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            tableView.prefetchDataSource = self
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "row \(indexPath.row)"
        
        print("cellForRowAt \(indexPath.row) \(CACurrentMediaTime())")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay \(indexPath.row) \(CACurrentMediaTime())")
    }
}

extension ViewController5: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
}
