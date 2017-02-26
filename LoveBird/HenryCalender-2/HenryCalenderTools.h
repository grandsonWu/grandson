//
//  HenryCalenderTools.h
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HenryCalenderTools : NSObject

/** 計算此月天數 */
+ (NSInteger)getMonthDaysByDate:(NSDate *)date;

/** 計算此月第一天位置 */
+ (NSInteger)getMonthFirstDayIndexByDate:(NSDate *)date;

/** 以年月日獲取日期 */
+ (NSDate *)getDateByYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/** 取得傳入的Data的特定日 */
+ (NSDate *)getDateByDay:(NSInteger)day date:(NSDate *)date;

/** 以NSDate獲取獲取年份 */
+ (NSInteger)getYearByDate:(NSDate *)date;

/** 以NSDate獲取獲取月份 */
+ (NSInteger)getMonthByDate:(NSDate *)date;

/** 以NSDate獲取日 */
+ (NSInteger)getDayByDate:(NSDate *)date;

/** 以NSDate獲取NSDateComponents */
+ (NSDateComponents *)getDateComponentsByDate:(NSDate *)date;

/** 獲取以現在日期往後的月份日期 */
+ (NSDate *)getNextMonthDateByMonthIndex:(NSInteger)index toDate:(NSDate *)date;

/** 計算顯示在日曆上的日期數量(包含填充空白日期) */
+ (NSInteger)getDayButtonCountByDayCount:(NSInteger)dayCount
                              firstIndex:(NSInteger)firstIndex;

@end
