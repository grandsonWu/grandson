//
//  TestViewController.m
//  LoveBird
//
//  Created by User on 2017/1/13.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "TestViewController.h"
#import "HenryScrollCalender.h"
#import "HenryCalenderManager.h"
#import "HenryCalenderTools.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface TestViewController ()

@property (nonatomic,strong) HenryScrollCalender *scrollCalender;
@property (nonatomic,strong) HenryCalenderManager *manager;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollCalender];
}

#pragma mark - Getter

- (HenryCalenderManager *)manager{
    if (!_manager) {
        _manager = [[HenryCalenderManager alloc]init];
        _manager.settings.startDate = [NSDate date];
        _manager.settings.scrollCount = 13;
        _manager.settings.startSelectedText = @"開始";
        _manager.settings.endSelectedText = @"結束";
        _manager.settings.dayHeight = 45;
    }
    return _manager;
}

- (HenryScrollCalender *)scrollCalender{
    if (!_scrollCalender) {
        
        CGFloat calenderX = 0;
        CGFloat calenderY = 64;
        CGFloat calenderW = SCREEN_WIDTH;
        CGFloat calenderH = 550;
        
        CGRect frame = CGRectMake(calenderX, calenderY, calenderW, calenderH);
        
        _scrollCalender = [HenryScrollCalender calenderWithFrame:frame manager:self.manager];
    }
    return _scrollCalender;
}

@end
