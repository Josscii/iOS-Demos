//
//  WebViewController.swift
//  UIWebViewProgressDemo
//
//  Created by Josscii on 2017/8/6.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

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
    
    var loadingCount = 0
//    var maxLoadingCount = 0
}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingCount += 1

        if loadingCount == 1 {
            progressView.startAnimation()
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingCount -= 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            
            
            if self.loadingCount == 0 {
                guard let state = webView.stringByEvaluatingJavaScript(from: "document.readyState") else {
                    return
                }
                
                if state == "complete" || state == "interactive" {
                    self.progressView.finishAnimation()
                }
            }
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        progressView.finishAnimation()
    }
}
