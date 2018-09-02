//
//  ViewController.swift
//  CoreAnimationDemo
//
//  Created by Josscii on 2018/9/2.
//  Copyright © 2018 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var layer1: CALayer!
    var layer2: CALayer!
    var layer3: CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        layer1 = CALayer()
        layer1.frame = CGRect(x: 50, y: 500, width: 100, height: 200)
        layer1.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(layer1)
        
        layer2 = CALayer()
        layer2.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer2.backgroundColor = UIColor.green.cgColor
        layer1.addSublayer(layer2)
        
        layer3 = CALayer()
        layer3.frame = CGRect(x: 50, y: 0, width: 50, height: 50)
        layer3.backgroundColor = UIColor.yellow.cgColor
        layer1.addSublayer(layer3)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        /*
        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        let c = CACurrentMediaTime()
        let time1 = layer1.convertTime(c, from: nil)
        layer1.beginTime = time1
        layer1.fillMode = kCAFillModeBackwards

        
        layer1.frame.origin.y = 50
//        let time = layer3.convertTime(CACurrentMediaTime(), from: nil)
        layer3.beginTime = 2
        layer3.fillMode = kCAFillModeBackwards
        
        layer3.frame.origin.y = 50
        layer1.autoreverses = true
        layer1.repeatCount = 20
        CATransaction.commit()
         */
        
        let g = CAAnimationGroup()
        g.animations = [
    }
}

