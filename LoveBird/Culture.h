//
//  Culture.h
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowInfo.h"

@interface Culture : NSObject

@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *UID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *category;
@property(nonatomic,strong)NSArray *showInfo;
@property(nonatomic,copy)NSString *showUnit;
@property(nonatomic,copy)NSString *discountInfo;
@property(nonatomic,copy)NSString *descriptionFilterHtml;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,strong)NSArray *masterUnit;
@property(nonatomic,strong)NSArray *subUnit;
@property(nonatomic,strong)NSArray *supportUnit;
@property(nonatomic,strong)NSArray *otherUnit;
@property(nonatomic,copy)NSString *webSales;
@property(nonatomic,copy)NSString *sourceWebPromote;
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *editModifyDate;
@property(nonatomic,copy)NSString *sourceWebName;
@property(nonatomic,copy)NSString *startDate;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,assign)NSInteger hitRate;

@end
