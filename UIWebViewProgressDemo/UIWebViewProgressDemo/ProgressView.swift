//
//  ProgressView.swift
//  UIWebViewProgressDemo
//
//  Created by Josscii on 2017/8/6.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    var progressLayer: CAShapeLayer!
    var progressPath: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.lineWidth = 2
        progressLayer.strokeEnd = 0
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: progressLayer.bounds.maxX, y: 0))
        
        progressLayer.path = path.cgPath
        
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        
        if (progressLayer.animation(forKey: "start") != nil) ||
            (progressLayer.animation(forKey: "finish") != nil) {
            return
        }
        
        progressLayer.strokeEnd = 0
        progressLayer.opacity = 1
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        keyFrameAnimation.values = [0, 0.5, 0.8]
        keyFrameAnimation.keyTimes = [0, 0.4, 1]
        keyFrameAnimation.duration = 10
        keyFrameAnimation.isRemovedOnCompletion = false
        keyFrameAnimation.fillMode = "forwards"
        progressLayer.add(keyFrameAnimation, forKey: "start")
    }
    
    func finishAnimation() {
        if (progressLayer.animation(forKey: "finish") != nil) {
            return
        }
        
        progressLayer.strokeEnd = (progressLayer.presentation()! as CAShapeLayer).strokeEnd
        progressLayer.removeAnimation(forKey: "start")
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.toValue = 1
        anim.duration = 0.3
        anim.isRemovedOnCompletion = false
        anim.fillMode = "forwards"
        anim.delegate = self
        progressLayer.add(anim, forKey: "finish")
    }
}

extension ProgressView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        progressLayer.strokeEnd = 1
        progressLayer.removeAnimation(forKey: "finish")
        progressLayer.opacity = 0
    }
}
