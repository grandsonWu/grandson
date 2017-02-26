//
//  HenryMenuView.m
//  calendarTest
//
//  Created by 廖冠翰 on 2017/1/4.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import "HenryMenuView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HenryMenuView()

@property (strong,nonatomic)UILabel *titleLabel;

@end

@implementation HenryMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit{
    UILabel *title = [[UILabel alloc]init];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:15.0];
    title.bounds = CGRectMake(0,0,120,30);
    title.center = CGPointMake(SCREEN_WIDTH * 0.5, 40 * 0.5);
    self.titleLabel = title;
    [self addSubview:title];
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}
@end
