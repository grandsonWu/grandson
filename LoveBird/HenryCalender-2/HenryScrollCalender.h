//
//  HenryScrollCalender.h
//  calendarTest
//
//  Created by 廖冠翰 on 2017/1/6.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HenryCalenderManager;

@interface HenryScrollCalender : UIView

@property(nonatomic,strong)HenryCalenderManager *manager;

+ (instancetype)calenderWithFrame:(CGRect)frame manager:(HenryCalenderManager *)manager;

- (void)removeAllSelected;

@end
