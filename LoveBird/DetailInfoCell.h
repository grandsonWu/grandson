//
//  DetailInfoCell.h
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Culture.h"

/**
 * 使用了一個填充物,上下左右約束間距0,將整個Cell撐開
 */
@interface DetailInfoCell : UITableViewCell

@property(nonatomic,strong)Culture *culture;

+ (instancetype)cellWithTableView:(UITableView *)tableView culture:(Culture *)culture;

@end
