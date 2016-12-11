//
//  ListModel.h
//  Test
//
//  Created by CC on 16/9/4.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListModel : NSObject

@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *cname;
@property (nonatomic, copy)NSString *summary;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *type;

- (void)createArray:(NSDictionary *)result
         dataSource:(NSMutableArray *)dataSource;

@end
