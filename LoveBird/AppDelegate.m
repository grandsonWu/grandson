//
//  AppDelegate.m
//  LoveBird
//
//  Created by User on 2016/11/28.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Quickblox/Quickblox.h>


#define APP_ID 52032               //quickblox 創建ＩＤ
#define APP_AUTH_KEY @"hv6bjf7-C4FE-St"
#define APP_AUTH_SECRET @"tfFg2RuVa38Rc6u"
#define APP_ACCOUNT_KEY @"VPhEhxRXDHtLmwXVouXz"
@import Firebase;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [QBSettings setApplicationID:APP_ID];                //初始化框架
    [QBSettings setAuthKey:APP_AUTH_KEY];
    [QBSettings setAuthSecret:APP_AUTH_SECRET];
    [QBSettings setAccountKey:APP_ACCOUNT_KEY];
    
    
    NSLog(@"home = %@",NSHomeDirectory());//可以查出存放照片的document路徑
    [Fabric with:@[[Crashlytics class]]];
    [FIRApp configure]; //firebase
    self.ref=[[FIRDatabase database] reference];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
