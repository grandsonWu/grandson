//
//  MBProgressHUD+Henry.h
//  Wing
//


#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Henry)

+ (void)showLoading:(NSString *)loadingText ToView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;

+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)showLoading:(NSString *)loadingText;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

@end
