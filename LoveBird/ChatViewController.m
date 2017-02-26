//
//  ViewController.m
//  ChatRoom
//
//  Created by 廖冠翰 on 2016/11/26.
//  Copyright © 2016年 Hanry. All rights reserved.
//

#import "ChatViewController.h"
#import "DialogData.h"
#import "LoginManager.h"
#import "QuickbloxManager.h"
#import "MBProgressHUD+Henry.h"

@interface ChatViewController ()<QBChatDelegate>

@property(nonatomic,strong)DialogData *dialogData;
@property(nonatomic,strong)QBChatDialog *chatDialog;

@end

@implementation ChatViewController


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initParam];
    [self initUI];
    
}

#pragma mark - Param Init
- (void)initParam{
    [[QBChat instance] addDelegate:self];
    [self setupDialog];
}

/** 創建或取得對話 */
- (void)setupDialog{
    
    if (self.chatDialog) {
        [QuickbloxManager connectToChatCompletion:nil];;
        [MBProgressHUD hideHUD];
        return;
    }
    [self apiDialogsForPageWithCompletion:^(QBResponse *response,
                                            NSArray<QBChatDialog *> *dialogObjects,
                                            NSSet *dialogsUsersIDs,
                                            QBResponsePage *page) {
        
        __block BOOL found = NO;
        if (dialogObjects.count > 0) {
            
            //當某個對話中occupantIDs有對方ID時,就獲取此對話
            [dialogObjects enumerateObjectsUsingBlock:^(QBChatDialog * _Nonnull chatDialog,
                                                        NSUInteger idx,
                                                        BOOL * _Nonnull stop) {
                
                if (chatDialog.occupantIDs.count == 2 &&
                    ([chatDialog.occupantIDs[0] integerValue] == self.reciver.ID ||
                     [chatDialog.occupantIDs[1] integerValue] == self.reciver.ID)) {
                        self.chatDialog = chatDialog;
                        found = YES;
                        [QuickbloxManager connectToChatCompletion:^(NSError * _Nullable error) {
                            [self getChatHistoryFromServerWithSkip:0 withScrollToBottom:YES];
                        }]; 
                }
            }];
        }
        
        // 尚未建立與對方的對話
        if (!found) {
            [self createDialogCompletion:^{
                [QuickbloxManager connectToChatCompletion:^(NSError * _Nullable error) {
                    [self getChatHistoryFromServerWithSkip:0 withScrollToBottom:YES];
                }];
            }];
        }
    }];
}



