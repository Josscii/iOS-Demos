//
//  ViewController2.swift
//  TableViewDemo
//
//  Created by josscii on 2018/2/7.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 44
    }
    
    var text = "诚然，有不少人表示 Universal Clipboard 用起来很顺畅、没有遇到问题"
    var more = false
    
    var num = 2
    
    @IBAction func change(_ sender: Any) {
        more = !more
        if more {
            text = "诚然，有不少人表示 Universal Clipboard 用起来很顺畅、没有遇到问题，但也有一批人因为这个功能，系统出现了这样那样的问题，甚至影响到了正常的使用。当一个功能到了影响效率的时候，就有必要想解决办法了"
        } else {
            text = "诚然，有不少人表示 Universal Clipboard 用起来很顺畅、没有遇到问题"
        }
        
//        tableView.beginUpdates()
//        tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0), IndexPath.init(row: 1, section: 0)], with: .automatic)
//        tableView.endUpdates()
        
//        UIView.performWithoutAnimation {
//            tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0), IndexPath.init(row: 1, section: 0)], with: .automatic)
//        }
        
//        UIView.setAnimationsEnabled(false)
//        tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0), IndexPath.init(row: 1, section: 0)], with: .automatic)
//        UIView.setAnimationsEnabled(true)
        
//        tableView.reloadData()
        
//        num = 1
        
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
//        tableView.deleteRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
//        tableView.endUpdates()
    }
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.titleLabel.text = text
        
        return cell
    }
}
