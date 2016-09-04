//
//  DetailViewController.m
//  Test
//
//  Created by CC on 16/9/4.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _titleStr;
    UITextView *textView = [[UITextView alloc]initWithFrame:self.view.frame];
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    textView.userInteractionEnabled = NO;
    textView.text = _contentStr;
    textView.font = [UIFont systemFontOfSize:18];
}

@end
