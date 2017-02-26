//
//  JsonViewController.m
//  LoveBird
//
//  Created by User on 2017/1/6.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "JsonViewController.h"
#import "AFNetworking.h"
@interface JsonViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray*json;
    UITableView*tableView
}

@end

@implementation JsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    json = [NSMutableArray array];
    self->tableView.dataSource = self;
    self->tableView.delegate = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:@"http://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&keyword=2013" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        json = responseObject;  //響應本體訊息
        [self->tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error :%@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
