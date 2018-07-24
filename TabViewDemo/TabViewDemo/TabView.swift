//
//  TabView.swift
//  TabView
//
//  Created by josscii on 2018/7/17.
//  Copyright © 2018年 josscii. All rights reserved.
//

import UIKit

public protocol TabViewDelegate: class {
    // required
    func numberOfItems(in tabView: TabView) -> Int
    func tabView(_ tabView: TabView, cellForItemAt index: Int) -> UICollectionViewCell
    
    // optional
    func tabView(_ tabView: TabView, didSelectItemAt index: Int)
    func tabView(_ tabView: TabView, indicatorViewWith superView: UIView) -> UIView?
    func tabView(_ tabView: TabView, update indicatorView: UIView?, with progress: CGFloat)
}

extension TabViewDelegate {
    func tabView(_ tabView: TabView, didSelectItemAt index: Int) {}
    func tabView(_ tabView: TabView, indicatorViewWith superView: UIView) -> UIView? { return nil }
    func tabView(_ tabView: TabView, update indicatorView: UIView?, with progress: CGFloat) {}
}

public protocol TabItem {
    func setup(with widthType: TabViewWidthType)
    func update(with progress: CGFloat)
}

extension TabItem {
    func setup(with widthType: TabViewWidthType) {}
}

public enum TabViewWidthType {
    case fixed(width: CGFloat)
    case evenly
    case selfSizing
}

public class TabView: UIView {
    
    public weak var delegate: TabViewDelegate?
    public var animationDuration: Double = 0.25
    public var widthType: TabViewWidthType = .evenly
    
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    private var indicatorSuperView: UIView!
    private var indicatorView: UIView?
    private let coordinatedScrollView: UIScrollView
    
    private var selectedIndex = 0
    private var isFirstInit = true
    
    public init(frame: CGRect, coordinatedScrollView: UIScrollView) {
        self.coordinatedScrollView = coordinatedScrollView
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    convenience public init(coordinatedScrollView: UIScrollView) {
        self.init(frame: .zero, coordinatedScrollView: coordinatedScrollView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        coordinatedScrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPrefetchingEnabled = false
        collectionView.bounces = false
        addSubview(collectionView)
        
        indicatorSuperView = UIView()
        indicatorSuperView.layer.zPosition = -1
        collectionView.addSubview(indicatorSuperView)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        guard let delegate = delegate else {
            return
        }
        
        switch widthType {
        case .evenly:
            collectionViewLayout.itemSize = CGSize(width: bounds.width/CGFloat(delegate.numberOfItems(in: self)), height: bounds.height)
        case .fixed(let width):
            collectionViewLayout.itemSize = CGSize(width: width, height: bounds.height)
        case .selfSizing:
            collectionViewLayout.estimatedItemSize = CGSize(width: 50, height: bounds.height)
        }
    }
    
    deinit {
        coordinatedScrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
}

extension TabView {
    override public func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == "contentOffset" {
            updateTabView()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension TabView {
    public func reloadData() {
        collectionView.reloadData()
        updateTabView()
    }
    
    public func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func dequeueReusableCell(withReuseIdentifier identifier: String, for index: Int) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(item: index, section: 0))
    }
}

extension TabView {
    private func cell(at index: Int) -> UICollectionViewCell? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
    
    private func frameForCell(at index: Int) -> CGRect? {
        return collectionView.layoutAttributesForItem(at: IndexPath(item: index, section: 0))?.frame
    }
    
    private func updateTabView() {
        let contentOffsetX = coordinatedScrollView.contentOffset.x
        let scrollViewWidth = coordinatedScrollView.bounds.width
        let contentWidth = coordinatedScrollView.contentSize.width
        
        let quotient = contentOffsetX / scrollViewWidth
        let decimal = fmod(quotient, 1)
        
        let max = (contentWidth / scrollViewWidth) - 1
        if quotient < 0 || quotient > max {
            return
        }
        
        let index0 = Int(floor(quotient))
        let index1 = Int(ceil(quotient))
        
        // update the indicatorSuperView's frame
        if let frame0 = frameForCell(at: index0), let frame1 = frameForCell(at: index1) {
            let ix = frame0.origin.x + (frame1.origin.x - frame0.origin.x) * decimal
            let iy = frame0.origin.y
            let iwidth = frame0.size.width + (frame1.size.width - frame0.size.width) * decimal
            let iheight = frame0.size.height
            indicatorSuperView.frame = CGRect(x: ix, y: iy, width: iwidth, height: iheight)
        }
        
        if decimal == 0 {
            return
        }
        
        let index: Int
        if decimal > 0.5 {
            index = index1
        } else {
            index = index0
        }
        
        // update collectionView contentOffset and select state
        updateCell(with: index)
        
        // update the indicator, progress 0 -> 1 -> 0
        let progress = (0.5 - abs(0.5 - decimal)) * 2
        updateIndicatorView(with: progress)
        
        // update the tabItems, decimal 0 -> 1
        updateTabItem(from: index0, to: index1, with: decimal)
    }
    
    private func updateIndicatorView(with progress: CGFloat) {
        delegate?.tabView(self, update: indicatorView, with: progress)
    }
    
    private func updateTabItem(from index0: Int, to index1: Int, with progress: CGFloat) {
        updateTabItem(with: index0, and: progress)
        updateTabItem(with: index1, and: 1-progress)
    }
    
    private func updateTabItem(with index: Int, and progress: CGFloat) {
        let tabItem = cell(at: index) as? TabItem
        tabItem?.update(with: progress)
    }
    
    private func updateCell(with index: Int) {
        selectedIndex = index
        selectItem(at: index)
        scrollToCenter(with: index)
    }
    
    private func selectItem(at index: Int) {
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .top)
    }
    
    private func scrollToCenter(with index: Int) {
        collectionView.setValue(animationDuration, forKey: "contentOffsetAnimationDuration")
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension TabView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // animate update the previous cell
        UIView.animate(withDuration: animationDuration) {
            let cell = self.cell(at: self.selectedIndex) as? TabItem
            cell?.update(with: 1)
        }
        
        updateCell(with: indexPath.item)
        
        // animate update the selected cell
        UIView.animate(withDuration: animationDuration) {
            let cell = self.cell(at: self.selectedIndex) as? TabItem
            cell?.update(with: 0)
        }
        
        // animate coordinatedScrollView contentOffset
        UIView.animate(withDuration: animationDuration) {
            self.coordinatedScrollView.contentOffset.x = CGFloat(self.selectedIndex) * self.coordinatedScrollView.bounds.width
        }
        
        // call the delegate
        delegate?.tabView(self, didSelectItemAt: indexPath.item)
    }
}

extension TabView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFirstInit && indexPath.item == 0 {
            defer {
                isFirstInit = false
            }
            
            // select first cell
            selectItem(at: 0)
            cell.isSelected = true
            
            // init indicatorViews
            indicatorSuperView.frame = cell.frame
            indicatorView = delegate?.tabView(self, indicatorViewWith: indicatorSuperView)
        }
        
        // update tabItem
        let progress: CGFloat = cell.isSelected ? 0 : 1
        let tabItem = cell as? TabItem
        tabItem?.update(with: progress)
    }
    
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
        
        let cell = delegate.tabView(self, cellForItemAt: indexPath.item)
        
        if let item = cell as? TabItem {
            item.setup(with: widthType)
        }
        
        return cell
    }
}
