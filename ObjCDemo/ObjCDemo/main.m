//
//  main.m
//  ObjCDemo
//
//  Created by josscii on 2018/1/19.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *str = [NSDictionary dictionary];
        if (ISString(str) && isPresent(str)) {
            NSLog(@"hhhh");
        }
        
    }
    return 0;
}
