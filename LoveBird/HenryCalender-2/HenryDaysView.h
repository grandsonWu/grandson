//
//  HenryDaysView.h
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HenryCalenderManager.h"

@class HenryDay;
@protocol HenryDaysViewDalagate <NSObject>

@optional
- (void)henryDaysViewDayTouchWithDate:(NSDate *)date henryDay:(HenryDay *)henryDay;

@end

@interface HenryDaysView : UIView

@property (weak,nonatomic)id<HenryDaysViewDalagate> dalagate;


- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date manager:(HenryCalenderManager *)manager;

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date;



/** 以年月數字設置日期 */
- (void)setupDaysViewYear:(NSInteger)year month:(NSInteger)month;

/** 以開始與結束日期取得區間內的HenryDay元件 */
- (NSArray<HenryDay *> *)getHenryDaysByStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;


@end
