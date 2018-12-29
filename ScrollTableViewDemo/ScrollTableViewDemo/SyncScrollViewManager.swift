//
//  SyncScrollViewManager.swift
//  ScrollTableViewDemo
//
//  Created by Josscii on 2017/11/21.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class SyncScrollViewManager: NSObject {
    
    var changeHeight: CGFloat = 0
    
    static let shared = SyncScrollViewManager()
         weak var outerScrollView: UIScrollView? {
        didSet {
            oldValue?.removeObserver(self, forKeyPath: "bounds")
            outerScrollView?.addObserver(self, forKeyPath: "bounds", options: [.new], context: nil)
        }
    }
    weak var innerScrollView: UIScrollView? {
        didSet {
            oldValue?.removeObserver(self, forKeyPath: "bounds")
            innerScrollView?.addObserver(self, forKeyPath: "bounds", options: [.new], context: nil)
        }
    }
    
    var outerShouldScroll = true
    var innerShouldScroll = false
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let scrollView = object as? UIScrollView,
              let innerScrollView = innerScrollView,
              let outerScrollView = outerScrollView
            else { return }
        
        if scrollView == innerScrollView {
            
            if innerScrollView.contentOffset.y <= 0  {
                outerShouldScroll = true
                innerShouldScroll = false
            }
            
            if !innerShouldScroll {
                innerScrollView.contentOffset = .zero
                innerScrollView.showsVerticalScrollIndicator = false
            }
            
            // 防止内部 scrollView 无法上拉的问题
            if innerScrollView.contentOffset.y >= innerScrollView.contentSize.height - innerScrollView.bounds.height {
                outerScrollView.isScrollEnabled = false
            } else {
                outerScrollView.isScrollEnabled = true
            }
            
        } else if scrollView == outerScrollView {
            
            if outerScrollView.contentOffset.y >= changeHeight {
                outerShouldScroll = false
                innerShouldScroll = true
                
                // 防止上滑刚好到临界点时，无法向下滑动问题
                if outerScrollView.contentOffset.y == changeHeight &&
                    innerScrollView.contentOffset.y <= 0 &&
                    outerScrollView.panGestureRecognizer.translation(in: outerScrollView).y > 0 {
                    outerShouldScroll = true
                    innerShouldScroll = false
                }
            }
            
            if !outerShouldScroll {
                outerScrollView.contentOffset = CGPoint(x: 0, y: changeHeight)
                innerScrollView.showsVerticalScrollIndicator = true
            }
        }
    }
}
