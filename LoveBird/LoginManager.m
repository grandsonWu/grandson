//
//  LoginManager.m
//  ChatRoom
//

#import "LoginManager.h"


@interface LoginManager()

@property(nonatomic,strong)QBUUser *user;

@end

@implementation LoginManager

+ (instancetype)shareManager{
    static LoginManager *loginManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManager = [[self alloc]init];
    });
    return loginManager;
}

- (void)setUser:(QBUUser *)user{
    _user = user;
}

- (NSString *)getUserLogin{
    return _user.login;
}

- (NSString *)getUserName{
    return _user.fullName;
}
@end
