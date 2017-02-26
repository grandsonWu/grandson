//
//  ViewController.h
//  ChatRoom
//
//  Created by 廖冠翰 on 2016/11/26.
//  Copyright © 2016年 Hanry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JSQMessagesViewController/JSQMessagesViewController.h>
#import "JSQMessages.h"
#import <Quickblox/Quickblox.h>

@interface ChatViewController : JSQMessagesViewController

@property(nonatomic,strong)QBUUser *reciver;


@end

