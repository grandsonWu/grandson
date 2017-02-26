//
//  HenryCalender.m
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HenryCalender.h"
#import "HenryDaysView.h"
#import "HenryCalenderTools.h"
#import "HenryWeekView.h"
#import "HenryDay.h"
#import "HenryMenuView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface HenryCalender()<HenryDaysViewDalagate>

@property (weak, nonatomic) IBOutlet HenryMenuView *menuView;

@property (weak, nonatomic) IBOutlet HenryWeekView *weekView;

@property (strong,nonatomic) HenryDaysView *daysView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weekViewConrtaint;

@end

@implementation HenryCalender

#pragma mark - Init Func

/** 以NSDate初始化一個日曆 */
+ (instancetype)calenderWithFrame:(CGRect)frame date:(NSDate *)date manager:(HenryCalenderManager *)manager{
    
    return [[self alloc]initWithFrame:frame date:date manager:manager];
}

/** 以NSDate初始化一個日曆 */
- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date manager:(HenryCalenderManager *)manager{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"HenryCalender"
                                             owner:nil
                                           options:nil] firstObject];
        self.frame = frame;
        NSInteger year = [HenryCalenderTools getYearByDate:date];
        NSInteger month = [HenryCalenderTools getMonthByDate:date];
        self.menuView.title = [NSString stringWithFormat:@"%ld年%ld月",year,month];
        _year = year;
        _month = month;
        
        //創建WeekView
        HenryWeekView *weekView = [[HenryWeekView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, frame.size.height - 40)];
        
        //創建DaysView
        HenryDaysView *daysView = [[HenryDaysView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, frame.size.height - 80)
                                                                 date:date
                                                              manager:manager];
        daysView.dalagate = self;
        self.daysView = daysView;
        [self addSubview:weekView];
        [self addSubview:daysView];
        
    }
    return self;
}

// 以年,月數字初始化一個日曆
- (instancetype)initWithFrame:(CGRect)frame
                         year:(NSInteger)year
                        month:(NSInteger)month{
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"HenryCalender"
                                             owner:nil
                                           options:nil] firstObject];
        self.frame = frame;
        self.daysView.dalagate = self;
        [self.daysView setupDaysViewYear:year month:month];
    }
    return self;
}

#pragma mark - Setter

- (void)setMenuViewBgColor:(UIColor *)menuViewBgColor{
    _menuViewBgColor = menuViewBgColor;
    self.menuView.backgroundColor = menuViewBgColor;
}

- (void)setMenuViewTitleColor:(UIColor *)menuViewTitleColor{
    _menuViewTitleColor = menuViewTitleColor;
    self.menuView.titleColor = menuViewTitleColor;
}

- (void)setWeekViewBgColor:(UIColor *)weekViewBgColor{
    _weekViewBgColor = weekViewBgColor;
    self.weekView.backgroundColor = weekViewBgColor;
}

#pragma mark - Getter


#pragma mark - HenryDaysViewDalagate
- (void)henryDaysViewDayTouchWithDate:(NSDate *)date henryDay:(HenryDay *)henryDay{
    if ([self.dalagate respondsToSelector:@selector(henryCalenderDayTouchWithDate:henryDay:)]) {
        [self.dalagate henryCalenderDayTouchWithDate:date henryDay:henryDay];
    }
}

#pragma mark - Class Medthod

/** 設置日曆年月 */
- (void)setupCalenderYear:(NSInteger)year month:(NSInteger)month{
    [self.daysView setupDaysViewYear:year month:month];
}

- (NSArray<HenryDay *> *)getCalenderDaysByStartDate:(NSDate *)startDate
                                            endDate:(NSDate *)endDate{
    
    return [self.daysView getHenryDaysByStartDate:startDate endDate:endDate];
}
@end
