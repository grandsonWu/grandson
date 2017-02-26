//
//  CameraViewController.m
//  LoveBird
//
//  Created by User on 2016/12/8.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:[UIImage imageNamed:@"images01.jpg"]];
        [array addObject:[UIImage imageNamed:@"images02.jpg"]];
        [array addObject:[UIImage imageNamed:@"images03.jpg"]];
        [array addObject:[UIImage imageNamed:@"images04.jpg"]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //載入圖片陣列
    self.imageView.animationImages =  array;
    //以下為10秒內播完圖片
    self.imageView.animationDuration=10;
    //以下為 循環次數 預設為 不段循環
    self.imageView.animationRepeatCount=99;
    // 開始播放
    [self.imageView startAnimating];
    
    
    
}
- (IBAction)camera:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController * imagePicker =[[UIImagePickerController alloc]init];
        //設定相片來源為裝置上的相機
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //設定imagePicker 的delegate為viewcontroller
        imagePicker.delegate = self;
    //開啟相機拍照介面
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage*image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //存擋
    UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil);
//關閉拍照模式
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //當使用者按下取消按鈕後關閉胎拍照程式
    [self dismissViewControllerAnimated:YES completion:nil];
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
