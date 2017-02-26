//
//  AlertController.m
//  Wing


#import "AlertController.h"

NSString *const alertTitle = @"title";
NSString *const alertDefaultTitle = @"defaultTitle";
NSString *const alertBtnOK = @"ok";
NSString *const alertBtnCancel = @"cancel";

@implementation AlertController


- (void)showAlertMessageWithTitle:(NSDictionary *)titleDict target:(id)target okAction:(void (^)())okHandler cancelHandler:(void (^)())cancelHandler{
    NSString *alertBody = titleDict[alertTitle];
    NSString *okTitle = titleDict[alertBtnOK];
    NSString *cancelTitle = titleDict[alertBtnCancel];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertBody message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (okHandler) okHandler();
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandler) cancelHandler();
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [target presentViewController:alertController animated:YES completion:nil];
}

- (void)showTextFieldAlertMessageWithTitle:(NSDictionary *)titleDict target:(id)target okAction:(void (^)(NSString *editGroupName))okHandler cancelHandler:(void (^)())cancelHandler{
    NSString *alertBody = titleDict[alertTitle];
    NSString *okTitle = titleDict[alertBtnOK];
    NSString *defaultTitle = (titleDict[alertDefaultTitle])?titleDict[alertDefaultTitle]:@"";
    NSString *cancelTitle = titleDict[alertBtnCancel];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertBody message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultTitle;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *editGroupName = [alertController.textFields firstObject].text;
        okHandler(editGroupName);
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancelHandler();
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [target presentViewController:alertController animated:YES completion:nil];
}

- (void)showErrorMessageWithTitle:(NSDictionary *)titleDict target:(id)target okAction:(void (^)())okHandler{
    NSString *alertBody = titleDict[alertTitle];
    NSString *okTitle = titleDict[alertBtnOK];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertBody message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okHandler();
    }];
    [alertController addAction:okAction];
    [target presentViewController:alertController animated:YES completion:nil];
}

@end
