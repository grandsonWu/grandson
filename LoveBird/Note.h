//
//  Note.h
//  LoveBird
//
//  Created by User on 2016/12/8.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
@import CoreData;

@interface Note : NSManagedObject
@property (nonatomic) NSString * content;
//@property(nonatomic) UIImage * image;
@property(nonatomic) NSString *imageFileName;
@property(nonatomic)NSDate * updataTime;
-(void)clearProfileImage;
-(UIImage*)  profileImage;
@end
