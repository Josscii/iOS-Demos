//
//  ViewController.swift
//  ArchiveCacheManager
//
//  Created by mxl on 2017/7/25.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cacheValue = ["haha": 123]
        ArchiveCache.shared.save(key: "test", value: cacheValue, seconds: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

