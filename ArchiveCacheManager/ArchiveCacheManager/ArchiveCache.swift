//
//  Cache.swift
//  ArchiveCacheManager
//
//  Created by mxl on 2017/7/25.
//  Copyright © 2017年 josscii. All rights reserved.
//

import Foundation

class CacheObject: NSObject, NSCoding {
    var value: Any
    var expireDate: Date
    
    init(value: Any, expireDate: Date) {
        self.value = value
        self.expireDate = expireDate
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.value = aDecoder.decodeObject(forKey: "value")!
        self.expireDate = aDecoder.decodeObject(forKey: "expiredDate") as! Date
    }
    
    func encode(with aCoder: NSCoder) {
        
        // https://stackoverflow.com/a/25805619/4819236
        guard value is NSObject && value is NSCoding else {
            fatalError("value must a subclass of `NSObject` and comforms to `NSCoding` protocol")
        }
        
        aCoder.encode(value, forKey: "value")
        aCoder.encode(expireDate, forKey: "expiredDate")
    }
}

class ArchiveCache {
    static let shared = ArchiveCache()
    private var memoryCache:NSCache<NSString, CacheObject> = NSCache()
    private var cacheBaseURL: URL
    private var cacheDirectoryName = "com.simple.archivecache"
    
    private init() {
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        cacheBaseURL = documentDirURL.appendingPathComponent(cacheDirectoryName)
        try! FileManager.default.createDirectory(at: cacheBaseURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    func save(key: String, value: Any, seconds: Int) {
        let now = Date()
        let expireDate = now.addingTimeInterval(TimeInterval(seconds))
        
        // save it to memory cache
        let cacheObject = CacheObject(value: value, expireDate: expireDate)
        memoryCache.setObject(cacheObject, forKey: key as NSString)
        
        // save it to disk
        let cacheURL = cacheBaseURL.appendingPathComponent("\(key).plist")
        NSKeyedArchiver.archiveRootObject(cacheObject, toFile: cacheURL.path)
    }
    
    func get(key: String) -> Any? {
        let now = Date()
        
        // get memory cache
        if let memoryObject = memoryCache.object(forKey: key as NSString) {
            if now > memoryObject.expireDate {
                delete(key: key)
                return nil
            } else {
                return memoryObject.value
            }
        }
        
        // get disk cache
        let cacheURL = cacheBaseURL.appendingPathComponent("\(key).plist")
        if let diskObject = NSKeyedUnarchiver.unarchiveObject(withFile: cacheURL.path) as? CacheObject {
            if now > diskObject.expireDate {
                delete(key: key)
                return nil
            } else {
                return diskObject.value
            }
        }
        
        // nothing found
        return nil
    }
    
    func delete(key: String) {
        // delete memory cache
        memoryCache.removeObject(forKey: key as NSString)
        
        // delete disk cache
        let cacheURL = cacheBaseURL.appendingPathComponent("\(key).plist")
        do {
            try FileManager.default.removeItem(at: cacheURL)
        } catch _ {
            print("delete disk cache failed for key: \(key)")
        }
    }
}

