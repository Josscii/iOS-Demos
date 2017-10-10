//
//  ViewController.swift
//  FileSystemDemo
//
//  Created by josscii on 2017/10/9.
//  Copyright © 2017年 josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
//        print(path)
        createDirectory()
//        createFile()
    }
    
    func createFile() {
        do {
            
            // 创建文件前一定要先检查该文件是否存在，不然会被覆盖
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let directoryURL = url.appendingPathComponent("dd.txt")
            
            FileManager.default.createFile(atPath: directoryURL.path, contents: nil, attributes: nil)
        } catch {
            print("error")
        }

    }
    
    func createDirectory() {
        
        do {
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let directoryURL = url.appendingPathComponent("dd")
            
            // 创建目录如果 withIntermediateDirectories 为 true，就不用检查目录是否存在，也不会被覆盖
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

