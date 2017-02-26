//
//  News.h
//  LoveBird
//
//  Created by User on 2017/1/14.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShowInfo;
@interface News : NSObject

@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)ShowInfo *showInfo;

@end
