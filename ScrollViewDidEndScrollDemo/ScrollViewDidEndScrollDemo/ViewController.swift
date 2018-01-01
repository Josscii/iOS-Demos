//
//  ViewController.swift
//  ScrollViewDidEndScrollDemo
//
//  Created by Josscii on 2017/11/18.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
    }
    
    // http://blog.lessfun.com/blog/2013/12/06/detect-uiscrollview-did-end-scrolling-animate/
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(scrollViewDidEndScroll), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }

    @objc func scrollViewDidEndScroll() {
        print("ended!")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            print("scrollViewDidEndDragging")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }
}

