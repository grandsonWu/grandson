//
//  QuickbloxManager.m
//  ChatRoom
//


#import "QuickbloxManager.h"
#import "LoginManager.h"

NSString * const kUserId = @"user_id";
NSString * const kUserName = @"user_name";
NSString * const kUserEmail = @"user_email";
NSString * const kUserPassword = @"user_password";

@implementation QuickbloxManager

/** 註冊一個使用者 */
+ (void)apiRegisterUserWithParam:(NSDictionary *)param
                   success:(void (^)(QBResponse *, QBUUser *))success
                     error:(void (^)(QBResponse *))error{
    
    NSString *userId = param[kUserId];
    NSString *userName = param[kUserName];
    NSString *userEmail = param[kUserEmail];
    NSString *userPassword = param[kUserPassword];
    NSString *userPhone = param[kUserId];
    
    QBUUser *user = [QBUUser user];
    user.login = userId;
    user.fullName = userName;
    user.password = userPassword;
    user.email = userEmail;
    user.phone = userPhone;
    [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
        success(response,user);
    } errorBlock:^(QBResponse *response) {
        error(response);
    }];
}

/** 使用者login登入 */
+ (void)apiLoginWithUserLogin:(NSString *)login
                  password:(NSString *)password
                   success:(void (^)(QBResponse *, QBUUser *))success
                     error:(void (^)(QBResponse *))error{
    
    [QBRequest logInWithUserLogin:login
                         password:password
    successBlock:^(QBResponse * _Nonnull response, QBUUser * _Nullable user) {
        success(response,user);
    } errorBlock:^(QBResponse * _Nonnull response) {
        error(response);
    }];
}

/** 使用者email登入 */
+ (void)apiLoginWithUserEmail:(NSString *)email
                     password:(NSString *)password
                      success:(void (^)(QBResponse *, QBUUser *))success
                        error:(void (^)(QBResponse *))error{
    
    [QBRequest logInWithUserEmail:email
                         password:password
    successBlock:^(QBResponse * _Nonnull response, QBUUser * _Nullable user) {
        success(response,user);
    } errorBlock:^(QBResponse * _Nonnull response) {
        error(response);
    }];
    
}

/** 取得使用者列表 */
+ (void)apiGetUsersWithPageFrom:(NSInteger)from
                             to:(NSInteger)to
                        success:(void (^)(QBResponse *, QBGeneralResponsePage *, NSArray *))success
                          error:(void (^)(QBResponse *))error{
    
    QBGeneralResponsePage *page = [QBGeneralResponsePage responsePageWithCurrentPage:from perPage:to];
    [QBRequest usersForPage:page
    successBlock:^(QBResponse * _Nonnull response, QBGeneralResponsePage * _Nullable page, NSArray<QBUUser *> * _Nullable users) {
        success(response,page,users);
    } errorBlock:^(QBResponse * _Nonnull response) {
        error(response);
    }];
}

/** 取得當前使用者所有的對話 */
+ (void)apiDialogsForPageWithLimit:(NSInteger)limit skip:(NSInteger)skip success:(void (^)(QBResponse *, NSArray *, NSSet *, QBResponsePage *))success error:(void (^)(QBResponse *))error{
    
    QBResponsePage *page = [QBResponsePage responsePageWithLimit:limit skip:skip];
    [QBRequest dialogsForPage:page extendedRequest:nil successBlock:^(QBResponse * _Nonnull response, NSArray<QBChatDialog *> * _Nullable dialogObjects, NSSet<NSNumber *> * _Nullable dialogsUsersIDs, QBResponsePage * _Nullable page) {
        success(response,dialogObjects,dialogsUsersIDs,page);
        
    } errorBlock:^(QBResponse * _Nonnull response) {
        error(response);
    }];
}

/** 創建一個新的對話 */
+ (void)apiCreateDialogWithChatDialog:(QBChatDialog *)dialog success:(void (^)(QBResponse *, QBChatDialog *))success error:(void (^)(QBResponse *))error{
    
    [QBRequest createDialog:dialog successBlock:^(QBResponse * _Nonnull response, QBChatDialog * _Nullable createdDialog) {
        success(response,createdDialog);
    } errorBlock:^(QBResponse * _Nonnull response) {
        error(response);
    }];
}

/** 連線到 QuickBlox 伺服器 */
+ (void)connectToChatCompletion:(void (^)(NSError * _Nullable))completion{
    QBUUser *user = [QBUUser user];
    user.ID = [[QBSession currentSession] currentUser].ID;
    user.password = [[QBSession currentSession] currentUser].password;
    [QBSettings setAutoReconnectEnabled:YES];
    // connect to Chat
    [[QBChat instance] connectWithUser:user completion:^(NSError * _Nullable error) {
        completion(error);
    }];
}

@end
