//
//  YLTopicDatabaseManager.h
//  SqliteDemo
//
//  Created by Josscii on 2017/7/30.
//  Copyright © 2017年 Josscii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLTopicModel.h"

@interface YLTopicDatabaseManager : NSObject

+ (instancetype)sharedManager;

- (void)saveModels:(NSArray<id<YLTopicModel>> *)models;

- (NSArray *)getAllTestModels;

@end
