//
//  ViewController.swift
//  ToastAnimationDemo
//
//  Created by Josscii on 2017/11/5.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        makeToast()
//        keep()
        
        Toast.makeToast(toastBehavior: .keep)
    }
    
    func makeToast() {
        
        
        
        if view.viewWithTag(100) != nil {
//            return
            view.viewWithTag(100)?.removeFromSuperview()
        }
        
        let toast = UIView()
        toast.backgroundColor = .red
        toast.frame.size = CGSize(width: 40, height: 40)
        toast.center = view.center
        toast.layer.opacity = 0
        toast.tag = 100
        
        view.addSubview(toast)
        
        let stillDuration: Double = 1
        let inoutDuration: Double  = 0.25
        let totalDuration = inoutDuration * 2 + stillDuration
        let inkeyTime = NSNumber(value: inoutDuration/totalDuration)
        let outkeyTime = NSNumber(value: 1 - inoutDuration/totalDuration)
        
        let keyframeAnimation = CAKeyframeAnimation()
        keyframeAnimation.keyPath = "opacity"
        keyframeAnimation.values = [0, 1, 1, 0]
        keyframeAnimation.keyTimes = [0, inkeyTime, outkeyTime, 1]
        keyframeAnimation.duration = totalDuration
        keyframeAnimation.delegate = self
        toast.layer.add(keyframeAnimation, forKey: nil)
    }
    
    var hideDelayTimer: Timer?
    
    func keep() {
        if view.viewWithTag(100) == nil {
            let toast = UIView()
            toast.backgroundColor = .red
            toast.frame.size = CGSize(width: 40, height: 40)
            toast.center = view.center
            toast.alpha = 0
            toast.tag = 100
            
            view.addSubview(toast)
            
            UIView.animate(withDuration: 0.25, animations: {
                toast.alpha = 1
            })
        }
        
        hideDelayTimer?.invalidate()
        
        hideDelayTimer = Timer(timeInterval: 1, repeats: false, block: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.view.viewWithTag(100)?.alpha = 0
            }, completion: { _ in
                self.view.viewWithTag(100)?.removeFromSuperview()
            })
        })
        
        RunLoop.current.add(hideDelayTimer!, forMode: .commonModes)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        view.viewWithTag(100)?.removeFromSuperview()
    }
}

