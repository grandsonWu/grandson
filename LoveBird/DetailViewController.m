//
//  DetailViewController.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//


#import "DetailViewController.h"       //controller
#import "DetailInfoCell.h"                // view
#import "DetailInfoHeaderView.h"     // view
#import "DetailContentCell.h"           //view
#import "WebViewController.h"         //controller
#import "EventViewController.h"        //controller
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *headerViewArray;
@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation DetailViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //1.一般我们在使用動態cell的時候在viewdidLoad裡加上這兩句code就可以了
    //self.tableView.rowHeight = UITableViewAutomaticDimension
    //self.tableView.estimatedRowHeight = 80;
}

#pragma mark - Getter
- (NSArray *)headerViewArray{
    if (!_headerViewArray) {
        
        NSMutableArray *headerViewArray = [NSMutableArray array];
        for (int i=0; i<2; i++) {
            DetailInfoHeaderView *headerView = [DetailInfoHeaderView viewWithTitle:self.titleArray[i]
                                                                             frame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];  //
            [headerViewArray addObject:headerView];
        }
        _headerViewArray = headerViewArray;
    }
    return _headerViewArray;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[self.culture.title,@"內容簡介"];
    }
    return _titleArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [DetailInfoCell cellWithTableView:tableView culture:self.culture];
    }else{
        return [DetailContentCell cellWithTableView:tableView culture:self.culture];
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headerViewArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


#pragma mark - Event Handler
- (IBAction)checkEventClick {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QA" bundle:nil];
    EventViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
    vc.culture = self.culture;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)checkActivityClick {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QA" bundle:nil];
    WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    vc.url = self.culture.sourceWebPromote;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)checkDetailClick {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QA" bundle:nil];
    WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    vc.url = self.culture.sourceWebPromote;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
