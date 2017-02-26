//
//  UserListCell.h
//  LoveBird
//
//  Created by 廖冠翰 on 2017/1/10.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Quickblox/Quickblox.h>

@interface UserListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView user:(QBUUser *)user;

@end
