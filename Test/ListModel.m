//
//  ListModel.m
//  Test
//
//  Created by CC on 16/9/4.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)createArray:(NSDictionary *)result
         dataSource:(NSMutableArray *)dataSource
{
    NSArray *array = result[@"news"];
    for (NSDictionary *dict in array) {
        ListModel *listModel = [[ListModel alloc]init];
        listModel.cname      = dict[@"cname"];
        listModel.time     = dict[@"lastUpdateTime"];
        listModel.summary    = dict[@"summary"];
        listModel.title      = dict[@"title"];
        listModel.type       = dict[@"type"];
        [dataSource addObject:listModel];
        NSLog(@"%@",listModel.title);
        
        //时间戳转换为时间
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[listModel.time integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yy-MM-dd"];
        NSString *beginStr = [formatter stringFromDate:startDate];
        listModel.time = beginStr;
    }
}

@end
