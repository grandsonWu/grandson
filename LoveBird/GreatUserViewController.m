//
//  GreatUserViewController.m
//  LoveBird
//
//  Created by User on 2017/1/5.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "GreatUserViewController.h"
#import "QuickbloxManager.h"
#import "MBProgressHUD+Henry.h"
#import "AlertController.h"
  

@interface GreatUserViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation GreatUserViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Event Handler
- (IBAction)registerClick {
    NSDictionary *userInfo = @{kUserId:self.phoneTextField.text,
                               kUserEmail:self.emailTextField.text,
                               kUserName:self.nameTextField.text,
                               kUserPassword:self.passwordTextField.text};
    
    [self apiRegisterUserWithParam:userInfo];
}


- (IBAction)cleanBtn:(id)sender {
    self.phoneTextField.text = @"";
    self.emailTextField.text = @"";
    self.nameTextField.text = @"";
    self.passwordTextField.text = @"";
    self.confirmPasswordTextField.text = @"";
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - API

/** 註冊一個使用者 */
- (void)apiRegisterUserWithParam:(NSDictionary *)param{
    [MBProgressHUD showLoading:@"註冊中"];
    [QuickbloxManager apiRegisterUserWithParam:param success:^(QBResponse *response, QBUUser *user) {
        [MBProgressHUD hideHUD];
        [self showSuccessAlertMessage];
    } error:^(QBResponse *response) {
        [MBProgressHUD hideHUD];
        [self showErrorAlertMessage];
    }];
}

#pragma mark - Class Medthod

- (void)showSuccessAlertMessage{
    AlertController *alertMessage = [[AlertController alloc]init];
    NSDictionary *dict = @{alertTitle:@"註冊成功!",
                           alertBtnOK:@"確定"};
    [alertMessage showErrorMessageWithTitle:dict target:self okAction:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)showErrorAlertMessage{
    AlertController *alertMessage = [[AlertController alloc]init];
    NSDictionary *dict = @{alertTitle:@"註冊失敗!",
                           alertBtnOK:@"確定"};
    [alertMessage showErrorMessageWithTitle:dict target:self okAction:^{
        
    }];
}
@end
