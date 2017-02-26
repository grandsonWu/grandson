//
//  SecondNoteViewController.m
//  LoveBird
//
//  Created by User on 2016/12/13.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "SecondNoteViewController.h"
#import "CoreDataHelper.h"
@interface SecondNoteViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
//實作 UINavigationControllerDelegate才會有影像
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic)UIImagePickerController *imagePicker;

@end

@implementation SecondNoteViewController
{
    NSString *pickerImageFileName;
     UITapGestureRecognizer *tgr;//用于撤销键盘。
}


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = self.currentNote.content;
// self.imageView.image = self.currentNote.image;  以前是以前是存取圖片所在位置   現在改存取檔案名稱
    
    
    if(self.currentNote.imageFileName){
    NSString*home = NSHomeDirectory();
    NSString*document = [home stringByAppendingPathComponent:@"Documents"];
    NSString*photos =[document stringByAppendingPathComponent:@"photos"];
        NSString*filePath= [photos stringByAppendingPathComponent:self.currentNote.imageFileName];
        UIImage*image= [UIImage imageWithContentsOfFile:filePath];
        self.imageView.image = image;
    
    }
}

#pragma mark - Event Handler
- (IBAction)save:(id)sender {
    self.currentNote.content =self.textView.text;
    self.currentNote.updataTime=[NSDate date];
    [[CoreDataHelper sharedInstance].managedObjectContext save:nil];
//    self.currentNote.image= self.imageView.image;
    self.currentNote.imageFileName = pickerImageFileName;

    if ([self.delegate respondsToSelector:@selector(secondNoteViewControllerReloadData)]) {
        [self.delegate  secondNoteViewControllerReloadData];
        [self.navigationController popViewControllerAnimated:YES];

    
    }
    
    _textView.layer.borderColor = [[UIColor colorWithRed:215.0 / 255.0 green:215.0 / 255.0 blue:215.0 / 255.0 alpha:1] CGColor];
    _textView.layer.borderWidth = 0.6f;
    _textView.layer.cornerRadius = 6.0f;
}

- (IBAction)camera:(id)sender {
    if ( ! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
       //UIALertView error;
        return;
    }
        UIImagePickerController*imagepickercontroller=[[UIImagePickerController alloc]init];
        imagepickercontroller.delegate=self;
        imagepickercontroller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
       self.imagePicker = imagepickercontroller;
        [self presentViewController:imagepickercontroller animated:YES completion:nil];
}
//首先在viewWillAppear中注册键盘弹出关闭函数：

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector
     (keyboardDidShow:) name:UIKeyboardDidHideNotification object:nil];
    
    [super viewWillAppear:YES];
    
}
//接着在弹出键盘后调用的函数中添加点触事件，因为只有在键盘弹出之后需要监听触摸事件，键盘关闭状态时就不需要了，iOS默认触摸textView弹出键盘，如果此时还自定义一个监听事件，键盘恐怕就弹不出来了。

-(void)keyboardDidShow:(NSNotification *)notification{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    
    tapGestureRecognizer.cancelsTouchesInView = NO;
    
    [self.textView addGestureRecognizer:tapGestureRecognizer];
    
    tgr = tapGestureRecognizer;//用于撤销触摸监听。
    
}

-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    [self.textView resignFirstResponder];
    
    [self.textView removeGestureRecognizer:tgr];//撤销触摸监听，不然下次键盘弹不出。
    
}
#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 以上為imagecontroller被呼叫到時會用到的方法
    UIImageJPEGRepresentation(image, 1);
    //給1為保留
    NSData*imageData= UIImageJPEGRepresentation(image, 1);
    
    NSString*home = NSHomeDirectory();
    NSString*document = [home stringByAppendingPathComponent:@"Documents"];
    NSString*photos =[document stringByAppendingPathComponent:@"photos"];
    NSFileManager*filemManager = [NSFileManager defaultManager];
    if (![filemManager fileExistsAtPath:photos]) {
        [filemManager createDirectoryAtPath:photos withIntermediateDirectories:YES attributes:nil error:nil];   
    }
    //以上存到photots 位置
    NSUUID*uuid = [NSUUID UUID];
    NSString*imageFileName= [NSString stringWithFormat:@"%@.jpg", [uuid UUIDString]];
    
    NSString *filePath = [photos stringByAppendingPathComponent:imageFileName];
    [imageData writeToFile:filePath atomically:YES];
    pickerImageFileName= imageFileName;
    
    
   
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
         self.imageView.image= image;
    }];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self  dismissViewControllerAnimated:YES completion:nil];
}


    
- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
