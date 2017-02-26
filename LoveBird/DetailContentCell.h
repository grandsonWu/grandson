//
//  DetailContentCell.h
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Culture.h"

@interface DetailContentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView culture:(Culture *)culture;

@end
