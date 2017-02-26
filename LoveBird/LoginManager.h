//
//  LoginManager.h
//  ChatRoom
//


#import <Foundation/Foundation.h>
#import <Quickblox/Quickblox.h>

@interface LoginManager : NSObject



+ (instancetype)shareManager;

- (void)setUser:(QBUUser *)user;

- (NSString *)getUserLogin;

- (NSString *)getUserName;

@end
