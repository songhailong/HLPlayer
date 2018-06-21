//
//  HLPlayerView.m
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "HLPlayerView.h"
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>
#import "HLPlayer.h"
#import "HLPlayerPlaceholderView.h"
static const CGFloat ZFPlayerAnimationTimeInterval             = 7.0f;
static const CGFloat ZFPlayerControlBarAutoFadeOutTimeInterval = 0.35f;
// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved, // 横向移动
    PanDirectionVerticalMoved    // 纵向移动
};

// 播放器的几种状态
typedef NS_ENUM(NSInteger, ZFPlayerState) {
    ZFPlayerStateFailed,     // 播放失败
    ZFPlayerStateBuffering,  // 缓冲中
    ZFPlayerStatePlaying,    // 播放中
    ZFPlayerStateStopped,    // 停止播放
    ZFPlayerStatePause,       // 暂停播放
    ZFPlayerStateFirst       //首次播放
};
@interface HLPlayerView()<UIGestureRecognizerDelegate,UIAlertViewDelegate,HLPlayerControlDelegat>
/**是用来提供视频的缩略图或预览视频的帧的类*/
@property (nonatomic, strong) AVAssetImageGenerator  *imageGenerator;
/** 播放属性 */
@property (nonatomic, strong) AVPlayer               *player;
@property (nonatomic, strong) AVPlayerItem           *playerItem;
@property (nonatomic, strong) AVURLAsset             *urlAsset;

/** playerLayer */
@property (nonatomic, strong) AVPlayerLayer          *playerLayer;
@property (nonatomic, strong) id                     timeObserve;
/** 滑杆 */
@property (nonatomic, strong) UISlider               *volumeViewSlider;
/** 控制层View */
@property (nonatomic, strong) HLPlayerControlView    *controlView;
/** 用来保存快进的总时长 */
@property (nonatomic, assign) CGFloat                sumTime;
/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection           panDirection;
/** 播发器的几种状态 */
@property (nonatomic, assign) ZFPlayerState          state;
/** 是否为全屏 */
@property (nonatomic, assign) BOOL                   isFullScreen;
/** 是否锁定屏幕方向 */
@property (nonatomic, assign) BOOL                   isLocked;
/** 是否在调节音量*/
@property (nonatomic, assign) BOOL                   isVolume;
/** 是否显示controlView*/
@property (nonatomic, assign) BOOL                   isMaskShowing;
/** 是否被用户暂停 */
@property (nonatomic, assign) BOOL                   isPauseByUser;
/** 是否播放本地文件 */
@property (nonatomic, assign) BOOL                   isLocalVideo;
/** slider上次的值 */
@property (nonatomic, assign) CGFloat                sliderLastValue;
/** 是否再次设置URL播放视频 */
@property (nonatomic, assign) BOOL                   repeatToPlay;
/** 播放完了*/
@property (nonatomic, assign) BOOL                   playDidEnd;
/** 进入后台*/
@property (nonatomic, assign) BOOL                   didEnterBackground;
/** 是否自动播放 */
@property (nonatomic, assign) BOOL                   isAutoPlay;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

#pragma mark - UITableViewCell PlayerView

/** palyer加到tableView */
@property (nonatomic, strong) UITableView            *tableView;
/** player所在cell的indexPath */
@property (nonatomic, strong) NSIndexPath            *indexPath;
/** cell上imageView的tag */
@property (nonatomic, assign) NSInteger              cellImageViewTag;
/** ViewController中页面是否消失 */
@property (nonatomic, assign) BOOL                   viewDisappear;
/** 是否在cell上播放video */
@property (nonatomic, assign) BOOL                   isCellVideo;
/** 是否缩小视频在底部 */
@property (nonatomic, assign) BOOL                   isBottomVideo;
/** 是否切换分辨率*/
@property (nonatomic, assign) BOOL                   isChangeResolution;

/**占位视图*/
@property(nonatomic,strong)HLPlayerControlView *  placeholderView;

/**占位视图*/
@property(nonatomic,strong)UIImageView *  placeholderImageView;
/**播放次数*/
@property(nonatomic,assign)NSInteger  playeIndex;
@end
@implementation HLPlayerView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initializeThePlayer];
    }
    return self;
}
/**
 *  初始化player
 */
- (void)initializeThePlayer
{
    // 每次播放视频都解锁屏幕锁定
    [self unLockTheScreen];
}
#pragma mark********锁屏
-(void)unLockTheScreen{
    // 调用AppDelegate单例记录播放状态是否锁屏
    //ZFPlayerShared.isLockScreen       = NO;
    self.controlView.lockBtn.selected = NO;
    self.isLocked = NO;
    //[self interfaceOrientation:UIInterfaceOrientationPortrait];
}
#pragma mark - life Cycle

/**
 *  单例，用于列表cell上多个视频
 *
 *  @return ZFPlayer
 */
+ (instancetype)sharedPlayerView
{
    static HLPlayerView *playerView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerView = [[HLPlayerView alloc] init];
    });
    return playerView;
}
-(void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // cell上播放视频的话，该返回按钮为×
    if (self.isCellVideo) {
        [self.controlView.backBtn setImage:ZFPlayerImage(@"ZFPlayer_close") forState:UIControlStateNormal];
    }else {
        [self.controlView.backBtn setImage:ZFPlayerImage(@"ZFPlayer_back_full") forState:UIControlStateNormal];
    }
    
    __weak typeof(self) weakSelf = self;
    // 切换分辨率
    self.controlView.resolutionBlock = ^(UIButton *button) {
        // 记录切换分辨率的时刻
        NSInteger currentTime = (NSInteger)CMTimeGetSeconds([weakSelf.player currentTime]);
        
        NSString *videoStr = weakSelf.videoURLArray[button.tag-200];
        NSURL *videoURL = [NSURL URLWithString:videoStr];
        if ([videoURL isEqual:weakSelf.videoURL]) { return; }
        weakSelf.isChangeResolution = YES;
        // reset player
        [weakSelf resetToPlayNewURL];
        weakSelf.videoURL = videoURL;
        // 从xx秒播放
        weakSelf.seekTime = currentTime;
        // 切换完分辨率自动播放
        [weakSelf autoPlayTheVideo];
        
    };
    // 点击slider快进
    self.controlView.tapBlock = ^(CGFloat value) {
        [weakSelf pause];
        // 视频总时间长度
        CGFloat total           = (CGFloat)weakSelf.playerItem.duration.value / weakSelf.playerItem.duration.timescale;
        //计算出拖动的当前秒数
        NSInteger dragedSeconds = floorf(total * value);
        weakSelf.controlView.startBtn.selected = YES;
        //[weakSelf seekToTime:dragedSeconds completionHandler:^(BOOL finished) {}];
        
    };
    
    [self listeningRotating];
    
}
-(void)listeningRotating{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange)name:UIDeviceOrientationDidChangeNotification object:nil];
}
#pragma mark********屏幕变化
-(void)onDeviceOrientationChange{
    
}
-(void)pause{
    
}
-(void)play{
    
}
#pragma mark·推到后台
-(void)appDidEnterBackground{
    
}
#pragma mark------前台
-(void)appDidEnterPlayGround{
    
}
- (void)dealloc
{
    self.playerItem = nil;
    self.tableView = nil;
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 移除time观察者
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
}
@end
