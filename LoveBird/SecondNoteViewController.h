//
//  SecondNoteViewController.h
//  LoveBird
//
//  Created by User on 2016/12/13.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@protocol SecondNoteViewControllerDelegate <NSObject>

@optional
- (void)secondNoteViewControllerReloadData;

@end

@interface SecondNoteViewController : UIViewController

@property(nonatomic,weak)id<SecondNoteViewControllerDelegate>delegate;

@property(nonatomic) Note *currentNote;
@end
