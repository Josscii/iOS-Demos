//
//  ViewController2.swift
//  SwiftExtensions
//
//  Created by josscii on 2017/7/28.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var contentOffsetLabel: UILabel!
    
    @IBOutlet weak var topInsetsSlider: UISlider!
    @IBOutlet weak var bottomInsetsSlider: UISlider!
    @IBOutlet weak var contentHeightSlider: UISlider!
    
    @IBOutlet weak var topInsetsLabel: UILabel!
    @IBOutlet weak var bottomInsetsLabel: UILabel!
    @IBOutlet weak var contentHeightLabel: UILabel!
    
    var contentHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        scrollView.layer.borderColor = UIColor.green.cgColor
        scrollView.layer.borderWidth = 1
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        view.addSubview(scrollView)
        
        NSLayoutConstraint(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300).isActive = true
        
        contentView = UIView()
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 1
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 1).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1.0, constant: 1).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1.0, constant: -1).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: -1).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 198).isActive = true
        contentHeightConstraint = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400)
        contentHeightConstraint.isActive = true
        
        contentOffsetLabel = UILabel()
        contentOffsetLabel.textColor = UIColor.brown
        contentOffsetLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentOffsetLabel)
        
        NSLayoutConstraint(item: contentOffsetLabel, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: contentOffsetLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        
        topInsetsSlider.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        bottomInsetsSlider.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        contentHeightSlider.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetLabel.text = "\(scrollView.contentOffset)"
    }
    
    func valueChanged(sender: UISlider) {
        if sender == topInsetsSlider {
            scrollView.contentInset.top = CGFloat(sender.value)
            topInsetsLabel.text = "contentInsets.top = \(Int(sender.value))"
        } else if sender == bottomInsetsSlider {
            scrollView.contentInset.bottom = CGFloat(sender.value)
            bottomInsetsLabel.text = "contentInsets.bottom = \(Int(sender.value))"
        } else {
            contentHeightConstraint.constant = CGFloat(sender.value)
            contentHeightLabel.text = "contentSize.height = \(Int(sender.value))"
        }
    }
}
