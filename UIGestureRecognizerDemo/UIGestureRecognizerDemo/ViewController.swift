//
//  ViewController.swift
//  UIGestureRecognizerDemo
//
//  Created by josscii on 2018/4/2.
//  Copyright © 2018年 josscii. All rights reserved.
//

// https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CustomGesture: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

class CustomView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cView = CustomView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        cView.backgroundColor = .red
        view.addSubview(cView)
        
        let gesture = CustomGesture(target: self, action: #selector(invokeGesture(gesture:)))
        cView.addGestureRecognizer(gesture)
    }
    
    @objc func invokeGesture(gesture: CustomGesture) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

