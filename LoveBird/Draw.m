//
//  Draw.m
//  LoveBird
//
//  Created by User on 2017/1/2.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "Draw.h"
@interface Draw()
@property(nonatomic,strong) UIBezierPath *path;//當前繪製的路徑
@end

@implementation Draw

-(void)awakeFromNib{
    //添加手勢
    UIPanGestureRecognizer * pan= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer *)pan{  //在pan 裡面實施pan方法
    //判斷手勢的狀態
    if (pan.state==UIGestureRecognizerStateBegan) {
        //或許當前手指的點
        CGPoint curP= [pan locationInView:self];
        
        UIBezierPath *path = [UIBezierPath bezierPath];//創建路徑
    //設置起點
        [path moveToPoint:curP];
        
    }else if(pan.state== UIGestureRecognizerStateChanged){
        
        [self.path addLineToPoint:curP];//繪製一根線道當前手指所在的點
        [self setNeedsDisplay];//重繪
    }
}
-(void)drawRect:(CGRect)rect{
    //繪製當前的路徑
    [self.path stroke];
    
    
}



@end
