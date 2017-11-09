//
//  SlidePageViewController.swift
//  SlidePageViewControllerDemo
//
//  Created by josscii on 2017/11/8.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class SlidePageViewController: UIViewController {
    
    var viewControllers: [UIViewController]?
    var selectedIndex: Int {
        get {
            guard let scrollView = innerScrollView else {
                return 0
            }
            
            return Int(scrollView.contentOffset.x / view.bounds.width)
        }
        
        set {
            guard let scrollView = innerScrollView,
                  let viewControllers = viewControllers,
                  newValue < viewControllers.count else {
                return
            }
            
            scrollView.setContentOffset(CGPoint(x: CGFloat(newValue) * view.bounds.width, y: 0), animated: animatedSelection)
        }
    }
    
    var animatedSelection = false
    
    var innerScrollView: UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        guard let viewControllers = viewControllers,
            viewControllers.count > 0 else {
             return
        }
        
        innerScrollView = UIScrollView(frame: view.bounds)
        innerScrollView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        innerScrollView?.isPagingEnabled = true
        innerScrollView?.bounces = false
        innerScrollView?.delegate = self
        innerScrollView?.contentSize = CGSize(width: view.bounds.width * CGFloat(viewControllers.count), height: view.bounds.height)
        view.addSubview(innerScrollView!)
        
        add(asChildViewController: viewControllers[0])
    }
}

extension SlidePageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let currentIndex = Int(ceil(contentOffsetX / view.bounds.width))
        for i in 0 ..< viewControllers!.count {
            if i != currentIndex {
                remove(asChildViewController: viewControllers![i])
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let panGesture = scrollView.panGestureRecognizer
        let velocity = panGesture.velocity(in: scrollView)
        if velocity.x < 0 {
            let addIndex = min(viewControllers!.count-1, Int(ceil(contentOffsetX / view.bounds.width)))
            add(asChildViewController: viewControllers![addIndex])
            
            let removeIndex = Int(floor(contentOffsetX / view.bounds.width))-1
            if removeIndex >= 0 {
                remove(asChildViewController: viewControllers![removeIndex])
            }
        } else if velocity.x > 0 {
            let addIndex = max(0, Int(floor(contentOffsetX / view.bounds.width)))
            add(asChildViewController: viewControllers![addIndex])
            
            let removeIndex = Int(ceil(contentOffsetX / view.bounds.width))+1
            if removeIndex < viewControllers!.count {
                remove(asChildViewController: viewControllers![removeIndex])
            }
        } else {
            if childViewControllers.count == 0 {
                add(asChildViewController: viewControllers![0])
            }
        }
    }
}

extension SlidePageViewController {
    private func add(asChildViewController viewController: UIViewController) {
        guard !childViewControllers.contains(viewController) else {
            return
        }
        
        let index = viewControllers!.index(of: viewController)!
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        innerScrollView?.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = CGRect(x: CGFloat(index) * view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        guard childViewControllers.contains(viewController) else {
            return
        }
        
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
}
