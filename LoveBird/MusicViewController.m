//
//  MusicViewController.m
//  LoveBird
//
//  Created by User on 2016/12/15.
//  Copyright © 2016年 yu hasing. All rights reserved.
//

#import "Music.h"
#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#define kColorBarTint   [UIColor colorWithRed:50/255.0 green:160/255.0 blue:120/255.0  alpha:0.9]
//以下為列舉
typedef NS_ENUM(NSInteger,ChangeStatus) {
    ChangeStatusLast = 0, //上一首
    ChangeStatusNext,     //下一首
    ChangeStatusReplay,   //重複播放
    ChangeStatusRandom    //隨機播放
};
@interface MusicViewController (){
    BOOL playing;
    NSInteger playingIndex;

}

@property (weak, nonatomic) IBOutlet UIImageView *blackGroud;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *toTalTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *proGress;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *replayButton;
@property (weak, nonatomic) IBOutlet UIButton *randomButton;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *musicImgButton;
//data
@property (strong,nonatomic) NSMutableArray *musicArray;
//timer
@property (strong,nonatomic)NSTimer *timer;
//AVAudioPlayer
@property (strong,nonatomic) AVAudioPlayer * isplayer;
//Status
@property (assign,nonatomic)BOOL isRandom;
@property (assign,nonatomic)BOOL isReplay;


@end

@implementation MusicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParam];
    [self initUI];
    
    [self.navigationController.navigationBar setBarTintColor:kColorBarTint ];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
//    //1.加毛玻璃效果
//    UIToolbar *toolbar =[[UIToolbar alloc]init];
//    //2.設置frame
//    toolbar.frame=self.blackGroud.bounds;
//    //3.設置樣式和透明度
//    toolbar.barStyle = UIBarStyleDefault;
//    toolbar.alpha=0.85;
//    //4.加到背景圖片上
//    [self.blackGroud addSubview:toolbar];
////  
//
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    [array addObject:[UIImage imageNamed:@"images01.jpg"]];
//    [array addObject:[UIImage imageNamed:@"images02.jpg"]];
//    [array addObject:[UIImage imageNamed:@"images03.jpg"]];
//    [array addObject:[UIImage imageNamed:@"images04.jpg"]];
//    [array addObject:[UIImage imageNamed:@"images05.jpg"]];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    //載入圖片陣列
//    self.imageView.animationImages =  array;
//    //以下為10秒內播完圖片
//    self.imageView.animationDuration=10;
//    //以下為 循環次數 預設為 不段循環
//    self.imageView.animationRepeatCount=99;
//    // 開始播放
    [self.imageView startAnimating];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"image %@",self.imageView);
    [self.imageView startAnimating];
}

//當avaudiosession 中斷時或是恢復時會收到通知

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"isReplay"];
    [self removeObserver:self forKeyPath:@"isRandom"];
}

//- (IBAction)bgButton:(id)sender {
//    
//    UIPopoverPresentationController*popover;
//    UIImagePickerController*imagepicker=[UIImagePickerController new];
//    //設定相簿來源為行動裝置內的相本
//    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagepicker.delegate=self;
//    //顯示設定糢式為popover
//    imagepicker.modalPresentationStyle =UIModalPresentationPopover;
//    popover = imagepicker.popoverPresentationController;
//    //設定popover 視窗與哪一個view元件有關
//    popover.sourceView=sender;
//    //以下兩行處理popover的箭頭位置
////    popover.sourceRect = sender.bounds;
//    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    [self presentViewController:imagepicker animated:YES completion:nil];
//    
//}
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    UIImage *image =[info valueForKey:UIImagePickerControllerOriginalImage];
//    self.imageView.image=image;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - Getter

