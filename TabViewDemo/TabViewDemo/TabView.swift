//
//  TabView.swift
//  ListLayout
//
//  Created by josscii on 2018/7/17.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

protocol TabViewDelegate: class {
    func tabView(_ tabView: TabView, configureIndicatorViewWith superView: UIView)
    func tabView(_ tabView: TabView, configureItemViewAt index: Int, with cell: TabItemCell)
    func tabView(_ tabView: TabView, didSelect itemView: TabItemView, at index: Int)
    
    func numberOfItems(in tabView: TabView) -> Int
}

enum TabViewWidthType {
    case fixed(width: CGFloat)
    case evenly
}

class TabItemCell: UICollectionViewCell {
    var itemView: TabItemView?
    
    static let reuseIdentifier = "TabItemCell"
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        
        set {
            super.isSelected = newValue
            itemView?.isSelected = newValue
        }
    }
}

protocol TabItemView {
    var isSelected: Bool { get set }
}

class SimpleTabItemView: UIView, TabItemView {
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    }
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                label.textColor = .red
            } else {
                label.textColor = .black
            }
        }
    }
}

class TabView: UIView {
    
    weak var delegate: TabViewDelegate?
    
    var widthType: TabViewWidthType = .evenly
    
    var collectionView: UICollectionView!
    var collectionViewLayout: UICollectionViewFlowLayout!
    
    var indicatorSuperView: UIView!
    
    var selectedIndex = 0
    var animationDuration = 0.25
    
    var isFirstInit = true
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
        configureIndicatorSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPrefetchingEnabled = false
        addSubview(collectionView)
    }
    
    func configureIndicatorSuperView() {
        indicatorSuperView = UIView()
        indicatorSuperView.backgroundColor = .white
        indicatorSuperView.layer.zPosition = -1
        collectionView.addSubview(indicatorSuperView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        indicatorSuperView.frame = CGRect(origin: .zero, size: itemSize)
        delegate?.tabView(self, configureIndicatorViewWith: indicatorSuperView)
    }
    
    var itemSize: CGSize {
        guard let delegate = delegate else {
            fatalError("delegate must not be nil")
        }
        
        switch widthType {
        case .fixed(let width):
            return CGSize(width: width, height: bounds.height)
        case .evenly:
            return CGSize(width: bounds.width / CGFloat(delegate.numberOfItems(in: self)), height: bounds.height)
        }
    }
}

extension TabView {
    func updateTabView(with coordinatedScrollView: UIScrollView) {
        let contentOffsetX = coordinatedScrollView.contentOffset.x
        let scrollViewWidth = coordinatedScrollView.bounds.width
        
        let mod = fmod(contentOffsetX, scrollViewWidth)
        let divider = contentOffsetX / scrollViewWidth
        
        let x = CGFloat(Int(divider)) * itemSize.width + (mod / scrollViewWidth) * itemSize.width
        
        indicatorSuperView.frame.origin.x = x
        
        if divider < 0 {
            return
        }
        
        let index: Int
        let decimal = fmod(divider, 1)
        if decimal > 0.5 {
            index = Int(ceil(divider))
        } else {
            index = Int(floor(divider))
        }
        
        updateTabView(with: index)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension TabView {
    func updateTabView(with index: Int) {
        scrollToCenter(with: index) {
            self.selectItem(at: index)
        }
    }
    
    func selectItem(at index: Int) {
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .top)
    }
    
    func scrollToCenter(with index: Int, completion: @escaping () -> Void) {
        var x = itemSize.width * CGFloat(index) - (collectionView.bounds.width-itemSize.width) / 2
        
        x = min(max(x, 0), collectionView.contentSize.width - collectionView.bounds.width)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.collectionView.contentOffset.x = x
        }, completion: { _ in
            completion()
        })
    }
}

extension TabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else {
            fatalError("delegate must not be nil")
        }

        selectedIndex = indexPath.item
        
        updateTabView(with: selectedIndex)
        
        let cell = collectionView.cellForItem(at: indexPath) as? TabItemCell
        if let itemView = cell?.itemView {
            delegate.tabView(self, didSelect: itemView, at: selectedIndex)
        }
    }
}

extension TabView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate else {
            fatalError("delegate must not be nil")
        }
        
        return delegate.numberOfItems(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate else {
            fatalError("delegate must not be nil")
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabItemCell.reuseIdentifier, for: indexPath) as! TabItemCell
        delegate.tabView(self, configureItemViewAt: indexPath.item, with: cell)
        
        if isFirstInit && indexPath.item == 0 {
            selectItem(at: indexPath.item)
            cell.isSelected = true
            isFirstInit = false
        }
        
        return cell
    }
}
