//
//  HenryCalenderSettings.h
//  calendarTest
//
//  Created by 廖冠翰 on 2017/1/8.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HenryCalenderSettings : NSObject

//範圍模式開始日期
@property (nonatomic,strong)NSDate *startDate;
//範圍模式月份個數
@property (nonatomic,assign)NSInteger scrollCount;

//選取區間開始文字
@property (nonatomic,copy)NSString *startSelectedText;
//選取區間結束文字
@property (nonatomic,copy)NSString *endSelectedText;
//日期單位高度
@property (nonatomic,assign)NSInteger dayHeight;

@end
