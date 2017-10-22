//
//  ViewController.swift
//  LayoutGuideDemo
//
//  Created by Josscii on 2017/9/27.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
//        navigationController?.navigationBar.isTranslucent = false
//        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = []
//        navigationController?.navigationBar.isTranslucent = false
        
        /*
         当 bar 为透明时，extendedLayoutIncludesOpaqueBars 不起作用，通过 edgesForExtendedLayout 可以调节 ViewController 的 rootView 的 frame 的原点，也就是说，如果
         当 bar 不透明时，extendedLayoutIncludesOpaqueBars 和 edgesForExtendedLayout 共同起作用，只有当 extendedLayoutIncludesOpaqueBars 的值为 true，且 edgesForExtendedLayout 的值不为 0 才行。
         而 automaticallyAdjustsScrollViewInsets 是仅针对 viewController 的第一个子视图为 UIScrollView 及其子类的时候才会起作用，在 iOS 11 之前，它调节的是 tableView 的 contentInsets。
         */
        
        let subView = UIView(frame: CGRect(x: 20, y: 100, width: 50, height: 50))
        subView.backgroundColor = .red
        view.addSubview(subView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        automaticallyAdjustsScrollViewInsets
//        topLayoutGuide
        
//        edgesForExtendedLayout = []
        
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        tabBarController?.tabBar
        
        view.intrinsicContentSize
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(edgesForExtendedLayout)
        
        print(view.bounds)
        print(view.frame)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }
}

