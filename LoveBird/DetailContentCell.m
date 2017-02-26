//
//  DetailContentCell.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "DetailContentCell.h"

@interface DetailContentCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end


@implementation DetailContentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView culture:(Culture *)culture{
    DetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailContentCell"];
    cell.contentLabel.text = culture.descriptionFilterHtml;
    return cell;
}

@end
