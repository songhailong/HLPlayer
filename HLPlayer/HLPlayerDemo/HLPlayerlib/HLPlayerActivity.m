//
//  HLPlayerActivity.m
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//
#define DEFAULT_RADIUS 10
#define DEFAULT_DISTANCE 10.0
#define DEFAULT_DURATION 1.2
#import "HLPlayerActivity.h"
@interface HLPlayerActivity(){
    CGFloat  lineWidth;
}
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) CGFloat distance;

@property (nonatomic,strong) CAShapeLayer *oneLayer;
@property (nonatomic,strong) CAShapeLayer *twoLayer;

@property(nonatomic,strong)CAShapeLayer *indefiniteAnimatedLayer;

@property (nonatomic,assign) CGPoint centerPoint;
//刷新工具
@property(nonatomic,strong) CADisplayLink *link;
////显示圆环
@property(nonatomic,strong) CAShapeLayer *animationLayer;
//起始角度
@property(nonatomic,assign) CGFloat startAngle;
//结束角度
@property(nonatomic,assign) CGFloat endAngle;;
//当前动画进度
@property(nonatomic,assign) CGFloat progress;
@end
@implementation HLPlayerActivity
-(instancetype)initWithFrame:(CGRect)frame ActivityType:(HLActivityType)type{
    if (self == [super initWithFrame:frame]) {
        //TODO 初始化
        self.backgroundColor = [UIColor clearColor];
        if (type==HLActivityTypeUK) {
            [self initProgressBar];
        }else if(type==HLActivityTypeAQY){
            [self creatActivity];
        }else if (type==HLActivityTypePie){
            [self creatPie];
        }
        
    }
    return self;
}

-(void)creatPie{
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;
}
-(void)displayLinkAction{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}
-(void)updateAnimationLayer{
    
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    
    _animationLayer.path = path.CGPath;
}
-(CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.1/60.0f;
    }
    return 0.8/60.0f;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.centerPoint = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    
    NSLog(@"%f====%f",self.frame.size.width*0.5,self.frame.size.height*0.5);
    self.twoLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.oneLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.oneLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    
    self.twoLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
}
-(void)creatActivity{
    self.strokeColor=[UIColor greenColor];
    self.strokeThickness=60;
    
    
    CALayer *layer = self.indefiniteAnimatedLayer;
    [self.layer addSublayer:layer];
    
    CGFloat widthDiff = CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds);
    CGFloat heightDiff = CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds);
    layer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds) / 2 - widthDiff / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds) / 2 - heightDiff / 2);
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        //TODO 初始化
        self.backgroundColor = [UIColor blackColor];
        
        [self initProgressBar];
    }
    return self;
}

- (CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _oneLayer.fillColor = [UIColor redColor].CGColor;
        //_oneLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    }
    return _oneLayer;
}

- (CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _twoLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _twoLayer.fillColor = [UIColor greenColor].CGColor;
        // _twoLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    }
    return _twoLayer;
}

/**
 *  初始化进度条
 */
- (void)initProgressBar{
    
    self.duration = DEFAULT_DURATION;
    self.radius = DEFAULT_RADIUS;
    self.distance = DEFAULT_DISTANCE;
    
    self.centerPoint = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    //添加两个CAShapeLayer
    [self.layer addSublayer:self.oneLayer];
    [self.layer addSublayer:self.twoLayer];
}

#pragma mark - 实现接口
- (void)setBallRadius:(CGFloat)radius{
    self.radius = radius;
    self.oneLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    
    self.twoLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
}

- (void)setOneBallColor:(UIColor *)oneColor twoBallColor:(UIColor *)twoColor{
    self.oneLayer.fillColor = oneColor.CGColor;
    self.twoLayer.fillColor = twoColor.CGColor;
}

- (void)setAnimatorDuration:(CGFloat)duration{
    self.duration = duration;
}

- (void)setAnimatorDistance:(CGFloat)distance{
    self.distance = distance;
    if (distance > self.bounds.size.width*0.5) {
        self.distance = self.bounds.size.width*0.5;
    }
}

- (void)startAnimating{
    NSLog(@"%f--动画开始的中心点=%f",self.centerPoint.x,self.centerPoint.y);
    
    self.hidden=NO;
    [self startOneBallAnimator];
    [self startTwoBallAnimator];
}

