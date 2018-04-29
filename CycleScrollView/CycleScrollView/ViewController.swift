//
//  ViewController.swift
//  CycleScrollView
//
//  Created by josscii on 2018/4/10.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scrollView: UIScrollView!
    
    var colors: [UIColor] = [.red, .yellow]
    var preView: UIView!
    var currentView: UIView!
    var nextView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        preView = UIView()
        preView.backgroundColor = .yellow
        preView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        
        currentView = UIView()
        currentView.backgroundColor = .red
        currentView.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: 300)
        
        nextView = UIView()
        nextView.backgroundColor = .yellow
        nextView.frame = CGRect(x: view.frame.width * 2, y: 0, width: view.frame.width, height: 300)
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 300)
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: 300)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentOffset.x = view.frame.width
        
        scrollView.addSubview(preView)
        scrollView.addSubview(currentView)
        scrollView.addSubview(nextView)
        
        view.addSubview(scrollView)
    }
    
    var currentIndex = 0
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= view.frame.width * 2 {
            scrollView.contentOffset.x = view.frame.width
            
            preView.backgroundColor = currentView.backgroundColor
            currentView.backgroundColor = nextView.backgroundColor
            nextView.backgroundColor = nextCycleColor(color: nextView.backgroundColor!)
        }
        
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset.x = view.frame.width
            
            nextView.backgroundColor = currentView.backgroundColor
            currentView.backgroundColor = preView.backgroundColor
            preView.backgroundColor = preCycleColor(color: preView.backgroundColor!)
        }
    }
    
    func nextCycleColor(color: UIColor) -> UIColor {
        return colors[(colors.index(of: color)!+1) % 2]
    }
    
    func preCycleColor(color: UIColor) -> UIColor {
        var index = colors.index(of: color)!-1
        if index < 0 {
            index = 1
        }
        return colors[index % 2]
    }
}

