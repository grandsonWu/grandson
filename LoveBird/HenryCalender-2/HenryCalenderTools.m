//
//  HenryCalenderTools.m
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HenryCalenderTools.h"

@implementation HenryCalenderTools

/** 計算此月天數 */
+ (NSInteger)getMonthDaysByDate:(NSDate *)date{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/** 計算此月第一天位置 */
+ (NSInteger)getMonthFirstDayIndexByDate:(NSDate *)date{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    [calender setFirstWeekday:1];
    NSDateComponents *component = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    [component setDay:1];
    NSDate *firstDayOfMonthDate = [calender dateFromComponents:component];
    NSInteger firstDayIndex = [calender ordinalityOfUnit:NSCalendarUnitWeekday
                                                  inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];

    return firstDayIndex;
}

/** 以NSDate獲取獲取年份 */
+ (NSInteger)getYearByDate:(NSDate *)date{
    NSDateComponents *component = [HenryCalenderTools getDateComponentsByDate:date];
    return component.year;
}

/** 以NSDate獲取獲取月份 */
+ (NSInteger)getMonthByDate:(NSDate *)date{
    NSDateComponents *component = [HenryCalenderTools getDateComponentsByDate:date];
    return component.month;
}

/** 以NSDate獲取日 */
+ (NSInteger)getDayByDate:(NSDate *)date{
    NSDateComponents *component = [HenryCalenderTools getDateComponentsByDate:date];
    return component.day;
}

/** 以NSDate獲取NSDateComponents */
+ (NSDateComponents *)getDateComponentsByDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    return component;
}

/** 獲取日期 */
+ (NSDate *)getDateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    NSDateComponents *component = [[NSDateComponents alloc]init];
    [component setYear:year];
    [component setMonth:month];
    [component setDay:day];
    
    return [[NSCalendar currentCalendar] dateFromComponents:component];
}

/** 取得傳入的Data的特定日 */
+ (NSDate *)getDateByDay:(NSInteger)day date:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    [component setDay:day];
    return [calender dateFromComponents:component];
}

/** 獲取以現在日期往後的月份日期 */
+ (NSDate *)getNextMonthDateByMonthIndex:(NSInteger)index toDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [[NSDateComponents alloc]init];
    [component setMonth:index];
    return [calender dateByAddingComponents:component toDate:date options:0];
}

/** 計算顯示在日曆上的日期數量(包含填充空白日期) */
+ (NSInteger)getDayButtonCountByDayCount:(NSInteger)dayCount firstIndex:(NSInteger)firstIndex{
    NSInteger totalCount = dayCount + firstIndex - 1;
    
    NSInteger lessCount = totalCount % 7;
    
    NSInteger fillCount = (lessCount > 0)?(7 - lessCount):lessCount;
    //最後補滿尾端
    return totalCount + fillCount;
}
@end
