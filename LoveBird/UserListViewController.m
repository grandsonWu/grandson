//
//  UserListViewController.m
//  LoveBird
//
//  Created by 廖冠翰 on 2017/1/10.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "UserListViewController.h"
#import "QuickbloxManager.h"
#import "UserListCell.h"
#import "ChatViewController.h"
#import "MBProgressHUD+Henry.m"
#define kColorBarTint   [UIColor colorWithRed:50/255.0 green:160/255.0 blue:120/255.0  alpha:0.9]
@interface UserListViewController ()

@property(nonatomic,strong)NSMutableArray <QBUUser *> *users;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self apiGetUsers];
    
    [self.navigationController.navigationBar setBarTintColor:kColorBarTint ];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QBUUser *user = self.users[indexPath.row];
    UserListCell *cell = [UserListCell cellWithTableView:tableView user:user];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QBUUser *reciver = self.users[indexPath.row];
    [self goChatViewControllerWithReciver:reciver];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

#pragma mark - API
- (void)apiGetUsers{
    [MBProgressHUD showLoading:@"載入中"];
    [QuickbloxManager apiGetUsersWithPageFrom:1 to:100 success:^(QBResponse *response, QBGeneralResponsePage *pageInformation, NSArray *users) {
        
        self.users = users.mutableCopy;
        NSInteger currentUserID = [[QBSession currentSession] currentUser].ID;
        
        NSMutableArray<QBUUser *> *userArray = [NSMutableArray array];
        [self.users enumerateObjectsUsingBlock:^(QBUUser * _Nonnull user,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
            if (user.ID != currentUserID && user.ID != 21763482) {
                [userArray addObject:user];
            }
        }];
        self.users = userArray;
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];
    } error:^(QBResponse *response) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark - Class Medthod
- (void)goChatViewControllerWithReciver:(QBUUser *)reciver{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Schdule" bundle:nil];
    ChatViewController *chatVc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatVc.reciver = reciver;
    [self.navigationController pushViewController:chatVc animated:YES];
    
}

@end
