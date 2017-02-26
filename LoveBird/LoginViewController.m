//
//  LoginViewController.m
//  LoveBird
//

//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "LoginViewController.h"
#import "QuickbloxManager.h"
#import "MBProgressHUD+Henry.h"
#import "AlertController.h"
#import "LoginManager.h"

//@import Firebase;               //firebase
//@import FirebaseDatabase;  //firebase
@interface LoginViewController ()<UITextFieldDelegate>{
NSMutableDictionary *postDict;
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *accounttext;
@property (weak, nonatomic) IBOutlet UITextField *passwordtext;
//@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation LoginViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(dismissKeyboard)];
    //縮鍵盤
    
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];   //縮鍵盤
}


#pragma mark - UI Init
- (void)initUI{
    [self setupLoginButton];
}

- (void)setupLoginButton{
    [self.loginButton.layer setCornerRadius:5.0];
    [self.loginButton.layer setMasksToBounds:YES];
}


#pragma mark - Event Handler

- (IBAction)loginButtonClick {
   
    [self loginWithLoginId:self.accounttext.text password:self.passwordtext.text];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


#pragma mark - API
- (void)loginWithLoginId:(NSString *)loginId password:(NSString *)password {
    
    [MBProgressHUD showLoading:@"登入中"];
    [QuickbloxManager apiLoginWithUserLogin:loginId password:password success:^(QBResponse *response, QBUUser *user) {
        [[LoginManager shareManager] setUser:user];
        [[QBSession currentSession] currentUser].password = self.passwordtext.text;
        [MBProgressHUD hideHUD];
        [self goMain];
    } error:^(QBResponse *response) {
        [MBProgressHUD hideHUD];
        [self showErrorAlertMessage];
    }];
}

#pragma mark - Class Medthod
- (void)goMain{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showErrorAlertMessage{
    AlertController *alertMessage = [[AlertController alloc]init];
    NSDictionary *dict = @{alertTitle:@"登入失敗!",
                           alertBtnOK:@"確定"};
    [alertMessage showErrorMessageWithTitle:dict target:self okAction:^{
        
    }];
}
@end
