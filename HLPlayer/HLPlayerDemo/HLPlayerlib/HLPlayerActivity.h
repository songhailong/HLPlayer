//
//  HLPlayerActivity.h
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HLActivityType){
    HLActivityTypeUK,
    HLActivityTypeAQY,
    HLActivityTypePie
};
@interface HLPlayerActivity : UIView
@property (strong, nonatomic) UIColor *edgeColor;

@property (assign, nonatomic) HLActivityType activityType;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeThickness;

-(void)startAnimating;

-(void)stopAnimating;


/**
 *  设置小球的半径
 *
 *  @param radius 半径
 */
- (void)setBallRadius:(CGFloat)radius;

/**
 *  设置俩小球颜色
 *
 *  @param oneColor 第一个小球颜色
 *  @param twoColor 第二个小球颜色
 */
- (void)setOneBallColor:(UIColor *)oneColor twoBallColor:(UIColor *)twoColor;
/**
 *  动画时间
 */
- (void)setAnimatorDuration:(CGFloat)duration;

/**
 *  设置小球移动的轨迹半径距离
 */
- (void)setAnimatorDistance:(CGFloat)distance;

-(instancetype)initWithFrame:(CGRect)frame ActivityType:(HLActivityType)type;
@end
