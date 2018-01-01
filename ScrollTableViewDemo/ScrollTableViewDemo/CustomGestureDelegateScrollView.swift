//
//  CustomGestureDelegateScrollView.swift
//  ScrollTableViewDemo
//
//  Created by Josscii on 2017/10/1.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class CustomScrollView: UIScrollView {
    var shouldScroll = true
}

class CustomTableView: UITableView, UIGestureRecognizerDelegate {
    var shouldScroll = false
    weak var outerScrollView: CustomScrollView?
    
    init(frame: CGRect, outerScrollView: CustomScrollView) {
        super.init(frame: frame, style: .plain)
        self.outerScrollView = outerScrollView
        self.delegate = self
        self.dataSource = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(shouldResetOffset), name: NSNotification.Name.init("test"), object: nil)
    }
    
    @objc func shouldResetOffset() {
        contentOffset = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let _ = otherGestureRecognizer.view as? UIScrollView,
            otherGestureRecognizer is UIPanGestureRecognizer {

            return true
        }

        return false
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let scrollView = otherGestureRecognizer.view as? UIScrollView,
            let superView = superview,
            scrollView == superView,
            otherGestureRecognizer is UIPanGestureRecognizer {
            return true
        }

        return false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let outerScrollView = outerScrollView else { return }
        
        if (outerScrollView.contentOffset.y < 250 && contentOffset.y <= 0)  {
            outerScrollView.shouldScroll = true
            shouldScroll = false
        }
        
        if (contentOffset.y > 0 && outerScrollView.contentOffset.y >= 250) {
            outerScrollView.shouldScroll = false
            shouldScroll = true
        }
        
        if !shouldScroll {
//            NotificationCenter.default.post(name: NSNotification.Name.init("test"), object: nil)
            contentOffset = .zero
            showsVerticalScrollIndicator = false
        } else {
            showsVerticalScrollIndicator = true
        }
        
        if !outerScrollView.shouldScroll {
            outerScrollView.contentOffset = CGPoint(x: 0, y: 250)
        }
    }
}

extension CustomTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }
}
