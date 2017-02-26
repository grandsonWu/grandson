//
//  APIManager.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager


+ (void)sendRequestWithParameters:(NSDictionary *)parameters
                             path:(NSString *)url
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]; //為了使創建對象識別類方法 故用NSURLSessionConfiguration來創建
    [manager.requestSerializer setTimeoutInterval:20];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];      //請求
    manager.responseSerializer = [AFJSONResponseSerializer serializer];     //響應
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:url parameters:parameters progress:nil success:success failure:failure];
    
}

@end