- (NSMutableArray *)musicArray{
    if (!_musicArray) {
        _musicArray = [NSMutableArray array];
        
        Music *music1 = [[Music alloc]init];
        music1.url = [NSURL URLWithString:[[NSBundle mainBundle]pathForResource:@"music1" ofType:@"mp3"]];
        music1.singerName = @"畢書盡 (Bill)";
        music1.musicName = @"轉身之後";
        music1.musicImageName = @"img1";
        music1.iconImageName = @"icon1";
        [_musicArray addObject:music1];
        
        Music *music2 = [[Music alloc]init];
        music2.url = [NSURL URLWithString:[[NSBundle mainBundle]pathForResource:@"music2" ofType:@"mp3"]];
        music2.singerName = @"陳零九 (Nine Chen)";
        music2.musicName = @"你的名字";
        music2.musicImageName = @"img2";
        music2.iconImageName = @"icon2";
        [_musicArray addObject:music2];
        
        Music *music3 = [[Music alloc]init];
        music3.url = [NSURL URLWithString:[[NSBundle mainBundle]pathForResource:@"music3" ofType:@"mp3"]];
        music3.singerName = @"Jason Derulo";
        music3.musicName = @"The Other Side";
        music3.musicImageName = @"img3";
        music3.iconImageName = @"icon3";
        [_musicArray addObject:music3];
        
        Music *music4 = [[Music alloc]init];
        music4.url = [NSURL URLWithString:[[NSBundle mainBundle]pathForResource:@"music4" ofType:@"mp3"]];
        music4.singerName = @"周杰倫 (Jay)";
        music4.musicName = @"哪裡都是你";
        music4.musicImageName = @"img4";
        music4.iconImageName = @"icon4";
        [_musicArray addObject:music4];
    }
    return _musicArray;
}

    -(NSTimer*)timer{
        if (!_timer) {
//          錯誤  _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(time) 修改前
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadProccess) userInfo:nil repeats:YES];
        }
                    
        return _timer;
        }

#pragma mark - Init Param
- (void)initParam{
    [self setupKVO];
    [self initPlayer];
}

/** 初始化播放器,載入第一首歌曲 */
- (void)initPlayer{
    Music *playMusic = [self.musicArray firstObject];
    self.isplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:playMusic.url error:nil];
}

