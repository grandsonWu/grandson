//
//  DialogData.m
//  ChatRoom
//
//  Created by 廖冠翰 on 2016/11/26.
//  Copyright © 2016年 Hanry. All rights reserved.
//

#import "DialogData.h"

@implementation DialogData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray new];
        self.QBmessages = [NSMutableArray new];
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleBlueColor]];
    }
    return self;
}
@end
