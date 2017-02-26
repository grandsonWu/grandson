//
//  HenryCalender.h
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HenryDay.h"
@class HenryCalenderManager;

@protocol HenryCalenderDelegate <NSObject>
@optional
- (void)henryCalenderDayTouchWithDate:(NSDate *)date henryDay:(HenryDay *)henryDay;

@end

@interface HenryCalender : UIView

@property (weak,nonatomic)id<HenryCalenderDelegate> dalagate;

//月份底色
@property (strong,nonatomic)UIColor *menuViewBgColor;
//月份字顏色
@property (strong,nonatomic)UIColor *menuViewTitleColor;
//週底色
@property (strong,nonatomic)UIColor *weekViewBgColor;

@property (assign,nonatomic,readonly)NSInteger year;

@property (assign,nonatomic,readonly)NSInteger month;


/** 以NSDate初始化一個日曆 */
+ (instancetype)calenderWithFrame:(CGRect)frame date:(NSDate *)date manager:(HenryCalenderManager *)manager;

/** 以NSDate初始化一個日曆 */
- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date manager:(HenryCalenderManager *)manager;

/** 以年,月數字初始化一個日曆 */
- (instancetype)initWithFrame:(CGRect)frame
                         year:(NSInteger)year
                        month:(NSInteger)month;

/** 設置日曆年月 */
- (void)setupCalenderYear:(NSInteger)year month:(NSInteger)month;

- (NSArray<HenryDay *> *)getCalenderDaysByStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
