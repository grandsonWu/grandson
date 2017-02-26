//
//  DetailInfoHeaderView.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "DetailInfoHeaderView.h"

@interface DetailInfoHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation DetailInfoHeaderView

+ (instancetype)viewWithTitle:(NSString *)title frame:(CGRect)frame{
    DetailInfoHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"DetailInfoHeaderView"
                                                                     owner:nil
                                                                   options:nil]lastObject];
    headerView.title.text = title;
    headerView.frame = frame;
    return headerView;
}

@end
