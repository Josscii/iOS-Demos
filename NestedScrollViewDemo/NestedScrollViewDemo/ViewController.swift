//
//  ViewController.swift
//  NestedScrollViewDemo
//
//  Created by josscii on 2017/11/27.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class SelfDelegateScrollView: UITableView, UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}

class ViewController: UIViewController {
    var scrollView1: UITableView!
    var scrollView2: SelfDelegateScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView1 = UITableView(frame: view.bounds)
        scrollView1.backgroundColor = .red
        scrollView1.showsVerticalScrollIndicator = false
        view.addSubview(scrollView1)
        
        scrollView2 = SelfDelegateScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-200))
        scrollView2.backgroundColor = .green
//        scrollView1.addSubview(scrollView2)
        
        scrollView1.delegate = self
        scrollView1.dataSource = self
        scrollView2.delegate = self
        scrollView2.dataSource = self
    }
    
//    var outterCanScroll = true {
//        didSet {
//            scrollView1.isScrollEnabled = outterCanScroll
//        }
//    }
//    var innerCanScroll = false
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == scrollView2 {
            return 20
        }
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == scrollView2 {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == scrollView2 {
            return 50
        }
        
        if indexPath.section == 0 {
            return 300
        }
        
        return view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if tableView == scrollView2 {
            cell.backgroundColor = .yellow
            return cell
        }
        
        if indexPath.section == 1 {
            cell.contentView.addSubview(scrollView2)
        }
        
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if abs(scrollView1.contentOffset.y - 300) < 50 {
//            UIView.animate(withDuration: 0.25, animations: {
//                self.scrollView1.contentOffset.y = 300
//            })
//        }
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            if abs(scrollView1.contentOffset.y - 300) < 50 {
//                UIView.animate(withDuration: 0.25, animations: {
//                    self.scrollView1.contentOffset.y = 300
//                })
//            }
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == scrollView1 {
            
            print(scrollView.contentOffset)
            if scrollView.contentOffset.y > 300 {
                scrollView.bounds.origin.y = 300
            }
        } else {
//            if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.height {
//                scrollView1.isScrollEnabled = false
//            } else {
//                scrollView1.isScrollEnabled = true
//            }
        }
        
        
//        if scrollView == scrollView2 {
//
//            if scrollView.contentOffset.y < 0  {
//                scrollView1.isScrollEnabled = true
//                scrollView1.contentOffset.y += scrollView.contentOffset.y
//                scrollView.contentOffset.y = 0
//            }
//
//            if (scrollView.contentOffset.y > 0 && scrollView1.contentOffset.y < 300) {
//                scrollView1.isScrollEnabled = false
//                var contentOffsetY = scrollView1.contentOffset.y
//                contentOffsetY += scrollView.contentOffset.y
//                scrollView1.contentOffset.y = min(contentOffsetY, 300)
//                scrollView.contentOffset.y = 0
//            }
//
//            if scrollView.contentOffset.y > 0 {
//                scrollView1.isScrollEnabled = false
//            }
//        } else {
//
//            if scrollView.contentOffset.y == 0 {
//                scrollView.isScrollEnabled = true
//                scrollView2.contentOffset.y = 0
//            }
//
//            if scrollView.contentOffset.y > 300 {
//                var contentOffsetY = scrollView2.contentOffset.y
//                contentOffsetY += scrollView.contentOffset.y - 300
//                scrollView2.contentOffset.y = min(contentOffsetY, view.bounds.height)
//                scrollViewDidScroll(scrollView2)
//
//                scrollView.contentOffset.y = 300
////                scrollView.isScrollEnabled = false
//            }
//
//
//        }
    }
}

