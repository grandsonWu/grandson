//
//  HandleImageView.m
//  LoveBird
//
//  Created by User on 2017/1/4.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "HandleImageView.h"

@interface HandleImageView()<UIGestureRecognizerDelegate>

@property (nonatomic,weak)   UIImageView *imageV;

@end
@implementation HandleImageView

-(UIImageView *)imageV{  //串接imageView
    if(_imageV== nil){
        UIImageView *imageV=[[UIImageView alloc]init];
        imageV.frame= self.bounds;
        imageV.userInteractionEnabled= YES;
        [self  addSubview:imageV];
        _imageV= imageV;
        
        //添加手勢  
        [self addGes];
    }
    return _imageV;
}
-(void)setImage:(UIImage *)image{
    _image =image;
    NSLog(@"%@",self.imageV);
    self.imageV.image= image;
}


//添加手勢
-(void)addGes{
UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];//添加手勢
    [self.imageV addGestureRecognizer:pan];
//
//    [self.view addSubview:imageV];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.imageV addGestureRecognizer:pinch];

    UILongPressGestureRecognizer *longP =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longP:)];
    [self.imageV addGestureRecognizer:longP];
    
}
//方法  拖動手勢
-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y); //panview 就是pan所在的imageVIew
    
    [pan setTranslation:CGPointZero inView:pan.view];//回復位置
}

//方法   縮放手勢
-(void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale,pinch.scale);
    
    [pinch setScale:1];
}

//方法  長按縮放手勢
-(void)longP:(UILongPressGestureRecognizer *)longP{
    if (longP.state==UIGestureRecognizerStateBegan) {
        //先讓照片閃一下  把照片會至到畫板裡
        [UIView animateWithDuration:0.5 animations:^{longP.view.alpha= 0;
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.25 animations:^{longP.view.alpha=1;
            }completion:^(BOOL finished){
                
                // 把當前的view做一個截圖
                UIGraphicsBeginImageContextWithOptions(longP.view.bounds.size, NO, 0);
                
                CGContextRef ctx = UIGraphicsGetCurrentContext();//獲取上下文
                [self.layer  renderInContext:ctx];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();//  關閉上下文
//                self.drawView.image= newImage;
          
                if([self.delegate respondsToSelector:@selector(handleImageView:newImage:)]){//調用protocal代理方法
                    [self.delegate handleImageView:self newImage:newImage];
                }
                 [self  removeFromSuperview];//重父控件當中移除
            }];
        }];
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
