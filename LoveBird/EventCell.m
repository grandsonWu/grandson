//
//  EventCell.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "EventCell.h"

@interface EventCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;


@end

@implementation EventCell

+ (instancetype)cellWithTableView:(UITableView *)tableView showInfo:(ShowInfo *)showInfo{
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ ~ %@",showInfo.time,showInfo.endTime];
    cell.targetLabel.text = showInfo.locationName;
    cell.costLabel.text = (showInfo.price.length > 0)?showInfo.price:@"免費";
    return cell;
}
@end
