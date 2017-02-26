//
//  MainCell.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//


#import "MainCell.h"
#import "Culture.h"

@interface MainCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation MainCell

#pragma mark - Public Function
+ (instancetype)cellWithTableView:(UITableView *)tableView culture:(Culture *)culture{
    //instancetype的作用，就是使那些非关联返回类型的方法返回所在类的类型！
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];  //dequeueReusableCellWithIdentifier  絕對不可以為每列建立一個新的cell物件，而是重覆使用同一個物件
    cell.culture = culture;
    return cell;
}


#pragma mark - Setter
- (void)setCulture:(Culture *)culture{
    _culture = culture;
    
    self.titleLabel.text = culture.title;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ ~ %@",culture.startDate,culture.endDate];
}

@end
