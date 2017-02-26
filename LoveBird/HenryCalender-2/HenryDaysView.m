//
//  HenryDaysView.m
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HenryDaysView.h"
#import "HenryCalenderTools.h"
#import "HenryDay.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface HenryDaysView()<HenryDayDelegate>

//Date
@property (assign,nonatomic) NSInteger year;
@property (assign,nonatomic) NSInteger month;

//DayButton
@property (strong,nonatomic) HenryDay *lastDay;

//DataArray
@property (strong,nonatomic)NSMutableArray<HenryDay *> *daysArray;

@end

@implementation HenryDaysView

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date manager:(HenryCalenderManager *)manager{
    if (self = [super init]) {

        self.frame = frame;
        [self initDaysParamByDate:date];
        [self setupDaysViewDate:date];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date{
    if (self = [super init]) {
        self.frame = frame;
        [self initDaysParamByDate:date];
        [self setupDaysViewDate:date];
    }
    return self;
}



- (void)initDaysParamByDate:(NSDate *)date{

    NSInteger dayCount = [HenryCalenderTools getMonthDaysByDate:date];
    NSInteger firstIndex = [HenryCalenderTools getMonthFirstDayIndexByDate:date];
    NSInteger totalCount = [self getDayButtonCountByDayCount:dayCount firstIndex:firstIndex];
    
    for (NSInteger i=0; i<totalCount; i++) {
        
        CGFloat topInset = 10;
        CGFloat marginX = 0;
        CGFloat marginY = 0;
        CGFloat dayButtonW = (SCREEN_WIDTH - (marginX * 8)) / 7;
        CGFloat dayButtonH = 45;
        CGFloat dayButtonX = marginX + (dayButtonW + marginX) * (i % 7);
        CGFloat dayButtonY = marginY + (dayButtonH + marginY) * (i / 7) + topInset;
        
        
        HenryDay *dayButton = [[HenryDay alloc]initWithFrame:CGRectMake(dayButtonX,
                                                                        dayButtonY,
                                                                        dayButtonW,
                                                                        dayButtonH)];
        
        
        //firstIndex之前的格子及最後一天之後填充的格子日期都顯示空白
        if ((i + 1) >= firstIndex && (i + 1) <= dayCount + firstIndex - 1) {
            
            dayButton.dalegate = self;
            NSString *dayIndexTitle = [NSString stringWithFormat:@"%ld",i - firstIndex + 2];
            dayButton.title.text = dayIndexTitle;
            [self.daysArray addObject:dayButton];
        }else{
            dayButton.title.text = @"";
        }
        
        [self addSubview:dayButton];
    }
}

#pragma mark - Getter
- (NSMutableArray<HenryDay *> *)daysArray{
    if (!_daysArray) {
        _daysArray = [NSMutableArray array];
    }
    return _daysArray;
}

#pragma mark - HenryDayDelegate
- (void)dayTouchWithHenryDay:(HenryDay *)henryDay{
    
    if (!henryDay.disabled) {
//      self.lastDay.selected = NO;
//      henryDay.selected = YES;
        
        NSInteger day = [henryDay.title.text integerValue];
        NSDate *date = [HenryCalenderTools getDateByYear:self.year month:self.month day:day];
        if ([self.dalagate respondsToSelector:@selector(henryDaysViewDayTouchWithDate:henryDay:)]) {
            [self.dalagate henryDaysViewDayTouchWithDate:date henryDay:henryDay];
        }
//      self.lastDay = henryDay;
    }
}

#pragma mark - Class Medthod
/** 以Date刷新日期 */
- (void)setupDaysViewDate:(NSDate *)date{
    self.year = [HenryCalenderTools getYearByDate:date];
    self.month = [HenryCalenderTools getMonthByDate:date];
}

/** 以年月數字刷新日期 */
- (void)setupDaysViewYear:(NSInteger)year month:(NSInteger)month{
    self.year = year;
    self.month = month;
    [self setNeedsDisplay];
}

/** 計算顯示在日曆上的日期數量(包含填充空白日期) */
- (NSInteger)getDayButtonCountByDayCount:(NSInteger)dayCount
                         firstIndex:(NSInteger)firstIndex{
    NSInteger totalCount = dayCount + firstIndex - 1;
    
    NSInteger lessCount = totalCount % 7;
    
    NSInteger fillCount = (lessCount > 0)?(7 - lessCount):lessCount;
    //最後補滿尾端
    return totalCount + fillCount;
}

/** 以開始與結束日期取得區間內的HenryDay元件 */
- (NSArray<HenryDay *> *)getHenryDaysByStartDate:(NSDate *)startDate
                                         endDate:(NSDate *)endDate{
    
    NSMutableArray<HenryDay *> *selectedArray = [NSMutableArray array];
    if (!startDate && !endDate) { //獲取整天
        selectedArray = self.daysArray;
    }else if (startDate && !endDate){ //只有指定開始日期
        NSInteger startDayIndex = [HenryCalenderTools getDayByDate:startDate] - 1;
        NSInteger endDayIndex = self.daysArray.count - 1;
        
        selectedArray = [self getSelectedArrayWithStartDayIndex:startDayIndex
                                                    endDayIndex:endDayIndex];
    }else if (!startDate && endDate){//只有指定結束日期
        NSInteger startDayIndex = 0;
        NSInteger endDayIndex = [HenryCalenderTools getDayByDate:endDate] - 1;
        
        selectedArray = [self getSelectedArrayWithStartDayIndex:startDayIndex
                                                    endDayIndex:endDayIndex];
    }else{//都有指定日期
        NSInteger startDayIndex = [HenryCalenderTools getDayByDate:startDate] - 1;
        NSInteger endDayIndex = [HenryCalenderTools getDayByDate:endDate] - 1;
        
        selectedArray = [self getSelectedArrayWithStartDayIndex:startDayIndex
                                                   endDayIndex:endDayIndex];
    }
    return selectedArray;
}

/** 以開始與結束取得Day */
- (NSMutableArray<HenryDay *> *)getSelectedArrayWithStartDayIndex:(NSInteger)startDayIndex
                                                      endDayIndex:(NSInteger)endDayIndex{
    
    NSMutableArray<HenryDay *> *selectedArray = [NSMutableArray array];
    [self.daysArray enumerateObjectsUsingBlock:^(HenryDay * _Nonnull obj,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
        
        if (idx >= startDayIndex && idx <= endDayIndex) {
            [selectedArray addObject:obj];
        }
    }];
    
    return selectedArray;
}

@end
