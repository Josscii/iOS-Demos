//
//  YLTopicModel.h
//  SqliteDemo
//
//  Created by Josscii on 2017/7/30.
//  Copyright © 2017年 Josscii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@protocol YLTopicModel <NSObject>

- (NSString *)tableName;
- (NSDictionary *)dictionaryRepresentation;
+ (NSArray *)modelFromResultSet:(FMResultSet *)resultSet;

@end
