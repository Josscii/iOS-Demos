//
//  SecondViewController.swift
//  AnimateNavigationBarDemo
//
//  Created by josscii on 2018/2/6.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    weak var associatedNavigationBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(didPan(gesture:)))
        
        // navigationController 在手势的回调中可能已经不存在
        associatedNavigationBar = navigationController?.navigationBar
    }
    
    @objc func didPan(gesture: UIScreenEdgePanGestureRecognizer) {
        
        let total = UIScreen.main.bounds.width/2;
        let translation = gesture.translation(in: gesture.view).x
        
        let naviTotal: CGFloat = 88
        let currentTranslation = max(naviTotal - translation/total * naviTotal, 0);
        
        associatedNavigationBar?.transform = CGAffineTransform(translationX: 0, y: -currentTranslation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.animateSlideUp()
    }
}


extension UINavigationBar {
    func animateSlideUp() {
        let currentY = self.transform.ty;
        let duration: Double = 0.25 - Double((currentY/(-88)) * 0.25)
        
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(translationX: 0, y: -88)
        }
    }
    
    func animateIdentity() {
        let currentY = self.transform.ty;
        let duration: Double = 0.25 - Double((currentY/(-88)) * 0.25)
        
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
}
