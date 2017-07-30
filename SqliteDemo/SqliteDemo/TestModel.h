//
//  TestModel.h
//  SqliteDemo
//
//  Created by Josscii on 2017/7/30.
//  Copyright © 2017年 Josscii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLTopicModel.h"

@interface TestModel : NSObject <YLTopicModel>

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
