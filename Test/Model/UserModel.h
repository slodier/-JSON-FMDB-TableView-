//
//  UserModel.h
//  FMDBPractice
//
//  Created by CC on 2016/12/7.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListModel.h"
#import "FMDB.h"

@interface UserModel : NSObject

#pragma mark - 删除数据库
- (BOOL)delteSqlite;

#pragma mark - 检测本地文件是否存在
- (BOOL)isSqliteExist;

#pragma mark - 查询数据库
- (NSMutableArray *)selectTable;

#pragma mark - 插入进表
- (void)insert:(ListModel *)model;

#pragma mark - 更新
- (void)update:(NSString *)value to:(NSString *)key;

@end
