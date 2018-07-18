//
//  ViewController.swift
//  ReloadSecionDemo
//
//  Created by josscii on 2018/7/10.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    override var numberOfSections: Int {
        print("numberOfSections")
        return super.numberOfSections
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        print("numberOfRows")
        return super.numberOfRows(inSection: section)
    }
}

class ViewController: UIViewController {
    
    var tableView: CustomTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = CustomTableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    var data = [
        ["haha", "xixi", "enen", "enen", "enen", "enen", "enen", "enen", "enen","enen","enen","enen","enen","enen","enen","enen","enen","enen","enen", "enen", "enen","enen","enen","enen","enen","enen","enen","enen","enen","enen","enen"],
        ["nono", "fafa"]
    ]
    
    
    @IBAction func reloadSecion(_ sender: Any) {
        
//        data[0].append("yaya")
//        data[1].append("yaya")
//        data[0].remove(at: 0)
//        tableView.reloadData()
        
//        tableView.reloadSections(IndexSet.init(integer: 0), with: .none)
        
//        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        tableView.insertRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .left)
//        tableView.performBatchUpdates({
//            tableView.reloadSections(IndexSet(integer: 1), with: .right)
//
//        }, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell!.textLabel?.text = data[indexPath.section][indexPath.row]
        
        return cell!
    }
}

