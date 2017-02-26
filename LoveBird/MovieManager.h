//
//  MovieManager.h
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"
#import "Culture.h"

@interface MovieManager : NSObject

/** 獲取文化資訊 */
+ (void)apiGetCulturesByMethod:(NSString *)method
                      category:(NSString *)category
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/** Cultures result */
+ (NSArray<Culture *> *)apiResultGetCulturesWithResponse:(NSArray *)response;

@end
