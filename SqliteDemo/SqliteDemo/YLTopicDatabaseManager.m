//
//  YLTopicDatabaseManager.m
//  SqliteDemo
//
//  Created by Josscii on 2017/7/30.
//  Copyright © 2017年 Josscii. All rights reserved.
//

#import "YLTopicDatabaseManager.h"
#import "FMDB.h"
#import <objc/runtime.h>
#import "TestModel.h"

#define TICK NSDate *startTime = [NSDate date]
#define TOCK NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

static NSString * const DATABASE_NAME = @"/topic.db";

@interface YLTopicDatabaseManager ()

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
@property (nonatomic, copy) NSString *pathToDatabase;

@end

@implementation YLTopicDatabaseManager

#pragma mark - initializtion

+ (instancetype)sharedManager {
    static YLTopicDatabaseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YLTopicDatabaseManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pathToDatabase = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject stringByAppendingString:DATABASE_NAME];
        // this will do only once.
        [self createDatabase];
    }
    return self;
}

- (BOOL)createDatabase {
    __block BOOL created = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:_pathToDatabase]) {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:_pathToDatabase];
        
        if (_databaseQueue) {
            [_databaseQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
                // create all tables
                BOOL succeed1 = [db executeUpdate:@"CREATE TABLE testmodel (\
                                                    id INTEGER PRIMARY KEY NOT NULL,\
                                                    name text,\
                                                    age INTEGER\
                                                    )"];
                BOOL succeed2 = YES;//[db executeUpdate:@""];
                BOOL succeed3 = YES;//[db executeUpdate:@""];
                
                if (!succeed1 || !succeed2 || !succeed3) {
                    *rollback = YES;
                    return;
                }
                
                created = YES;
            }];
        }
    }
    
    return created;
}

- (FMDatabaseQueue *)databaseQueue {
    if (!_databaseQueue) {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:_pathToDatabase];
    }
    return _databaseQueue;
}

#pragma mark - querys

- (NSArray *)getAllTestModels {
    NSString *sql = @"SELECT * FROM testmodel";
    return [self selectModelsWithSQL:sql OfClass:[TestModel class]];
}

#pragma mark - orm

- (void)saveModels:(NSArray<id<YLTopicModel>> *)models {
    [self.databaseQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        TICK;
        for (id<YLTopicModel> model in models) {
            // https://stackoverflow.com/questions/9400087/fmdb-query-with-dictionary
            NSDictionary *dict = [model dictionaryRepresentation];
            NSString *tableName = [model tableName];
            NSMutableArray *keys = [NSMutableArray array];
            NSMutableArray *values = [NSMutableArray array];
            for (NSString *key in dict) {
                [keys addObject:key];
                [values addObject:[NSString stringWithFormat:@":%@", key]];
            }
            NSString *keyString = [keys componentsJoinedByString:@","];
            NSString *valueString = [values componentsJoinedByString:@","];
            // https://stackoverflow.com/a/40648752/4819236 use replace to insert or update
            NSString *insertSQL = [NSString stringWithFormat:@"REPLACE INTO %@ (%@) VALUES (%@)", tableName, keyString, valueString];
            [db executeUpdate:insertSQL withParameterDictionary:dict];
        }
        TOCK;
    }];
}

- (NSArray *)selectModelsWithSQL:(NSString *)query OfClass:(Class<YLTopicModel>)klass {
    
    __block NSArray *models = @[];
    
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *resultSet = [db executeQuery:query];
        models = [klass modelFromResultSet: resultSet];
    }];
    
    return models;
}

@end
