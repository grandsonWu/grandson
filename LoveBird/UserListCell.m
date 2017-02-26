//
//  UserListCell.m
//  LoveBird
//
//  Created by 廖冠翰 on 2017/1/10.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "UserListCell.h"

@interface UserListCell()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation UserListCell


+ (instancetype)cellWithTableView:(UITableView *)tableView user:(QBUUser *)user{
    UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserListCell"];
    cell.userNameLabel.text = user.fullName;
    return cell;
}

@end
