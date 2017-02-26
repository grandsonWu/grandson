//
//  MainViewController.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "MainViewController.h"  //controller
#import "MovieManager.h"        //model
#import "MainCell.h"                //view
#import "Culture.h"                  //model
#import "DetailViewController.h"//controller
#import "MBProgressHUD+Henry.h"  //view
#define kColorBarTint   [UIColor colorWithRed:50/255.0 green:160/255.0 blue:200/255.0 alpha:1.0]
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray<Culture *> *cultures;

@end

@implementation MainViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self apiGetMovie];
    
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:kColorBarTint];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cultures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MainCell cellWithTableView:tableView culture:self.cultures[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QA" bundle:nil];
    DetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.culture = self.cultures[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - API
- (void)apiGetMovie{
    [MBProgressHUD showLoading:@"Loading"];
    [MovieManager apiGetCulturesByMethod:@"doFindTypeJ"
                                category:@"8"
                                 success:^(NSURLSessionDataTask *task, NSArray *responseObject) {
                                     self.cultures = [MovieManager apiResultGetCulturesWithResponse:responseObject];
                                     [self.tableView reloadData];
                                     [MBProgressHUD hideHUD];
                                 }
                                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     [MBProgressHUD hideHUD];
                                 }];
}

@end
