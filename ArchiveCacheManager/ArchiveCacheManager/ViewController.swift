//
//  ViewController.swift
//  ArchiveCacheManager
//
//  Created by mxl on 2017/7/25.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class Model: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(a, forKey: "a")
//        aCoder.encode(b, forKey: "b")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    let a = ""
    let b = 3
    
    override init() {
        
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cacheValue = ["haha": 123]
        let classValue = Model()
//        ArchiveCache.shared.save(key: "test", value: classValue, seconds: 60)
        
        ArchiveCache.shared.delete(key: "test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

