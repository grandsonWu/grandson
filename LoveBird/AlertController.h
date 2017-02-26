//
//  AlertController.h
//  Wing


#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const alertTitle;
FOUNDATION_EXTERN NSString *const alertDefaultTitle;
FOUNDATION_EXTERN NSString *const alertBtnOK;
FOUNDATION_EXTERN NSString *const alertBtnCancel;

@interface AlertController : UIAlertController

- (void)showAlertMessageWithTitle:(NSDictionary *)titleDict target:(id)target okAction:(void(^)())okHandler cancelHandler:(void(^)())cancelHandler;

- (void)showTextFieldAlertMessageWithTitle:(NSDictionary *)titleDict target:(id)target okAction:(void(^)(NSString *editGroupName))okHandler cancelHandler:(void(^)())cancelHandler;


- (void)showErrorMessageWithTitle:(NSDictionary *)titleDict target:(id)target okAction:(void(^)())okHandler;
@end
