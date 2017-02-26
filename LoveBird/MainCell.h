//
//  MainCell.h
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Culture;

@interface MainCell : UITableViewCell

@property(nonatomic,strong)Culture *culture;



+ (instancetype)cellWithTableView:(UITableView *)tableView culture:(Culture *)culture;

@end
