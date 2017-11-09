//
//  CollectionPageViewController.swift
//  SlidePageViewControllerDemo
//
//  Created by josscii on 2017/11/9.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

protocol Reusable {
    var reuseIdentifier: String { get }
}

class CollectionPageSegmentView: UIView {
    var indicator: UIView!
    var collectionView: UICollectionView!
    var titles: [String]
    
    var selectAction: (Int) -> Void = {_ in }
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: frame.width / CGFloat(self.titles.count), height: frame.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionPageSegmentCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        
        indicator = UIView()
        indicator.frame = CGRect(x: 0, y: 0, width: 30, height: 5)
        indicator.backgroundColor = .red
        
        addSubview(indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateIndicatorCenterX(centerX: CGFloat) {
        indicator.center.x = centerX
    }
    
    func updateItems(fromIndex: Int, toIndex: Int, progress: CGFloat) {
        let fromCell = collectionView.cellForItem(at: IndexPath(item: fromIndex, section: 0))
        let toCell = collectionView.cellForItem(at: IndexPath(item: toIndex, section: 0))
        
        if progress <= 0.5 {
            fromCell?.backgroundColor = .green
            toCell?.backgroundColor = .white
        } else {
            toCell?.backgroundColor = .green
            fromCell?.backgroundColor = .white
        }
    }
}

extension CollectionPageSegmentView {
    class CollectionPageSegmentCell: UICollectionViewCell {
        var titleLabel: UILabel!
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            titleLabel = UILabel()
            titleLabel.textColor = .black
            contentView.addSubview(titleLabel)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            titleLabel.sizeToFit()
            titleLabel.center = contentView.center
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension CollectionPageSegmentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionPageSegmentCell
        cell.titleLabel.text = titles[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAction(indexPath.item)
    }
}

class CollectionPageViewController: UIViewController {

    var viewControllers: [UIViewController]? {
        didSet {
            guard let viewControllers = viewControllers,
                viewControllers.count > 0 else {
                    return
            }
            
            flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = view.bounds.size
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.scrollDirection = .horizontal
            
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.backgroundColor = .white
            collectionView.isPagingEnabled = true
            collectionView.bounces = false
            collectionView.delegate = self
            collectionView.dataSource = self
            // collectionView.isPrefetchingEnabled = false
            for vc in viewControllers {
                let reusable = vc as! Reusable
                collectionView.register(UICollectionViewCell.self,
                                        forCellWithReuseIdentifier: reusable.reuseIdentifier)
            }
            view.addSubview(collectionView!)
            
            let titles = viewControllers.map { $0.title ?? "哈哈" }
            segmentView = CollectionPageSegmentView(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: 40), titles: titles)
            view.addSubview(segmentView!)
            
            segmentView?.selectAction = { index in
                self.collectionView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    var segmentView: CollectionPageSegmentView?
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
}

extension CollectionPageViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // update indicator position
        let totalScrollWidth = scrollView.contentSize.width - scrollView.bounds.width
        let indicatorProgress = max(min(scrollView.contentOffset.x / totalScrollWidth, 1), 0)
        let divideWidth = scrollView.bounds.width / CGFloat(viewControllers!.count)
        let indicatorCenterX = (scrollView.bounds.width - divideWidth) * indicatorProgress + divideWidth/2
        segmentView?.updateIndicatorCenterX(centerX: indicatorCenterX)
        
        // update item
        // https://stackoverflow.com/a/36835645/4819236
        let progress = scrollView.contentOffset.x / scrollView.bounds.width
        let modValue = modf(progress)
        let fromIndex = Int(modValue.0)
        let toIndex = Int(fromIndex + 1)
        let betweenProgress = modValue.1
        segmentView?.updateItems(fromIndex: fromIndex, toIndex: toIndex, progress: betweenProgress)
    }
}

extension CollectionPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vc = viewControllers![indexPath.item]
        let reusable = vc as! Reusable
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusable.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .white
//        add(asChildViewController: vc, to: cell.contentView)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        add(asChildViewController: viewControllers![indexPath.item], to: cell.contentView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        remove(asChildViewController: viewControllers![indexPath.item])
    }
}

extension CollectionPageViewController {
    private func add(asChildViewController viewController: UIViewController, to view: UIView) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        var segmentHeight: CGFloat = 0
        if let segmentView = segmentView {
            segmentHeight = segmentView.frame.height
        }
        
        viewController.view.frame = CGRect(x: 0, y: segmentHeight, width: view.bounds.width, height: view.bounds.height-segmentHeight)
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
}
