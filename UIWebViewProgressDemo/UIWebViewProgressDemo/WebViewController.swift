//
//  WebViewController.swift
//  UIWebViewProgressDemo
//
//  Created by Josscii on 2017/8/6.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: UIWebView!
    var progressView: ProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        view.addSubview(webView)
        
        progressView = ProgressView(frame: CGRect(x: 0, y: 65, width: view.bounds.width, height: 2))
        view.addSubview(progressView)
        
        let url = URL(string: "https://www.baidu.com")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    var totalLoadingCount = 0
    var finishedLoadingCount = 0
}

extension WebViewController: UIWebViewDelegate {
    
    /* 由于 webview 每加载一个 iframe 就会调用这个回调，所以这个方法会被调用多次，尽管是一一对应的调用，但是调用顺序无法确定，所以无法确定最后一次调用
     */
    func webViewDidStartLoad(_ webView: UIWebView) {
        totalLoadingCount += 1

        if totalLoadingCount == 1 {
            progressView.startAnimation()
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        finishedLoadingCount += 1
        
        // 这个方法不可靠，总的来说，如果不用私有的 api，是无法得到准确的进度的，就连 NJK 也有 bug
        if totalLoadingCount == finishedLoadingCount {
            guard let state = webView.stringByEvaluatingJavaScript(from: "document.readyState") else {
                return
            }
            
            if state == "complete" || state == "interactive" {
                self.progressView.finishAnimation()
                
                totalLoadingCount = 0
                finishedLoadingCount = 0
            }
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        finishedLoadingCount += 1
        
        // 这个方法不可靠
        if totalLoadingCount == finishedLoadingCount {
            guard let state = webView.stringByEvaluatingJavaScript(from: "document.readyState") else {
                return
            }
            
            if state == "complete" || state == "interactive" {
                self.progressView.finishAnimation()
                
                totalLoadingCount = 0
                finishedLoadingCount = 0
            }
        }
    }
}
