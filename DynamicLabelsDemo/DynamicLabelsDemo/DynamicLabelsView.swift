//
//  DynamicLabelsView.swift
//  DynamicLabelsDemo
//
//  Created by Josscii on 2017/8/7.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class DynamicLabelsView: UIView {
    var labels: [UILabel] = []
    var dynamicConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        dynamicConstraints.append(heightConstraint)
        
        for i in 0..<4 {
            let label = UILabel()
            label.backgroundColor = .red
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            labels.append(label)
            
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
            
            let bottomConstraint = label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            dynamicConstraints.append(bottomConstraint)
            
            if i == 0 {
                label.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
                continue
            }
            
            label.topAnchor.constraint(equalTo: labels[i-1].bottomAnchor, constant: 10).isActive = true
        }
    }
    
    func setup(with strings: [String]) {
        dynamicConstraints.forEach { $0.isActive = false }
        
        let count = strings.count
        
        for i in 0..<count {
            if i == 3 {
                labels[i].text = "查看\(count)条评论"
                break
            }
            
            labels[i].text = strings[i]
        }
        
        let index = min(count, 4)
        dynamicConstraints[index].isActive = true
    }
}
