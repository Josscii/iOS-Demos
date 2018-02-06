//
//  SecondViewController.swift
//  AnimateNavigationBarDemo
//
//  Created by josscii on 2018/2/6.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(didPan(gesture:)))
    }
    
    @objc func didPan(gesture: UIScreenEdgePanGestureRecognizer) {
        
        let total = UIScreen.main.bounds.width/2;
        let translation = gesture.translation(in: gesture.view).x
        
        let naviTotal: CGFloat = 88
        let currentTranslation = max(naviTotal - translation/total * naviTotal, 0);
        
        self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -currentTranslation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.animateSlide(up: true)
    }
}


extension UINavigationBar {
    func animateSlide(up: Bool) {
        UIView.animate(withDuration: 0.25) {
            if up {
                self.transform = CGAffineTransform(translationX: 0, y: -88)
            } else {
                self.transform = .identity
            }
        }
    }
}
