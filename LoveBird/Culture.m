//
//  Culture.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//


#import "Culture.h"
#import "ShowInfo.h"
#import "MJExtension.h"

@implementation Culture

- (void)setShowInfo:(NSArray *)showInfo{
    
    NSMutableArray *infoArray = [NSMutableArray array];
    [showInfo enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict,
                                           NSUInteger idx,
                                           BOOL * _Nonnull stop) {
        ShowInfo *info = [ShowInfo mj_objectWithKeyValues:dict];
        [infoArray addObject:info];
    }];
    
    _showInfo = infoArray;
}

//NSDictionary有一个方法叫enumerateKeysAndObjectsUsingBlock，它就一个参数就是block，这个block携带了三个参数，这将要把dictionary里面的key和value每次一组传递到block，enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block。这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个key2的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block。

@end
