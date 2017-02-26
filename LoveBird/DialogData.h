//
//  DialogData.h
//  ChatRoom
//
//  Created by 廖冠翰 on 2016/11/26.
//  Copyright © 2016年 Hanry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSQMessages.h"


@interface DialogData : NSObject
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *QBmessages;
@property (strong, nonatomic) NSDictionary *avatars;
@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;
@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;
@property (strong, nonatomic) NSDictionary *users;
@end
