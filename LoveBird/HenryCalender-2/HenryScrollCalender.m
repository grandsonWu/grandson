//
//  HenryScrollCalender.m
//  calendarTest
//
//  Created by 廖冠翰 on 2017/1/6.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import "HenryScrollCalender.h"
#import "HenryCalender.h"
#import "HenryCalenderTools.h"
#import "HenryCalenderManager.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HenryScrollCalender()<HenryCalenderDelegate>

@property (assign,nonatomic)CGFloat itemHeight;
@property (nonatomic,assign) CGFloat totalCalenderH;

@property (strong,nonatomic)NSMutableArray<HenryCalender *> *calenderArray;

//開始時間之前的日曆
@property (strong,nonatomic)NSMutableArray<HenryCalender *> *beforeCalenderArray;
//開始時間之前的日曆day item總和
@property (strong,nonatomic)NSArray<HenryDay *> *beforeDays;

//選取的日曆
@property (strong,nonatomic)NSMutableArray<HenryCalender *> *selectCalenderArray;
//選取的日曆內day item總和
@property (strong,nonatomic)NSArray<HenryDay *> *selectDays;

//日期狀態
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endDate;

//HenryDay狀態
@property (nonatomic,strong) HenryDay *lastHenryDate;
@property (nonatomic,strong) HenryDay *currentHenryDate;


@end

@implementation HenryScrollCalender

#pragma mark - Init Function
+ (instancetype)calenderWithFrame:(CGRect)frame manager:(HenryCalenderManager *)manager{
    
    return [[self alloc] initWithFrame:frame manager:manager];
}

- (instancetype)initWithFrame:(CGRect)frame manager:(HenryCalenderManager *)manager{
    if (self = [super initWithFrame:frame]) {
        self.manager = manager;
        self.totalCalenderH = 0;
        [self commonInit];
    }
    return self;
}


- (void)commonInit{
    
    NSDate *startDate = (self.manager.settings.startDate)?self.manager.settings.startDate:[NSDate date];
    NSInteger scrollCount = (self.manager.settings.scrollCount)?self.manager.settings.scrollCount:5;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
    
    

    for (int i=0; i<scrollCount; i++) {
        
        NSDate *date = [HenryCalenderTools getNextMonthDateByMonthIndex:i toDate:startDate];
        
        NSInteger dayCount = [HenryCalenderTools getMonthDaysByDate:date];
        NSInteger firstIndex = [HenryCalenderTools getMonthFirstDayIndexByDate:date];
        NSInteger totalCount = [HenryCalenderTools getDayButtonCountByDayCount:dayCount firstIndex:firstIndex];
        
        CGFloat calenderH = self.manager.settings.dayHeight * (totalCount / 7) + 10 + 80;
        
        CGRect frame = CGRectMake(self.frame.origin.x,self.totalCalenderH, self.frame.size.width, self.frame.size.height);
        HenryCalender *calender = [HenryCalender calenderWithFrame:frame date:date manager:self.manager];
        calender.dalagate = self;
        calender.weekViewBgColor = [UIColor whiteColor];
        calender.menuViewBgColor = [UIColor whiteColor];
        calender.menuViewTitleColor = [UIColor orangeColor];
        [scrollView addSubview:calender];
        [self.calenderArray addObject:calender];
        
        self.totalCalenderH += calenderH;
    }
    scrollView.contentSize = CGSizeMake(0, self.totalCalenderH);
    [self addSubview:scrollView];
    
    [self setupBeforeCalenderWithStartDate:[NSDate date]];
}

#pragma mark - Public Function
- (void)removeAllSelected{

    [self resetSelectedDays];
    self.startDate = nil;
    self.endDate = nil;
    self.selectDays = nil;
    self.selectCalenderArray = nil;
    self.beforeCalenderArray = nil;
}

#pragma mark - Getter
- (NSMutableArray *)calenderArray{
    if (!_calenderArray) {
        _calenderArray = [NSMutableArray array];
    }
    return _calenderArray;
}

#pragma mark - Setter
- (void)setCurrentHenryDate:(HenryDay *)currentHenryDate{
    if (_currentHenryDate) {
       _currentHenryDate.selected = NO;
    }
    _currentHenryDate = currentHenryDate;
    _currentHenryDate.selected = YES;
    _currentHenryDate.bottomTitle = self.manager.settings.startSelectedText;
}

#pragma mark - HenryCalenderDelegate

- (void)henryCalenderDayTouchWithDate:(NSDate *)date henryDay:(HenryDay *)henryDay{
    
    if (!self.startDate && !self.endDate) { //第一個點
        self.currentHenryDate = henryDay;
        self.startDate = date;
        return;
    }
    
    if (self.startDate && !self.endDate) {
        
        NSDate *earlierDate = [self.startDate earlierDate:date];
        if (earlierDate == self.startDate) { //第二個選取時間 > 第一個選取時間
            self.endDate = date;
            [self setupSelectedCalenderWithStartDate:self.startDate
                                             endDate:self.endDate];
        }else{                               //第二個選取時間 < 第一個選取時間
            self.endDate = self.startDate;
            self.startDate = date;
            
            [self setupSelectedCalenderWithStartDate:self.startDate
                                             endDate:self.endDate];
        }
        return;
    }
    
    if (self.startDate && self.endDate) {  //第三個點
        [self resetSelectedDays];
        self.currentHenryDate = henryDay;
        self.startDate = date;
        self.endDate = nil;
        
        return;
    }
}

