//
//  APIManager.h
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define HOST @"cloud.culture.tw"
#define API_URL [NSString stringWithFormat:@"https://%@/",HOST]


#pragma mark - Activity
#define API_MOVIE    [API_URL stringByAppendingString:@"frontsite/trans/SearchShowAction.do"]  //獲取電影資訊

@interface APIManager : NSObject

+ (void)sendRequestWithParameters:(NSDictionary *)parameters
                             path:(NSString *)url
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
