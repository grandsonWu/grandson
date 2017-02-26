//
//  HandleImageView.h
//  LoveBird
//
//  Created by User on 2017/1/4.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  HandleImageView;

@protocol handleImageViewDelegate <NSObject>

-(void)handleImageView:(HandleImageView *)handleimageView  newImage:(UIImage *) newImage;

@end
@interface HandleImageView : UIView


@property(nonatomic,strong) UIImage *image;


@property(nonatomic,weak) id<handleImageViewDelegate>delegate;
@end
