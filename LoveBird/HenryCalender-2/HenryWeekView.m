//
//  HenryWeekView.m
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/30.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HenryWeekView.h"

@interface HenryWeekView()

@property (strong,nonatomic)NSArray *weekText;

@end

@implementation HenryWeekView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    for (int i=0; i<self.weekText.count; i++) {
        UILabel *dateLabel = [[UILabel alloc]init];
        CGFloat dateW = self.frame.size.width / self.weekText.count;
        CGFloat dateH = 30;
        CGFloat dateX = dateW * i ;
        CGFloat dateY = 0;
        
        dateLabel.frame = CGRectMake(dateX, dateY, dateW, dateH);
        dateLabel.text = self.weekText[i];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:dateLabel];
    }
}

- (NSArray *)weekText{
    if (!_weekText) {
        _weekText = @[@"週日",
                      @"週一",
                      @"週二",
                      @"週三",
                      @"週四",
                      @"週五",
                      @"週六",];
    }
    return _weekText;
}

@end
