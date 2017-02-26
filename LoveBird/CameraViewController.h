//
//  CameraViewController.h
//  LoveBird
//
//  Created by User on 2016/12/8.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