#pragma mark - UI Init
- (void)initUI{
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    self.showLoadEarlierMessagesHeader = YES;
    //    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}


#pragma mark - Getter
- (DialogData *)dialogData{
    if (!_dialogData) {
        _dialogData = [[DialogData alloc]init];
    }
    return _dialogData;
}

#pragma mark - JSQMessages CollectionView DataSource

/** 送出ID */
- (NSString *)senderId{
    return  [NSString stringWithFormat:@"%ld",[[QBSession currentSession] currentUser].ID];
}

/** 送出Name */
- (NSString *)senderDisplayName{
    NSLog(@"%@",[[LoginManager shareManager] getUserName]);
    return [[LoginManager shareManager] getUserName];
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dialogData.messages objectAtIndex:indexPath.item];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dialogData.messages removeObjectAtIndex:indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath{
    JSQMessage *message = [self.dialogData.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.dialogData.outgoingBubbleImageData;
    }
    
    return self.dialogData.incomingBubbleImageData;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.dialogData.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.dialogData.messages objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.dialogData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dialogData.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    
    JSQMessage *msg = [self.dialogData.messages objectAtIndex:indexPath.item];
    
    if (!msg.isMediaMessage) {
        
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}


#pragma mark - QBChatDelegate
- (void)chatDidReceiveMessage:(QBChatMessage *)message{
    [self scrollToBottomAnimated:YES];
    JSQMessage *jqMessage = [JSQMessage messageWithSenderId:[NSString stringWithFormat:@"%ld",message.senderID]
                                                displayName:self.reciver.fullName
                                                       text:message.text];
    
    [self.dialogData.QBmessages addObject:message];
    [self.dialogData.messages addObject:jqMessage];
    [self finishReceivingMessageAnimated:YES];
}

#pragma mark - Overwrite

/** 送出訊息 */
- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date{
    
    JSQMessage *message = [[JSQMessage alloc]initWithSenderId:senderId
                                            senderDisplayName:senderDisplayName
                                                         date:date
                                                         text:text];
    
    [self sendQBMessageWithJSQMessage:message];
}

/** 夾帶圖片 */
- (void)didPressAccessoryButton:(UIButton *)sender{
    [MBProgressHUD showError:@"功能尚未開放" toView:nil];
}

#pragma mark - API

/** 取得當前使用者所有的對話 */
- (void)apiDialogsForPageWithCompletion:(void(^)(QBResponse *response, NSArray *dialogObjects, NSSet *dialogsUsersIDs, QBResponsePage *page))completion{
    
    [MBProgressHUD showLoading:@"載入聊天室中"];
    [QuickbloxManager apiDialogsForPageWithLimit:100 skip:0 success:^(QBResponse *response, NSArray *dialogObjects, NSSet *dialogsUsersIDs, QBResponsePage *page) {
        completion(response,dialogObjects,dialogsUsersIDs,page);
    } error:^(QBResponse *response) {
        
    }];
}

/** 創建一個新的對話 */
- (void)apiCreatrDialogWithChatDialog:(QBChatDialog *)chatDialog
                           completion:(void(^)(QBResponse *response, QBChatDialog *createdDialog))completion{
    
    [QuickbloxManager apiCreateDialogWithChatDialog:chatDialog success:^(QBResponse *response, QBChatDialog *createdDialog) {
        completion(response,createdDialog);
    } error:^(QBResponse *response) {
        
    }];
}

/** 連線到 QuickBlox 伺服器 */
- (void)apiConnectToChat{
    QBChatDialog *chatDialog = [[QBChatDialog alloc] initWithDialogID:nil
                                                                 type:QBChatDialogTypePrivate];
    chatDialog.occupantIDs = @[[NSString stringWithFormat:@"%zd", self.reciver.ID]];
    [QBRequest createDialog:chatDialog successBlock:^(QBResponse *response, QBChatDialog *createdDialog) {
        self.chatDialog = createdDialog;
        [QuickbloxManager connectToChatCompletion:nil];
    } errorBlock:^(QBResponse *response) {
    }];
}


#pragma mark - Quickblox Medthod

/** 發送訊息至Quickblox */
- (void)sendQBMessageWithJSQMessage:(JSQMessage *)JSQMessage{
    
    QBChatMessage *qbMessage = [QBChatMessage message];
    qbMessage.text = JSQMessage.text;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"save_to_history"] = @YES;
    [qbMessage setCustomParameters:params];
    [self finishSendingMessageAnimated:YES];
    
    [self.chatDialog sendMessage:qbMessage completionBlock:^(NSError * _Nullable error) {
        [self.dialogData.messages addObject:JSQMessage];
        [self.dialogData.QBmessages addObject:qbMessage];
        [self.collectionView reloadData];
    }];
}

/** 創建一個新的對話 */
- (void)createDialogCompletion:(void(^)())completion{
    QBChatDialog *chatDialog = [[QBChatDialog alloc] initWithDialogID:nil
                                                                 type:QBChatDialogTypePrivate];
    chatDialog.occupantIDs = @[[NSString stringWithFormat:@"%zd", self.reciver.ID]];
    [self apiCreatrDialogWithChatDialog:chatDialog completion:^(QBResponse *response, QBChatDialog *createdDialog) {
        self.chatDialog = createdDialog;
        completion();
    }];
}

/** 取得歷史對話 */
- (void)getChatHistoryFromServerWithSkip:(NSInteger)index withScrollToBottom:(BOOL)shouldScrollToBottom {
    
    QBResponsePage *resPage = [QBResponsePage responsePageWithLimit:20 skip:index];
    [QBRequest messagesWithDialogID:self.chatDialog.ID
                    extendedRequest:nil forPage:resPage
                       successBlock:^(QBResponse * _Nonnull response,
                                      NSArray<QBChatMessage *> * _Nullable messages,
                                      QBResponsePage * _Nullable page) {
                           
                           [messages enumerateObjectsUsingBlock:^(QBChatMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                               JSQMessage *message = [[JSQMessage alloc]initWithSenderId:[NSString stringWithFormat:@"%ld",obj.senderID]
                                                                       senderDisplayName:@""
                                                                                    date:obj.dateSent
                                                                                    text:obj.text];
                               [self.dialogData.messages addObject:message];
                               [self.dialogData.QBmessages addObject:obj];
                           }];
                           
                           [self.collectionView reloadData];
                           [MBProgressHUD hideHUD];
                           
                       } errorBlock:^(QBResponse * _Nonnull response) {
                           [MBProgressHUD hideHUD];
                       }];
}

@end
