//
//  HenryDay.h
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/31.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HenryDay;
@protocol HenryDayDelegate <NSObject>

@optional
- (void)dayTouchWithHenryDay:(HenryDay *)henryDay;

@end

@interface HenryDay : UIView

@property (weak, nonatomic) id<HenryDayDelegate> dalegate;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) NSString *bottomTitle;
@property (assign,nonatomic)BOOL selected;
@property (assign,nonatomic)BOOL checked;
@property (assign,nonatomic)BOOL disabled;

- (instancetype)initWithFrame:(CGRect)frame;



@end
