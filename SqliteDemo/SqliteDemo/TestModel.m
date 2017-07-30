//
//  TestModel.m
//  SqliteDemo
//
//  Created by Josscii on 2017/7/30.
//  Copyright © 2017年 Josscii. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (instancetype)initWithID:(NSInteger)ID name:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        _ID = ID;
        _name = name;
        _age = age;
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"name"] = self.name;
    dict[@"age"] = [NSNumber numberWithInteger:self.age];
    dict[@"id"] = [NSNumber numberWithInteger:self.ID];
    
    return [dict copy];
}

- (NSString *)tableName {
    return @"testmodel";
}

+ (NSArray *)modelFromResultSet:(FMResultSet *)resultSet {
    NSMutableArray *models = [NSMutableArray array];
    while ([resultSet next]) {
        NSInteger ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSInteger age = [resultSet intForColumn:@"age"];
        TestModel *model = [[TestModel alloc] initWithID:ID name:name age:age];
        [models addObject:model];
    }
    return [models copy];
}

@end