- (void)startOneBallAnimator{
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.z"];
    transformAnimation.values = @[@1,@0,@0,@0,@1];
    
    //NSLog(@"=changduz %f",self.distance);
    //第一个小球位移动画
    CAKeyframeAnimation *oneFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x+self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x-self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    [oneFrameAnimation setPath:path];
    
    //第一个小球缩放动画
    CAKeyframeAnimation *oneScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    oneScaleAnimation.values = @[@1,@0.5,@0.25,@0.5,@1];
    
    
    //第一个小球透明动画
    CAKeyframeAnimation *oneOpacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    oneOpacityAnimation.values = @[@1,@0.5,@0.25,@0.5,@1];
    
    //组合动画
    CAAnimationGroup *oneGroup = [CAAnimationGroup animation];
    [oneGroup setAnimations:@[transformAnimation,oneFrameAnimation,oneScaleAnimation,oneOpacityAnimation]];
    oneGroup.duration = self.duration;
    oneGroup.repeatCount = HUGE;
    [self.oneLayer addAnimation:oneGroup forKey:@"oneGroup"];
}

- (void)startTwoBallAnimator{
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.z"];
    transformAnimation.values = @[@0,@0,@1,@0,@0];
    
    //第二个小球位移动画
    CAKeyframeAnimation *twoFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x-self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x+self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    [twoFrameAnimation setPath:path];
    
    //第二个小球缩放动画
    CAKeyframeAnimation *twoScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    twoScaleAnimation.values = @[@0.25,@0.5,@1,@0.5,@0.25];
    
    //第二个小球透明动画
    CAKeyframeAnimation *twoOpacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    twoOpacityAnimation.values = @[@0.25,@0.5,@1,@0.5,@0.25];
    
    //组合动画
    CAAnimationGroup *twoGroup = [CAAnimationGroup animation];
    [twoGroup setAnimations:@[transformAnimation,twoFrameAnimation,twoScaleAnimation,twoOpacityAnimation]];
    twoGroup.duration = self.duration;
    twoGroup.repeatCount = HUGE;
    [self.twoLayer addAnimation:twoGroup forKey:@"twoGroup"];
}
- (CAShapeLayer*)indefiniteAnimatedLayer {
    if(!_indefiniteAnimatedLayer) {
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:self.radius startAngle:(CGFloat) (M_PI*3/2) endAngle:(CGFloat) (M_PI/2+M_PI*5) clockwise:YES];
        
        _indefiniteAnimatedLayer = [CAShapeLayer layer];
        _indefiniteAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _indefiniteAnimatedLayer.frame = CGRectMake(0.0f, 0.0f, arcCenter.x*2, arcCenter.y*2);
        _indefiniteAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
        _indefiniteAnimatedLayer.strokeColor = self.strokeColor.CGColor;
        _indefiniteAnimatedLayer.lineWidth = self.strokeThickness;
        _indefiniteAnimatedLayer.lineCap = kCALineCapRound;
        _indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel;
        _indefiniteAnimatedLayer.path = smoothedPath.CGPath;
        
        CALayer *maskLayer = [CALayer layer];
        
        //        NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
        //        NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
        //        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        //
        //        NSString *path = [imageBundle pathForResource:@"angle-mask" ofType:@"png"];
        
        maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"angle-mask"] CGImage];
        maskLayer.frame = _indefiniteAnimatedLayer.bounds;
        _indefiniteAnimatedLayer.mask = maskLayer;
        
        NSTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = (id) 0;
        animation.toValue = @(M_PI*2);
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_indefiniteAnimatedLayer.mask addAnimation:animation forKey:@"rotate"];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.removedOnCompletion = NO;
        animationGroup.timingFunction = linearCurve;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @0.015;
        strokeStartAnimation.toValue = @0.515;
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0.485;
        strokeEndAnimation.toValue = @0.985;
        
        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        [_indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
        
    }
    return _indefiniteAnimatedLayer;
}


-(void)stopAnimating{
    NSLog(@"=========停止动画===========");
    //清空所有属性
    self.transform=CGAffineTransformIdentity;
    [self.oneLayer removeAllAnimations];
    [self.twoLayer removeAllAnimations];
    self.hidden=YES;
   // [self removeFromSuperview];
}

@end
