//
//  HLPlayerControlView.h
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASValueTrackingSlider;
@class HLPlayerActivity;
typedef void(^ChangeResolutionBlock)(UIButton *button);
typedef void(^SliderTapBlock)(CGFloat value);
@protocol HLPlayerControlDelegat<NSObject>
/** slider开始滑动事件*/
-(void)progressSliderTouchBegan:(ASValueTrackingSlider *)slider;
/** slider滑动中事件*/
-(void)progressSliderValueChanged:(ASValueTrackingSlider *)slider;
/** slider结束滑动事件*/
-(void)progressSliderTouchEnded:(ASValueTrackingSlider *)slider;
/**开始播放点击*/
-(void)startPlayAction:(UIButton *)playBtn;
/**返回按钮点击事件*/
-(void)backButtonAction:(UIButton *)backBtn;
/**重播*/
-(void)repeatPlay:(UIButton *)repeatBtn;
/**锁定屏幕方向点击事件*/
-(void)lockScreenAction:(UIButton *)lockScreenBtn;
/**全屏按钮点击事件*/
-(void)fullScreenAction:(UIButton *)fullScreenBtn;
/**下载*/
-(void)downloadVideo:(UIButton *)downLoadBtn;
/**中间按钮播放*/
-(void)configZFPlayer:(UIButton *)configBtn;
@end
@interface HLPlayerControlView : UIView
/** 标题 */
@property (nonatomic, strong) UILabel                 *titleLabel;
/** 开始播放按钮 */
@property (nonatomic, strong ) UIButton                *startBtn;
/** 当前播放时长label */
@property (nonatomic, strong ) UILabel                 *currentTimeLabel;
/** 视频总时长label */
@property (nonatomic, strong) UILabel                 *totalTimeLabel;
/** 缓冲进度条 */
@property (nonatomic, strong) UIProgressView          *progressView;
/** 滑杆 */
@property (nonatomic, strong) ASValueTrackingSlider   *videoSlider;
/** 全屏按钮 */
@property (nonatomic, strong) UIButton                *fullScreenBtn;
/** 锁定屏幕方向按钮 */
@property (nonatomic, strong) UIButton                *lockBtn;
/** 快进快退label */
@property (nonatomic, strong) UILabel                 *horizontalLabel;
/** 系统菊花 */
@property (nonatomic, strong) UIActivityIndicatorView *activity;

/**缓冲加载框*/
@property(nonatomic,strong)HLPlayerActivity *activityView;

/** 返回按钮*/
@property (nonatomic, strong) UIButton                *backBtn;
/** 重播按钮 */
@property (nonatomic, strong) UIButton                *repeatBtn;
/** bottomView*/
@property (nonatomic, strong) UIImageView             *bottomImageView;
/** topView */
@property (nonatomic, strong) UIImageView             *topImageView;
/** 缓存按钮 */
@property (nonatomic, strong) UIButton                *downLoadBtn;
/** 切换分辨率按钮 */
@property (nonatomic, strong) UIButton                *resolutionBtn;
/** 播放按钮 */
@property (nonatomic, strong) UIButton                *playeBtn;
/** 分辨率的名称 */
@property (nonatomic, strong) NSArray                           *resolutionArray;
/** 切换分辨率的block */
@property (nonatomic, copy  ) ChangeResolutionBlock             resolutionBlock;
/** slidertap事件Block */
@property (nonatomic, copy  ) SliderTapBlock                    tapBlock;


@property(nonatomic,assign)id<HLPlayerControlDelegat> delegate;

/** 重置ControlView */
- (void)resetControlView;
/** 切换分辨率时候调用此方法*/
- (void)resetControlViewForResolution;
/** 显示top、bottom、lockBtn*/
- (void)showControlView;
/** 隐藏top、bottom、lockBtn*/
- (void)hideControlView;
@end
