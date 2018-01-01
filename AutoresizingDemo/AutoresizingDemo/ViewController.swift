//
//  ViewController.swift
//  AutoresizingDemo
//
//  Created by Josscii on 2017/10/22.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

//https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/CreatingViews/CreatingViews.html#//apple_ref/doc/uid/TP40009503-CH5-SW1

enum DragType {
    case resize
    case pan
}

class ViewController: UIViewController {
    
    var superView: UIView!
    var resizeAreaView: UIView!
    var autoReizingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        superView = UIView()
        superView.backgroundColor = UIColor.red
        superView.frame.size = CGSize(width: 200, height: 200)
        superView.center = view.center
        view.addSubview(superView)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragToResize(gestureRecognizer:)))
        superView.addGestureRecognizer(panGesture)
        
        resizeAreaView = UIView(frame: CGRect(x: 200-cornerSize.width, y: 200-cornerSize.height, width: cornerSize.width, height: cornerSize.height))
        resizeAreaView.layer.zPosition = 1
        resizeAreaView.backgroundColor = UIColor.green
        resizeAreaView.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
        superView.addSubview(resizeAreaView)
        
        autoReizingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        autoReizingView.center = CGPoint(x: 100, y: 100)
        autoReizingView.backgroundColor = .yellow
        // When you configure a view that has more than one flexible attribute along a single axis, UIKit distributes any size changes evenly among the corresponding spaces.
        autoReizingView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        superView.addSubview(autoReizingView)
    }
    
    var dragType: DragType = .pan
    let cornerSize = CGSize(width: 40, height: 40)
    @objc func dragToResize(gestureRecognizer: UIPanGestureRecognizer) {
        let gestureView = gestureRecognizer.view!
        switch gestureRecognizer.state {
        case .began:
            let startPoint = gestureRecognizer.location(in: gestureView)
            let cornerRect = CGRect(x: gestureView.bounds.size.width-cornerSize.width, y: gestureView.bounds.size.height-cornerSize.height, width: cornerSize.width, height: cornerSize.height)
            if cornerRect.contains(startPoint) {
                dragType = .resize
            } else {
                dragType = .pan
            }
        case .changed:
            let translation = gestureRecognizer.translation(in: gestureView)
            if dragType == .resize {
                gestureView.frame.size.height += translation.y
                gestureView.frame.size.width += translation.x
            } else {
                gestureView.frame.origin.x += translation.x
                gestureView.frame.origin.y += translation.y
            }
            gestureRecognizer.setTranslation(.zero, in: gestureView)
        default:
            break
        }
    }
}

