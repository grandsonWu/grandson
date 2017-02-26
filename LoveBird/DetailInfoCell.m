//
//  DetailInfoCell.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//


#import "DetailInfoCell.h"
#import "ShowInfo.h"

@interface DetailInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;      //時間
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;    //地點
@property (weak, nonatomic) IBOutlet UILabel *costLabel;      //費用
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;     //場次
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;  //活動網址
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;    //資料來源
@property (weak, nonatomic) IBOutlet UILabel *organizerLabel; //主辦單位


@end

@implementation DetailInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView culture:(Culture *)culture{
    
    DetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailInfoCell"];
    cell.culture = culture;
    return cell;
}

- (void)setCulture:(Culture *)culture{
    _culture = culture;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ ~ %@",culture.startDate,culture.endDate];
    
    ShowInfo *info = [culture.showInfo firstObject];
    self.targetLabel.text = info.location;
    self.costLabel.text = (info.price.length > 0)?info.price:@"免費";
    self.organizerLabel.text = [culture.masterUnit firstObject];
    
}

@end
