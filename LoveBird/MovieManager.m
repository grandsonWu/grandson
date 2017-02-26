//
//  MovieManager.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "MovieManager.h"
#import "MJExtension.h"
#import "Culture.h"

@implementation MovieManager

/** 獲取電影資訊 */
+ (void)apiGetCulturesByMethod:(NSString *)method
                      category:(NSString *)category
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSDictionary *parameters = @{@"method":method,
                                 @"category":category};
    
    [APIManager sendRequestWithParameters:parameters path:API_MOVIE success:success failure:failure];
}



/** Cultures result */
+ (NSArray<Culture *> *)apiResultGetCulturesWithResponse:(NSArray *)response{
    
    NSMutableArray<Culture *> *cultures = [NSMutableArray array];
    [response enumerateObjectsUsingBlock:^(id  _Nonnull dict,
                                           NSUInteger idx,
                                           BOOL * _Nonnull stop) {
        
        Culture *culture = [Culture mj_objectWithKeyValues:dict];
        [cultures addObject:culture];
    }];
    
    return cultures;
}


@end
