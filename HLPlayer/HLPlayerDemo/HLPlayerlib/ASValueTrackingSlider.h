//
//  ASValueTrackingSlider.h
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "ASValuePopUpView.h"

@protocol ASValueTrackingSliderDelegate;

@interface ASValueTrackingSlider : UISlider

// 手动显示弹出视图，没有触摸事件。
- (void)showPopUpViewAnimated:(BOOL)animated;
// 弹出窗口将不会再次隐藏，直到你调用
- (void)hidePopUpViewAnimated:(BOOL)animated;

// setting the value of 'popUpViewColor' overrides 'popUpViewAnimatedColors' and vice versa
// the return value of 'popUpViewColor' is the currently displayed value
// this will vary if 'popUpViewAnimatedColors' is set (see below)
@property (strong, nonatomic) UIColor *popUpViewColor;

// pass an array of 2 or more UIColors to animate the color change as the slider moves
@property (strong, nonatomic) NSArray *popUpViewAnimatedColors;

// the above @property distributes the colors evenly across the slider
// to specify the exact position of colors on the slider scale, pass an NSArray of NSNumbers
- (void)setPopUpViewAnimatedColors:(NSArray *)popUpViewAnimatedColors withPositions:(NSArray *)positions;

@property (strong, nonatomic, readonly) ASValuePopUpView *popUpView;
// popUpView的拐角半径为4.0
@property (nonatomic) CGFloat popUpViewCornerRadius;

// 弹出窗口的箭头高度，默认为13.0
@property (nonatomic) CGFloat popUpViewArrowLength;
// popUpView的宽度填充因子，默认为1.15
@property (nonatomic) CGFloat popUpViewWidthPaddingFactor;
//popUpView的高度填充因子，默认值为1.1。
@property (nonatomic) CGFloat popUpViewHeightPaddingFactor;

// 更改UISlider跟踪的左侧，以匹配当前的弹出视图颜色
// 跟踪颜色alpha总是设置为1.0，即使popUpView颜色小于1.0
@property (nonatomic) BOOL autoAdjustTrackColor; // (default is YES)

// 当使用TableView或CollectionView时，只需要委托—见下图。
@property (weak, nonatomic) id<ASValueTrackingSliderDelegate> delegate;
/** 设置时间 */
- (void)setText:(NSString *)text;
/**      */
- (void)setImage:(UIImage *)image;

@end

// when embedding an ASValueTrackingSlider inside a TableView or CollectionView
// you need to ensure that the cell it resides in is brought to the front of the view hierarchy
// to prevent the popUpView from being obscured
@protocol ASValueTrackingSliderDelegate <NSObject>
- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider;

@optional
- (void)sliderWillHidePopUpView:(ASValueTrackingSlider *)slider;
- (void)sliderDidHidePopUpView:(ASValueTrackingSlider *)slider;
@end
