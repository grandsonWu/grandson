//
//  DrawView.h
//  LoveBird
//
//  Created by User on 2017/1/3.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
-(void)clear;//清空
-(void)undo;//取消
-(void)erase;//橡皮擦
-(void)setLineWith:(CGFloat)lineWidth;//設置線的寬度
-(void)setLineColor:(UIColor *)color;//設置線的顏色

@property (nonatomic,strong) UIImage * image; //接受 要繪製的照片


@end
