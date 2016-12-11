//
//  ListModel.m
//  Test
//
//  Created by CC on 16/9/4.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ListModel.h"
#import "UserModel.h"

@implementation ListModel

- (void)createArray:(NSDictionary *)result
         dataSource:(NSMutableArray *)dataSource
{
    UserModel *userModel = [[UserModel alloc]init];
    NSArray *array = result[@"news"];
    for (NSDictionary *dict in array) {
        ListModel *listModel = [[ListModel alloc]init];
        listModel.cname      = [NSString stringWithFormat:@"%@",dict[@"cname"]];
        listModel.summary    = [NSString stringWithFormat:@"%@",dict[@"summary"]];
        listModel.title      = [NSString stringWithFormat:@"%@",dict[@"title"]];
        listModel.type       = [NSString stringWithFormat:@"%@",dict[@"type"]];
        listModel.time       = [NSString stringWithFormat:@"%@",dict[@"lastUpdateTime"]];
        [dataSource addObject:listModel];
        //NSLog(@"cname:%@",listModel.type);
        
        //时间戳转换为时间
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[listModel.time integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yy-MM-dd"];
        NSString *beginStr = [formatter stringFromDate:startDate];
        listModel.time = beginStr;
        if (!([userModel selectTable].count > 5)) {
            [userModel insert:listModel];
        }
    }
}

@end
