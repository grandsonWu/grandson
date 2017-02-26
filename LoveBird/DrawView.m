//
//  DrawView.m
//  LoveBird
//
//  Created by User on 2017/1/3.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "DrawView.h"
#import "MyBezierPath.h"
@interface DrawView()
@property(nonatomic,strong) UIBezierPath *path;//當前繪製的路徑

@property(nonatomic,strong)NSMutableArray*allPathArry;//保存當前繪製的所有路徑

@property (nonatomic, assign) CGFloat width;   //當前路徑的線寬
@property(nonatomic,strong)UIColor *color;            //當前路徑的顏色

@end

@implementation DrawView

-(NSMutableArray *)allPathArry{
    
    if(_allPathArry==nil){
        _allPathArry = [NSMutableArray array];   //保存有畫的線條到陣列裡 
    }
    return _allPathArry;
}

-(void)awakeFromNib{
    //添加手勢
    [super awakeFromNib];
    UIPanGestureRecognizer * pan= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    self.width= 1;
    self.color = [UIColor blackColor];
    
}

-(void)setImage:(UIImage *)image{
    _image =image;
    
    [self.allPathArry addObject:image];  //添加圖片至陣列中
    [self setNeedsDisplay];  //此方法會掉用到drawRect方法
}
//清空
-(void)clear{
    [self.allPathArry removeAllObjects]; //清空所有路徑
    [self setNeedsDisplay];  //重繪
    
}
//取消
-(void)undo{
    [self.allPathArry removeLastObject];
    [self setNeedsDisplay];
    
}

////橡皮擦
-(void)erase{
    [self setLineColor:[UIColor whiteColor]];
}

//設置線的寬度
-(void)setLineWith:(CGFloat)lineWidth{
    self.width = lineWidth;
}
//設置線的顏色
-(void)setLineColor:(UIColor *)color{
    self.color=color;
    
}


//
-(void)pan:(UIPanGestureRecognizer *)pan{  //在pan 裡面實施pan方法
   
     CGPoint curP= [pan locationInView:self];//或許當前手指的點
    if (pan.state==UIGestureRecognizerStateBegan) {  //判斷手勢的狀態
//        
//        UIBezierPath *path = [UIBezierPath bezierPath];//創建路徑  原本可以使用  但沒有顏色切換所以自定義類別MyBezierPath
//        
        MyBezierPath *path =[[MyBezierPath alloc]init];
        self.path= path;
        //設置起點
        [path moveToPoint:curP];
        
        [path setLineWidth:self.width];//設置線的寬度
        //設置線的顏色
        //什麼情況下自定義類別：當發現系統原始功能,沒有辦法滿足自己購物需求時,這時候要自訂類別繼承成系統原來的東西,再去添加屬性自己的東西
        path.color = self.color;
        
        [self.allPathArry addObject:path];
        
    }else if(pan.state== UIGestureRecognizerStateChanged){
        
        [self.path addLineToPoint:curP];//繪製一根線道當前手指所在的點
        [self setNeedsDisplay];//重繪
    }
}
-(void)drawRect:(CGRect)rect{
    //繪製保存的所有路徑
    for (MyBezierPath *path in self.allPathArry) {
        
        if([path isKindOfClass:[UIImage class]]){//判斷取出來的路徑真實類別
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
            
            
        }else{  //是圖片就不用color用法  不是圖片就可以執行以下方法
            
            [path.color set];
            [path stroke];
        
    }
    
    
}

}

@end
