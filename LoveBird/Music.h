//
//  Music.h
//  LoveBird
//
//  Created by User on 2016/12/27.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,copy)NSString *musicName;
@property(nonatomic,copy)NSString *singerName;
@property(nonatomic,copy)NSString *musicImageName;
@property(nonatomic,copy)NSString *iconImageName;

@end