- (void)setupKVO{
    [self addObserver:self forKeyPath:@"isReplay" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"isRandom" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - lnit UI
-(void)initUI{
    self.currentTimeLabel.text = [NSString stringWithFormat:@"--:--"];
    self.toTalTimeLabel.text = [NSString stringWithFormat:@"--:--"];
    [self setupReplayBtnImage];
    [self setupRandomBtnImage];
    [self setupImageWithIndex:0];
    [self setupIcon];
}
- (void)setupReplayBtnImage{
    [self.replayButton setBackgroundImage:[UIImage imageNamed:@"replay"] forState:UIControlStateNormal];
    [self.replayButton setBackgroundImage:[UIImage imageNamed:@"replay_click"] forState:UIControlStateSelected];
}

- (void)setupRandomBtnImage{
    [self.randomButton setBackgroundImage:[UIImage imageNamed:@"shuffle"] forState:UIControlStateNormal];
    [self.randomButton setBackgroundImage:[UIImage imageNamed:@"shuffle_click"] forState:UIControlStateSelected];
}

/** 更換音樂照片資訊 */
- (void)setupImageWithIndex:(NSInteger)index{
    Music *music = [self.musicArray objectAtIndex:index];
//    [self.musicImgButton setImage:[UIImage imageNamed:music.musicImageName]
//                         forState:UIControlStateNormal];
    [self.musicImgButton setBackgroundImage:[UIImage imageNamed:music.musicImageName]
                                   forState:UIControlStateNormal];
    self.blackGroud.image = [UIImage imageNamed:music.musicImageName];
    self.icon.image = [UIImage imageNamed:music.iconImageName];
    [self setupLabelWithIndex:index];
}

/** 更換音樂照片資訊 */
/** 更換專輯與歌手Label資訊 */
- (void)setupLabelWithIndex:(NSInteger)index{
    Music *music = [self.musicArray objectAtIndex:index];
    self.musicNameLabel.text = music.musicName;
    self.singerNameLabel.text = music.singerName;
}


/** 把演唱者頭像切成圓形 */
- (void)setupIcon{
    [self.icon.layer setCornerRadius:12.5];
    [self.icon.layer setMasksToBounds:YES];
}


#pragma mark - Event Handler
-(IBAction)playbutton{
    if (playing) {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play-button-3" ]forState:UIControlStateNormal];
         [self.isplayer stop];
         }else{
             [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
             [self.isplayer play];
             [self.timer fire];
         }
         playing = !playing;
         }

- (IBAction)changeVol:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    self.isplayer.volume = slider.value;
}

#pragma mark - Event Handler

/** 點擊播放 */
- (IBAction)playButtonClick {
    if (playing) {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play-button-3"] forState:UIControlStateNormal];
        [self.isplayer stop];
    }else{
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.isplayer play];
        [self.timer fire];
    }
    playing = !playing;
    
}

/** 上一首歌曲 */
- (IBAction)lastMusicBtnClick {
    [self  changeMusicWithChangeStatus:ChangeStatusLast];
}

/** 下一首歌曲 */
- (IBAction)nextMusicBtnClick {
    [self changeMusicWithChangeStatus:ChangeStatusNext];
}

/** 點擊重複歌曲 */
- (IBAction)replayBtnClick {
    self.isReplay = !self.isReplay;
}

/** 點擊隨機歌曲 */
- (IBAction)randomBtnClick {
    self.isRandom = !self.isRandom;
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    
    if ([keyPath isEqualToString:@"isReplay"]) {
        BOOL isReplay = [change[NSKeyValueChangeNewKey] integerValue];
        self.replayButton.selected = isReplay;
    }
    
    if ([keyPath isEqualToString:@"isRandom"]) {
        BOOL isRandom = [change[NSKeyValueChangeNewKey] integerValue];
        self.randomButton.selected = isRandom;
    }
    
}

#pragma mark - Class Medthod

/** 刷新時間與進度狀態 */
- (void)reloadProccess{
    NSTimeInterval totalMusicTime = self.isplayer.duration;
    NSTimeInterval currentMusicTime = self.isplayer.currentTime;
    
    
    int totalM = totalMusicTime / 60;
    int totalS = (int)totalMusicTime % 60;
    int currentM = currentMusicTime / 60;
    int currentS = (int)currentMusicTime % 60;
    
    //錯誤  元件拉錯了
    self.proGress.progress = currentMusicTime/totalMusicTime;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",currentM,currentS];
    self.toTalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",totalM,totalS];
    
    //秒數到了就更換歌曲或重複歌曲
    if (currentM == totalM && (totalS - currentS < 2)) {
        
        //如果重複播放沒有開啟,隨機播放有開啟,就啟用隨機播放
        if (self.isRandom && !self.isReplay) {
            [self changeMusicWithChangeStatus:ChangeStatusRandom];
            return;
        }
        
        ChangeStatus changeStatus = (self.isReplay)?ChangeStatusReplay:ChangeStatusNext;
        [self changeMusicWithChangeStatus:changeStatus];
    }
}

/** 換歌曲 */
- (void)changeMusicWithChangeStatus:(ChangeStatus)changeStatus{
    
    if (changeStatus == ChangeStatusLast){
        playingIndex--;
    }else if(changeStatus == ChangeStatusNext){
        playingIndex++;
    }else if (changeStatus == ChangeStatusRandom){
        playingIndex = random() % self.musicArray.count;
    }
    
    Music *playMusic = self.musicArray[playingIndex % self.musicArray.count];
    self.isplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:playMusic.url error:nil];
    [self setupImageWithIndex:playingIndex % self.musicArray.count];
    
    //延遲播放
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (playing) [self.isplayer play];
    });
}


@end
