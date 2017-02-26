//
//  HenryCalenderManager.m
//  calendarTest
//
//  Created by 廖冠翰 on 2017/1/8.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import "HenryCalenderManager.h"

@implementation HenryCalenderManager

- (instancetype)init{
    if (self = [super init]) {
        HenryCalenderSettings *setting = [[HenryCalenderSettings alloc]init];
        self.settings = setting;
    }
    return self;
}

@end
