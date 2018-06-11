//
//  ViewController.swift
//  ProfileDemo
//
//  Created by Josscii on 2018/6/10.
//  Copyright © 2018 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func helloHereIsMyAsyncPrint() {
        print("helloHereIsMyAsyncPrint")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test  __CFRunLoopDoBlocks
        RunLoop.current.perform(inModes: [.commonModes]) {
            for _ in 0..<100 {
                let v = UIView()
                v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                self.view.addSubview(v)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for _ in 0..<100 {
            let v = UIView()
            v.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
            v.backgroundColor = .red
            self.view.addSubview(v)
            
            UIView.animate(withDuration: 5) {
                v.frame = CGRect(x: 50, y: 200, width: 50, height: 50)
                v.backgroundColor = .green
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "row \(indexPath.row)"
        
        // test __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__
        DispatchQueue.main.async {
            self.helloHereIsMyAsyncPrint()
        }
        
        return cell
    }
}
