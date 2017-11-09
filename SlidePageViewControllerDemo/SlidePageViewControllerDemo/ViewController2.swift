//
//  ViewController2.swift
//  SlidePageViewControllerDemo
//
//  Created by josscii on 2017/11/8.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

extension ViewController2: Reusable {
    var reuseIdentifier: String {
        get {
            return _reuseIdentifier
        }
        
        set {
            _reuseIdentifier = newValue
        }
    }
}

class ViewController2: UIViewController {
    
    var _reuseIdentifier: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear")
    }
}
