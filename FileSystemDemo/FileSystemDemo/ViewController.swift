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
            
            let directoryURL = url.appendingPathComponent("dd.txt")
            
            // 创建目录如果 withIntermediateDirectories 为 true，就不用检查目录是否存在，也不会被覆盖, 否则会报错
            // 后缀名不影响
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            // 这里有谈到 https://stackoverflow.com/a/6126098/4819236
        } catch {
            print("error")
        }
    }
    
    func directoryExist(at path: String) -> Bool {
        var isDirectory: ObjCBool = true
        let exist = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exist && isDirectory.boolValue
    }
}

