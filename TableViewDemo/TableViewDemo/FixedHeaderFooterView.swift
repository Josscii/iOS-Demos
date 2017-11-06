//
//  FixedHeaderFooterView.swift
//  TableViewDemo
//
//  Created by josscii on 2017/11/6.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

enum FixedSectionType {
    case header
    case footer
}


// http://johnwong.github.io/mobile/2015/07/04/ios-quirks.html
class FixedHeaderFooterView: UIView {
    var section: Int
    weak var tableView: UITableView!
    var type: FixedSectionType
    
    init(tableView: UITableView, section: Int, type: FixedSectionType) {
        self.tableView = tableView
        self.section = section
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        set(newValue) {
            var newValue = newValue
            let sectionRect = tableView.rect(forSection: section)
            var y: CGFloat = 0
            switch type {
            case .header:
                y = sectionRect.minY
            case .footer:
                y = sectionRect.maxY - newValue.height
            }
            newValue.origin.y = y
            super.frame = newValue
        }
        
        get {
            return super.frame
        }
    }
}
