//
//  ViewController2.swift
//  iPhoneXAdaptationDemo
//
//  Created by josscii on 2018/4/2.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let v = UIView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
//        testView.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(whiteView.safeAreaInsets)
    }

}
