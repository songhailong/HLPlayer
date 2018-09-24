//
//  HLPlayer.h
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#ifndef HLPlayer_h
#define HLPlayer_h

// 监听TableView的contentOffset
#define kZFPlayerViewContentOffset          @"contentOffset"
// player的单例
#define ZFPlayerShared                      [HLBrightnessView sharedBrightnessView]

// 屏幕的宽
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

// 颜色值RGB
#define HLColor(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

// 图片路径
#define ZFPlayerSrcName(file)               [@"HLPlayer.bundle" stringByAppendingPathComponent:file]

#define ZFPlayerFrameworkSrcName(file)      [@"Frameworks/HLPlayer.framework/HLPlayer.bundle" stringByAppendingPathComponent:file]

#define ZFPlayerImage(file)                 [UIImage imageNamed:ZFPlayerSrcName(file)] ? :[UIImage imageNamed:ZFPlayerFrameworkSrcName(file)]


#import "HLPlayerView.h"
#import "HLPlayerControlView.h"
#import "HLBrightnessView.h"
#endif /* HLPlayer_h */
