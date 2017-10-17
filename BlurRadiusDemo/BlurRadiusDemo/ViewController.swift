//
//  ViewController.swift
//  BlurRadiusDemo
//
//  Created by josscii on 2017/10/17.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Lenna.png"))
        imageView.sizeToFit()
        imageView.center = view.center
        view.addSubview(imageView)
        
        // https://github.com/ML-Works/Bluuur
        // https://gist.github.com/n00neimp0rtant/27829d87118d984232a4
        let startEffect: UIBlurEffect? = nil
        let endEffect: UIBlurEffect? = UIBlurEffect(style: .light)
//        endEffect?.setValue(5, forKey: "blurRadius")
        let blurView = UIVisualEffectView(effect: endEffect)
        imageView.addSubview(blurView)
        blurView.frame = imageView.bounds
        
//        blurView.layer.speed = 0
//        blurView.layer.timeOffset = 0.5
//        UIView.animate(withDuration: 5) {
//            blurView.effect = endEffect
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

