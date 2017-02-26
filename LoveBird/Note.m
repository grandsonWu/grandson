//
//  Note.m
//  LoveBird
//
//  Created by User on 2016/12/8.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "Note.h"
@interface Note(){
    UIImage *thumbImage;
    
}

@end
@implementation Note
-(NSString*)imageFilePath{
    NSString*home = NSHomeDirectory();
    NSString*document = [home stringByAppendingPathComponent:@"Documents"];
    NSString*photos =[document stringByAppendingPathComponent:@"photos"];
    NSString *filePath = [photos stringByAppendingPathComponent:self.imageFileName];
    return filePath;
}
-(void)clearProfileImage{
    thumbImage=nil;
    
    
}

-(UIImage*)  profileImage{
    if (thumbImage) {
        return thumbImage;
    }
    
    
    UIImage *image = [UIImage imageWithContentsOfFile:[self  imageFilePath ] ];
    if (!image) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(50, 50));
    float ratioOfWidth = 50.0/image.size.width;
    float ratioOfHeigh = 50.0/image.size.height;
    
    float ratio = MAX(ratioOfHeigh, ratioOfWidth);
    
    CGContextRef contenxt = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contenxt, 25, 25);
    CGContextScaleCTM(contenxt, ratio, ratio);
    [image drawAtPoint:CGPointMake(-image.size.width/2, -image.size.height/2)];
    
    thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  thumbImage;
    
    
    
    
    
    return nil;
    
}



@end
