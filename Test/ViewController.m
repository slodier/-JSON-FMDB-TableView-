//
//  ViewController.m
//  Test
//
//  Created by CC on 16/9/4.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ViewController.h"
#import "ListModel.h"
#import "DetailViewController.h"

#define URLSTR @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"新闻";
    
    _dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    [self.view addSubview:self.tableView];

    //创建一个异步队列解析 json，防止阻塞主线程
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        [self urlStr];
    });
}

#pragma mark -- 解析 JSON
- (void)urlStr
{
    NSURL *url = [NSURL URLWithString:URLSTR];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *error1;
        //解析 json，返回字典，这里解析出来是 unicode 编码，不影响正常显示
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error1];
        
        ListModel *listModel = [[ListModel alloc]init];
        [listModel createArray:dict dataSource:_dataSource];
        
        //数据源开始是空的，因为网络等原因...等数据源有值了，在主线程刷新 TabelView
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
    [task resume];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    ListModel *listModel = _dataSource[indexPath.row];
    cell.textLabel.text = listModel.title;
    cell.detailTextLabel.text = listModel.time;
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListModel *listModel = _dataSource[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.titleStr = listModel.cname;
    detailVC.contentStr = listModel.summary;
}

#pragma mark -- getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
