//
//  Toast.swift
//  ToastAnimationDemo
//
//  Created by josscii on 2018/2/5.
//  Copyright © 2018年 Josscii. All rights reserved.
//

import UIKit

enum ToastBehavior {
    case once
    case replace
    case keep
}

class Toast {
    static var toastView: UIView?
    static var hideDelayTimer: Timer?
    
    class func makeToast(toastBehavior: ToastBehavior = .once) {
        
        switch toastBehavior {
        case .once:
            if toastView != nil {
                return
            }
        case .replace:
            toastView?.removeFromSuperview()
        case .keep:
            keep()
            return;
        }
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        toastView = UIView()
        toastView?.backgroundColor = .red
        toastView?.frame.size = CGSize(width: 40, height: 40)
        toastView?.center = window.center
        toastView?.alpha = 0
        
        window.addSubview(toastView!)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.toastView?.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 1, options: [.curveLinear], animations: {
                toastView?.alpha = 0
            }, completion: { finished in
                if finished {
                    toastView?.removeFromSuperview()
                    toastView = nil
                }
            })
        }
    }
    
    class func keep() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        if toastView == nil {
            toastView = UIView()
            toastView?.backgroundColor = .red
            toastView?.frame.size = CGSize(width: 40, height: 40)
            toastView?.center = window.center
            toastView?.alpha = 0
            
            window.addSubview(toastView!)
            
            UIView.animate(withDuration: 0.25, animations: {
                toastView?.alpha = 1
            })
        }
        
        hideDelayTimer?.invalidate()
        
        hideDelayTimer = Timer(timeInterval: 1, repeats: false, block: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                toastView?.alpha = 0
            }, completion: { _ in
                toastView?.removeFromSuperview()
                toastView = nil
            })
        })
        
        RunLoop.current.add(hideDelayTimer!, forMode: .commonModes)
    }
}
