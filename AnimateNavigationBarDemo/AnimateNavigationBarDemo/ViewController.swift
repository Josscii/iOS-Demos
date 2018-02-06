//
//  ViewController.swift
//  AnimateNavigationBarDemo
//
//  Created by josscii on 2018/2/6.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.barTintColor = .red
        
//        navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(didPan(gesture:)))
    }
    
    @objc func didPan(gesture: UIScreenEdgePanGestureRecognizer) {
        
        let total = self.view.frame.width/2;
        let translation = gesture.translation(in: gesture.view).x
        
        let naviTotal: CGFloat = 88
        let currentTranslation = max(naviTotal - translation/total * naviTotal, 0);
        
        self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -currentTranslation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.animateSlide(up: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

