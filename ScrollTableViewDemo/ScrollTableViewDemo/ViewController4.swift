//
//  ViewController4.swift
//  ScrollTableViewDemo
//
//  Created by Josscii on 2017/11/26.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class CollaborativeScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    var lastContentOffset: CGPoint = CGPoint(x: 0, y: 0)
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return otherGestureRecognizer.view is CollaborativeScrollView
//    }
}

class YourViewController: UIViewController, UIScrollViewDelegate {
    
    private var mLockOuterScrollView = false
    
    var mOuterScrollView: CollaborativeScrollView!
    var mInnerScrollView: CollaborativeScrollView!
    
    enum Direction {
        case none, left, right, up, down
    }
    
    override func viewDidLoad() {
        
        mOuterScrollView = CollaborativeScrollView(frame: view.bounds)
        mOuterScrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height+300)
        mOuterScrollView.backgroundColor = .green
        view.addSubview(mOuterScrollView)
        
        mInnerScrollView = CollaborativeScrollView(frame: CGRect(x: 0, y: 300, width: view.bounds.width, height: view.bounds.height))
        mInnerScrollView.contentSize = CGSize(width: view.bounds.width, height: 2000)
        mInnerScrollView.backgroundColor = .red
        mOuterScrollView.addSubview(mInnerScrollView)
        
        
        mOuterScrollView.delegate = self
        mInnerScrollView.delegate = self
//        mInnerScrollView.bounces = false
//        mOuterScrollView.showsVerticalScrollIndicator = false
        
//        mInnerScrollView.panGestureRecognizer.require(toFail: mOuterScrollView.panGestureRecognizer)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mOuterScrollView {
            
        } else {
            
            let direction: Direction
            if mInnerScrollView.lastContentOffset.y > scrollView.contentOffset.y {
                direction = .down
            } else {
                direction = .up
            }
            
            if direction == .up && mOuterScrollView.contentOffset.y < 300 {
                mInnerScrollView.isScrollEnabled = false
            } else {
                mInnerScrollView.isScrollEnabled = true
            }
            
            mInnerScrollView.lastContentOffset = scrollView.contentOffset;
        }
    }
}