#pragma mark - BeforeCalender Medthod
/**  以開始日期獲取陣列中的日曆 */
- (void)setupBeforeCalenderWithStartDate:(NSDate *)startDate{
     NSInteger startYear = [HenryCalenderTools getYearByDate:startDate];
    NSInteger startMonth = [HenryCalenderTools getMonthByDate:startDate];
    NSMutableArray<HenryCalender *> *beforeCalenderArray = [NSMutableArray array];
    [self.calenderArray enumerateObjectsUsingBlock:^(HenryCalender * _Nonnull calender,
                                                     NSUInteger idx,
                                                     BOOL * _Nonnull stop) {
        
        
        NSInteger calenderMonth = calender.month - (startYear - calender.year) * 12;
        if (calenderMonth <= startMonth && calender.year <= startYear) {
            [beforeCalenderArray addObject:calender];
        }
        self.beforeCalenderArray = beforeCalenderArray;
    }];
    
    [self showBeforeWithCalenderArray:beforeCalenderArray date:startDate];
}

/** 處理關閉的日曆 */
- (void)showBeforeWithCalenderArray:(NSArray<HenryCalender *> *)calenderArray date:(NSDate *)date{
    
    __block NSArray<HenryDay *> *beforedays = [NSArray array];
    [calenderArray enumerateObjectsUsingBlock:^(HenryCalender * _Nonnull calender,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        
        NSArray<HenryDay *> *days;
        if (idx == (calenderArray.count - 1)) {
            days = [calender getCalenderDaysByStartDate:nil endDate:date];
        }else{
            days = [calender getCalenderDaysByStartDate:nil endDate:nil];

        }
        
        beforedays = [beforedays arrayByAddingObjectsFromArray:days];
    }];
    
    self.beforeDays = beforedays;
    [self showAllBeforeDays:beforedays];
}

- (void)showAllBeforeDays:(NSArray<HenryDay *> *)days{
    [days enumerateObjectsUsingBlock:^(HenryDay * _Nonnull day, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != (days.count - 1)) {
            day.disabled = YES;
        }else{
            day.bottomTitle = self.manager.settings.startSelectedText;
        }
    }];
}

- (void)resetBeforeDays{
    if (self.beforeDays) {
        [self.beforeDays enumerateObjectsUsingBlock:^(HenryDay * _Nonnull day,
                                                      NSUInteger idx,
                                                      BOOL * _Nonnull stop) {
            day.disabled = NO;
        }];
    }
}

#pragma mark - SelectedCalender Medthod

/**  以開始日期與結束日期獲取陣列中的日曆 */
- (void)setupSelectedCalenderWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    [self resetSelectedDays];
    NSInteger startYear = [HenryCalenderTools getYearByDate:self.startDate];
    NSInteger endYear = [HenryCalenderTools getYearByDate:self.endDate];
    
    NSInteger startMonth = [HenryCalenderTools getMonthByDate:startDate] - (endYear - startYear) * 12;
    NSInteger endMonth = [HenryCalenderTools getMonthByDate:endDate];
    
    NSMutableArray<HenryCalender *> *selectCalenderArray = [NSMutableArray array];
    
    [self.calenderArray enumerateObjectsUsingBlock:^(HenryCalender * _Nonnull calender,
                                                     NSUInteger idx,
                                                     BOOL * _Nonnull stop) {
        
        //如果開始與結束日期不是同一年時,去年的月份必須減去相差的年份*月份
        NSInteger calenderMonth = calender.month - (endYear - calender.year) * 12;
       
        if (calenderMonth >= startMonth && calenderMonth <= endMonth) {
            [selectCalenderArray addObject:calender];
        }
    }];
    
    self.selectCalenderArray = selectCalenderArray;
    [self showSelectedWithCalenderArray:selectCalenderArray];
    return;
}

/** 處理選取的日曆 */
- (void)showSelectedWithCalenderArray:(NSArray<HenryCalender *> *)calenderArray{
    
    __block NSArray<HenryDay *> *selectdays = [NSArray array];
    
    [calenderArray enumerateObjectsUsingBlock:^(HenryCalender * _Nonnull calender, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray<HenryDay *> *days;
        if (calenderArray.count == 1) {
            days = [calender getCalenderDaysByStartDate:self.startDate endDate:self.endDate];
        }else if (idx == 0) {
            days = [calender getCalenderDaysByStartDate:self.startDate endDate:nil];
        }else if (idx == (calenderArray.count - 1)){
            days = [calender getCalenderDaysByStartDate:nil endDate:self.endDate];
        }else{
            days = [calender getCalenderDaysByStartDate:nil endDate:nil];
        }
        
        selectdays = [selectdays arrayByAddingObjectsFromArray:days];
    }];
    
    self.selectDays = selectdays;
    [self showAllSelectedDays:selectdays];
}

/** 處理選取的日曆中的Day狀態 */
- (void)showAllSelectedDays:(NSArray<HenryDay *> *)days{
    [days enumerateObjectsUsingBlock:^(HenryDay * _Nonnull day,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
        if ((idx == 0) || (idx == (days.count -1))) {
            if (idx == (days.count -1)) {  //最後一個範圍框
                day.bottomTitle = self.manager.settings.endSelectedText;
            }
            
            if (idx == 0) {                //第一個範圍框
                day.bottomTitle = self.manager.settings.startSelectedText;
            }
            day.selected = YES;
        }else{
            day.checked = YES;
        }
    }];
}

/** 清除選取的Day */
- (void)resetSelectedDays{
    if (self.selectDays) {
        [self.selectDays enumerateObjectsUsingBlock:^(HenryDay * _Nonnull day,
                                                      NSUInteger idx,
                                                      BOOL * _Nonnull stop) {
            day.selected = NO;
            day.checked = NO;
        }];
    }
}
@end
