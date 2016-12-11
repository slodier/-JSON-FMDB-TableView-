//
//  UserModel.m
//  FMDBPractice
//
//  Created by CC on 2016/12/7.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "UserModel.h"

@interface UserModel ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation UserModel

- (BOOL)delteSqlite {
    if ([self isSqliteExist]) {
        NSString *path = [NSTemporaryDirectory()stringByAppendingString:@"user.db"];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *error;
        [manager removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"delete sqlite failed");
        }else{
            NSLog(@"delete sqlite success");
        }
        return YES;
    }else{
        NSLog(@"sqlite isn't exist");
        return NO;
    }
    return NO;
}

#pragma mark - 检测本地文件是否存在
- (BOOL)isSqliteExist {
    NSString *path = [NSTemporaryDirectory()stringByAppendingString:@"user.db"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSLog(@"sqlite is exist");
        return YES;
    }else{
        NSLog(@"sqlite isn't exist, prepare to create");
        return NO;
    }
}

#pragma mark -- 建数据库
- (void)openDB {
    NSString *path = [NSTemporaryDirectory()stringByAppendingString:@"user.db"];
    NSLog(@"path:%@",path);
    _db = [FMDatabase databaseWithPath:path];
    if ([_db open]) {
        //建表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS NewsInfo(id integer PRIMARY KEY AUTOINCREMENT,cname text NOT NULL,summary text NOT NULL,title text NOT NULL,type text NOT NULL,time text NOT NULL)"];
        if (result) {
            NSLog(@"create table success");
        }else{
            NSLog(@"create tabble success");
            [_db close];
        }
    }else{
        [_db close];
        NSLog(@"open db failed");
    }
}

#pragma mark -- 查询数据库
- (NSMutableArray *)selectTable
{
    if (![_db open]) {
        [self openDB];
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *resultSet = [_db executeQuery:@"select *from NewsInfo;"];
        while ([resultSet next]) {
            ListModel *listModel = [[ListModel alloc]init];
            listModel.cname   = [resultSet objectForColumnName:@"cname"];
            listModel.summary = [resultSet objectForColumnName:@"summary"];
            listModel.title   = [resultSet objectForColumnName:@"title"];
            listModel.type    = [resultSet objectForColumnName:@"type"];
            listModel.time    = [resultSet objectForColumnName:@"time"];
            [tempArray addObject:listModel];
        }
        [_db close];
    }
    return tempArray;
}

#pragma mark -- 插入进表
- (void)insert:(ListModel *)model
{
    if (![_db open]) {
        [self openDB];
    }
    [_db executeUpdate:@"INSERT INTO NewsInfo(cname,summary,title,type,time)VALUES(?,?,?,?,?)",model.cname,model.summary,model.title,model.type,model.time];
}

#pragma mark -- 修改某个值
- (void)update:(NSString *)value to:(NSString *)key {
    if (![_db open]) {
        [self openDB];
    }
    if ([_db open]) {
        NSString *updateSql = [NSString stringWithFormat:@"update NewsInfo set %@='%@'",key,value];
        BOOL res = [_db executeUpdate:updateSql];
        
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [_db close];
    }
}

@end
