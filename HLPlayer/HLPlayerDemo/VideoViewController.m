//
//  VideoViewController.m
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/22.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "VideoViewController.h"
#import "HLPlayerView.h"
//#import "DownloadModel.h"
#import <Masonry/Masonry.h>
@interface VideoViewController ()
@property(nonatomic,strong)HLPlayerView *playview;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf       = self;
    self.playview.placeholderImageName=@"loadinglogo";
    // 设置视频的URL
    self.playview.videoURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
    self.playview.title=@"金不换";
    self.playview.playerLayerGravity=ZFPlayerLayerGravityResizeAspect;
    self.playview.hasDownload=YES;
    self.playview.downloadBlock=^(NSString *urlStr){
        // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
        NSString *name = [urlStr lastPathComponent];
        //开始后台下载
//        DownloadModel *downloadModel = [[DownloadModel alloc]init];
//        downloadModel.showModelMssage= ^(NSString *message){
//            //显示信息
//            //[weakSelf.view toast:message];
//        };
//        [downloadModel downLoadWith:urlStr title:name defaultFormat:@".mp4"];
    };
    // 如果想从xx秒开始播放视频
    self.playview.seekTime = 15;
    
    // 是否自动播放，默认不自动播放
    [self.playview autoPlayTheVideo];
    self.playview.goBackBlock = ^{
        [weakSelf  dismissViewControllerAnimated:YES completion:nil];
    };
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    // 调用playerView的layoutSubviews方法
    [self.view addSubview:self.playview];
    CGFloat weiht=self.view.frame.size.width;
    [self.playview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(weiht);
        
    }];
    
    
    if (self.playview) { [self.playview setNeedsLayout]; }
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playview ) {
        //self.isPlaying = NO;
        [self.playview play];
    }
}
-(HLPlayerView *)playview{
    if (_playview==nil) {
        _playview=[[HLPlayerView alloc] init];
    }
    return _playview;
}
- (void)dealloc
{
    NSLog(@"%@释放了",self.class);
    [self.playview cancelAutoFadeOutControlBar];
}


@end
