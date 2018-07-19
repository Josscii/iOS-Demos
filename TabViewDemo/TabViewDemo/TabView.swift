//
//  TabView.swift
//  ListLayout
//
//  Created by josscii on 2018/7/17.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

public protocol TabViewDelegate: class {
    func tabView(_ tabView: TabView, indicatorViewWith superView: UIView) -> UIView
    func tabView(_ tabView: TabView, configureItemViewAt index: Int, with cell: TabItemCell)
    func tabView(_ tabView: TabView, didSelect itemView: TabItemView, at index: Int)
    func tabView(_ tabView: TabView, update indicatorView: UIView, with progress: CGFloat)
    
    func numberOfItems(in tabView: TabView) -> Int
}

public enum TabViewWidthType {
    case fixed(width: CGFloat)
    case evenly
}

public class TabItemCell: UICollectionViewCell {
    public var itemView: TabItemView?
    
    static let reuseIdentifier = "TabItemCell"
    
    override public var isSelected: Bool {
        get {
            return super.isSelected
        }
        
        set {
            super.isSelected = newValue
            itemView?.isSelected = newValue
        }
    }
}

public protocol TabItemView {
    var isSelected: Bool { get set }
}

public class TabView: UIView {
    
    public weak var delegate: TabViewDelegate?
    public var animationDuration: Double = 0.25
    public var widthType: TabViewWidthType = .evenly
    
    private var collectionView: UICollectionView!
    private var indicatorSuperView: UIView!
    private var indicatorView: UIView?
    private let coordinatedScrollView: UIScrollView
    
    private var selectedIndex = 0
    private var isFirstInit = true
    
    public init(frame: CGRect, coordinatedScrollView: UIScrollView) {
        self.coordinatedScrollView = coordinatedScrollView
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    convenience public init(coordinatedScrollView: UIScrollView) {
        self.init(frame: .zero, coordinatedScrollView: coordinatedScrollView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        coordinatedScrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPrefetchingEnabled = false
        addSubview(collectionView)
        
        indicatorSuperView = UIView()
        indicatorSuperView.layer.zPosition = -1
        collectionView.addSubview(indicatorSuperView)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        indicatorSuperView.frame = CGRect(origin: .zero, size: itemSize)
        indicatorView = delegate?.tabView(self, indicatorViewWith: indicatorSuperView)
    }
    
    private var itemSize: CGSize {
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
    override public func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == "contentOffset" {
            updateTabView()
        }
    }
}

extension TabView {
    public func reloadData() {
        collectionView.reloadData()
        updateTabView()
    }
}

extension TabView {
    private func updateTabView() {
        let contentOffsetX = coordinatedScrollView.contentOffset.x
        let scrollViewWidth = coordinatedScrollView.bounds.width
        let contentWidth = coordinatedScrollView.contentSize.width
        
        let mod = fmod(contentOffsetX, scrollViewWidth)
        let quotient = contentOffsetX / scrollViewWidth
        
        let x = CGFloat(Int(quotient)) * itemSize.width + (mod / scrollViewWidth) * itemSize.width
        indicatorSuperView.frame.origin.x = x
        
        let max = (contentWidth / scrollViewWidth) - 1
        if quotient < 0 || quotient > max {
            return
        }
        
        let index: Int
        let decimal = fmod(quotient, 1)
        if decimal > 0.5 {
            index = Int(ceil(quotient))
        } else {
            index = Int(floor(quotient))
        }
        updateTabView(with: index)
        
        let progress = (0.5 - abs(0.5 - decimal)) * 2
        updateIndicator(with: progress)
    }
    
    private func updateIndicator(with progress: CGFloat) {
        guard let indicatorView = indicatorView else {
            return
        }
        
        delegate?.tabView(self, update: indicatorView, with: progress)
    }
    
    private func updateTabView(with index: Int) {
        scrollToCenter(with: index) {
            self.selectItem(at: index)
        }
    }
    
    private func selectItem(at index: Int) {
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .top)
    }
    
    private func scrollToCenter(with index: Int, completion: @escaping () -> Void) {
        let maxOffsetX = collectionView.contentSize.width - collectionView.bounds.width
        
        if maxOffsetX < 0 {
            completion()
            return
        }
        
        var x = itemSize.width * CGFloat(index) - (collectionView.bounds.width-itemSize.width) / 2
        
        x = min(max(x, 0), maxOffsetX)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.collectionView.contentOffset.x = x
        }, completion: { _ in
            completion()
        })
    }
}

extension TabView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        
        updateTabView(with: selectedIndex)
        
        let cell = collectionView.cellForItem(at: indexPath) as? TabItemCell
        if let itemView = cell?.itemView {
            UIView.animate(withDuration: animationDuration) {
                self.coordinatedScrollView.contentOffset.x = CGFloat(self.selectedIndex) * self.coordinatedScrollView.bounds.width
            }
            delegate?.tabView(self, didSelect: itemView, at: selectedIndex)
        }
    }
}

extension TabView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate else {
            fatalError("delegate must not be nil")
        }
        
        return delegate.numberOfItems(in: self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate else {
            fatalError("delegate must not be nil")
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabItemCell.reuseIdentifier, for: indexPath) as! TabItemCell
        delegate.tabView(self, configureItemViewAt: indexPath.item, with: cell)
        
        if isFirstInit && indexPath.item == selectedIndex {
            selectItem(at: indexPath.item)
            cell.isSelected = true
            isFirstInit = false
        }
        
        return cell
    }
}
