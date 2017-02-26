//
//  DrawViewController.m
//  LoveBird
//
//  Created by User on 2016/12/29.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"
#import "HandleImageView.h"
@interface DrawViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,handleImageViewDelegate>
//使用UIImagePickerController   需有<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//這兩個協議
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end
//屬性誰的東西,應該在誰的裡面去寫
@implementation DrawViewController

//清空
- (IBAction)clear:(id)sender {
    [self.drawView clear];
}

//取消
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}

//橡皮擦
- (IBAction)erase:(id)sender {
    [self.drawView erase];
    
}
//設置線的寬度
- (IBAction)setLineWith:(UISlider *)sender {
    [self.drawView setLineWith:sender.value];
}


//設置線的顏色
- (IBAction)setLineColor:(UIButton *)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}

//照片
- (IBAction)photo:(id)sender {
//從系統相簿中選一張照片
    UIImagePickerController *pickerVC= [[UIImagePickerController alloc]init];//彈出系統相簿
    
   
    pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVC.delegate= self;
    
     [self presentViewController:pickerVC animated:YES completion:nil];//model出系統相簿
    
}

//當選擇某一照片結束時會調用下面這個方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    UIImage*image= info[UIImagePickerControllerOriginalImage];
//    NSData *data= UIImageJPEGRepresentation(image, 1);
    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:@"/Users/user/Desktop/LoveBird/LoveBird/畫/photo.jpg" atomically:YES];
    [data writeToFile:@"/Users/user/Desktop/LoveBird/LoveBird/畫/photo.png" atomically:YES];

    HandleImageView * handleV =[[HandleImageView alloc]init];
    handleV.backgroundColor =[UIColor clearColor];
    handleV.frame = self.drawView.frame;
    handleV.image= image;
    handleV.delegate =self;
    
    [self.view addSubview:handleV];
//   //以下為將照片生成一個imageView 蓋到imageView上面 顯示出來
//    UIImageView *imageV=[[UIImageView alloc]initWithFrame:self.drawView.frame];
//    imageV.image=image;
//    imageV.userInteractionEnabled= YES;  //開啟跟用戶交互的方法
//    [self.view addSubview:imageV];
//
//    
//    //添加手勢
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];//添加手勢
//    [imageV addGestureRecognizer:pan];
//    
//    [self.view addSubview:imageV];
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
//    [imageV addGestureRecognizer:pinch];
//    
//    UILongPressGestureRecognizer *longP =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longP:)];
//    [imageV addGestureRecognizer:longP];
    
//    self.drawView.image = image;

    [self dismissViewControllerAnimated:YES completion:nil];//取消彈出系統相冊 就可以把照片放到view上畫畫
}
-(void)handleImageView:(HandleImageView *)handleimageView  newImage:(UIImage *)newImage{
    
    self.drawView.image = newImage;
    
}

////方法  拖動手勢
-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y); //panview 就是pan所在的imageVIew
    
    [pan setTranslation:CGPointZero inView:pan.view];//回復位置
}

//方法   縮放手勢
-(void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale,pinch.scale);
    
    [pinch setScale:1];
}

//方法  長按縮放手勢
-(void)longP:(UILongPressGestureRecognizer *)longP{
        if (longP.state==UIGestureRecognizerStateBegan) {
            //先讓照片閃一下  把照片會至到畫板裡
            [UIView animateWithDuration:0.5 animations:^{longP.view.alpha= 0;
            }completion:^(BOOL finished){
                [UIView animateWithDuration:0.5 animations:^{longP.view.alpha=1;
                }completion:^(BOOL finished){
                    
                    // 把照片匯至到畫板中
                    UIGraphicsBeginImageContextWithOptions(longP.view.bounds.size, NO, 0);
                    CGContextRef ctx = UIGraphicsGetCurrentContext();
                    [longP.view.layer  renderInContext:ctx];
                    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    self.drawView.image= newImage;
                    [longP.view removeFromSuperview];
                    
                    
                }];
            }];
    
        }
    
}



















//保存
- (IBAction)save:(id)sender {  //保繪製的東西放到系統相簿中
    
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0); //開啟一個位置塗上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();//把畫板上的內容渲染到上下文當中
    [self.drawView.layer renderInContext:ctx];
    
    UIImage * newImgae= UIGraphicsGetImageFromCurrentImageContext(); //從上下文當中取一招圖片
    
    UIGraphicsEndPDFContext(); //關閉上下文
    
    UIImageWriteToSavedPhotosAlbum(newImgae,self,@selector(image:didFinishSavingWithError:contextInfo:),nil );//把圖片存到系統相冊中  PS.＠selector 裡面的方法不可以亂寫必需是image:didFinishSavingWithError:contextInfo:
   
    
    
}

//保存完畢時調用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"success");
            [self.navigationController popViewControllerAnimated:YES];
    
}

//
//-(void)saveSuccess{
//    NSLog(@"success");

    
//}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - UI Init
- (void)initUI{
    [self setupNavigationItem];
}

- (void)setupNavigationItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"  " style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
}

- (void)rightBarButtonClick{
    NSLog(@"123");
}

@end
