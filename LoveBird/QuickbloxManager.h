//
//  QuickbloxManager.h
//  ChatRoom
//




#import <Foundation/Foundation.h>
#import <Quickblox/Quickblox.h>

FOUNDATION_EXPORT NSString * const kUserId;
FOUNDATION_EXPORT NSString * const kUserName;
FOUNDATION_EXPORT NSString * const kUserEmail;
FOUNDATION_EXPORT NSString * const kUserPassword;

@interface QuickbloxManager : NSObject

/** 註冊一個使用者 */
+ (void)apiRegisterUserWithParam:(NSDictionary *)param
                   success:(void(^)(QBResponse *response,QBUUser *user))success
                     error:(void(^)(QBResponse *response))error;

/** 使用者login登入 */
+ (void)apiLoginWithUserLogin:(NSString *)login
                  password:(NSString *)password
                   success:(void(^)(QBResponse *response,QBUUser *user))success
                     error:(void(^)(QBResponse *response))error;

/** 使用者email登入 */
+ (void)apiLoginWithUserEmail:(NSString *)email
                     password:(NSString *)password
                      success:(void(^)(QBResponse *response,QBUUser *user))success
                        error:(void(^)(QBResponse *response))error;

/** 取得全部使用者 */
+ (void)apiGetUsersWithPageFrom:(NSInteger)from
                            to:(NSInteger)to
                       success:(void(^)(QBResponse *response,
                                        QBGeneralResponsePage *pageInformation,
                                        NSArray *users))success
                         error:(void(^)(QBResponse *response))error;

/** 取得當前使用者所有的對話 */
+ (void)apiDialogsForPageWithLimit:(NSInteger)limit
                              skip:(NSInteger)skip
                           success:(void(^)(QBResponse *response,
                                            NSArray *dialogObjects,
                                            NSSet *dialogsUsersIDs,
                                            QBResponsePage *page))success
                             error:(void(^)(QBResponse *response))error;

/** 創建一個新的對話 */
+ (void)apiCreateDialogWithChatDialog:(QBChatDialog *)dialog
                              success:(void(^)(QBResponse *response, QBChatDialog *createdDialog))success
                                error:(void(^)(QBResponse *response))error;

/** 連線到 QuickBlox 伺服器 */
+ (void)connectToChatCompletion:(void(^)(NSError * _Nullable error))completion;

@end
