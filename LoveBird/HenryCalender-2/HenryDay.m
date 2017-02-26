//
//  HenryDay.m
//  calendarTest
//
//  Created by 廖冠翰 on 2016/12/31.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HenryDay.h"

@interface HenryDay()

@property (weak, nonatomic) IBOutlet UIView *selectedBg;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation HenryDay

#pragma mark - Init Object
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"HenryDay"
                                             owner:nil
                                           options:nil]lastObject];
        self.frame = frame;
        [self initParam];
    }
    return self;
}

#pragma mark - Param Init
- (void)initParam{
    self.selectedBg.hidden = YES;
    self.bottomLabel.hidden = YES;
    self.title.textColor = [UIColor blackColor];
    [self clipsSelectedBgBounds];
}

#pragma mark - Setter
- (void)setSelected:(BOOL)selected{
        _selected = selected;
        self.selectedBg.hidden = !selected;
        self.bottomLabel.hidden = !selected;
        self.title.textColor = (selected)?[UIColor whiteColor]:[UIColor blackColor];
}

- (void)setChecked:(BOOL)checked{
        _checked = checked;
        self.selectedBg.hidden = !checked;
        self.bottomLabel.hidden = YES;
        self.title.textColor = (checked)?[UIColor whiteColor]:[UIColor blackColor];
}

- (void)setDisabled:(BOOL)disabled{
    _disabled = disabled;
    self.selectedBg.hidden = YES;
    self.bottomLabel.hidden = YES;
    self.title.textColor = (disabled)?[UIColor lightGrayColor]:[UIColor blackColor];
}

- (void)setBottomTitle:(NSString *)bottomTitle{
    _bottomTitle = bottomTitle;
    self.bottomLabel.text = bottomTitle;
}



#pragma mark - Event Handler
- (IBAction)dayTouch {
    if ([self.dalegate respondsToSelector:@selector(dayTouchWithHenryDay:)]) {
        [self.dalegate dayTouchWithHenryDay:self];
    }
}

#pragma mark - Class Medthod
- (void)clipsSelectedBgBounds{
    [self.selectedBg.layer setCornerRadius:5.0];
    [self.selectedBg.layer setMasksToBounds:YES];
}

@end
