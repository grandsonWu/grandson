//
//  AppDelegate.h
//  LoveBird
//
//  Created by User on 2016/11/28.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic) FIRDatabaseReference *ref;

@end

