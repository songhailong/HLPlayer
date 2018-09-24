//
//  HLadvertisingControl.m
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/22.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "HLadvertisingControl.h"
#import <Masonry/Masonry.h>
@implementation HLadvertisingControl
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.timelength=15;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self)weakself=self;
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    [self.volumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.startBtn.mas_right).with.offset(10);
        make.bottom.greaterThanOrEqualTo(weakself.startBtn);
        make.height.greaterThanOrEqualTo(weakself.startBtn);
        make.width.greaterThanOrEqualTo(weakself.startBtn);
    }];
    [self.countdownlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    [self.fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.greaterThanOrEqualTo(weakself.startBtn);
        make.height.greaterThanOrEqualTo(weakself.startBtn);
        make.width.greaterThanOrEqualTo(weakself.startBtn);
    }];
    [self.detailsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.fullBtn.mas_left).with.offset(-10);
        make.bottom.greaterThanOrEqualTo(weakself.startBtn);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.advertisingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(5);
        make.left.equalTo(weakself.timeLable.mas_right).with.offset(0);
        make.right.mas_equalTo(10);
    }];
    self.backBtn.layer.cornerRadius=15;
    self.startBtn.layer.cornerRadius=15;
    self.fullBtn.layer.cornerRadius=15;
    self.volumeBtn.layer.cornerRadius=15;
    self.detailsBtn.layer.cornerRadius=15;
    self.timeLable.layer.cornerRadius=20;
    self.countdownlable.layer.cornerRadius=20;
    //self.startBtn.layer.cornerRadius=15;
}
#pragma mark********懒加载
-(UIButton *)backBtn{
    if (_backBtn==nil) {
        _backBtn=[[UIButton alloc] init];
        _backBtn.alpha=0.5;
        _backBtn.backgroundColor=[UIColor blackColor];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateSelected];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}
-(UIButton *)startBtn{
    if (_startBtn==nil) {
        _startBtn=[[UIButton alloc] init];
        _startBtn.alpha=0.5;
        _startBtn.backgroundColor=[UIColor blackColor];
        [_startBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateSelected];
        [self addSubview:_startBtn];
    }
    return _startBtn;
}
-(UIButton *)fullBtn{
    if (_fullBtn==nil) {
        _fullBtn=[[UIButton alloc] init];
        _fullBtn.alpha=0.5;
        _fullBtn.backgroundColor=[UIColor blackColor];
        [_fullBtn setImage:[UIImage imageNamed:@"全屏"] forState:UIControlStateNormal];
        [self addSubview:_fullBtn];
    }
    return _fullBtn;
}
-(UIButton *)volumeBtn{
    if (_volumeBtn==nil) {
        _volumeBtn=[[UIButton alloc] init];
        _volumeBtn.alpha=0.5;
        _volumeBtn.backgroundColor=[UIColor blackColor];
        [_volumeBtn setImage:[UIImage imageNamed:@"音量"] forState:UIControlStateNormal];
        [_volumeBtn setImage:[UIImage imageNamed:@"静音"] forState:UIControlStateNormal];
        [self addSubview:_volumeBtn];
    }
    return _volumeBtn;
}
-(UIButton *)detailsBtn{
    if (_detailsBtn==nil) {
        _detailsBtn=[[UIButton alloc] init];
        _detailsBtn.alpha=0.5;
        _detailsBtn.backgroundColor=[UIColor greenColor];
        _detailsBtn.titleLabel.textColor=[UIColor whiteColor];
        [self addSubview:_detailsBtn];
    }
    return _detailsBtn;
}
-(UIButton *)advertisingBtn{
    if (_advertisingBtn==nil) {
        _advertisingBtn=[[UIButton alloc] init];
        _advertisingBtn.alpha=0.5;
        _advertisingBtn.backgroundColor=[UIColor blackColor];
        [_advertisingBtn setTitle:@"会员跳广告，首月仅仅6元" forState:UIControlStateNormal];
        [self.countdownlable addSubview:_advertisingBtn];
    }
    return _advertisingBtn;
}
-(UILabel *)countdownlable{
    if (_countdownlable==nil) {
        _countdownlable=[[UILabel alloc] init];
        _countdownlable.alpha=0.5;
        _countdownlable.backgroundColor=[UIColor blackColor];
        [self addSubview:_countdownlable];
    }
    return _countdownlable;
}
-(UILabel *)timeLable{
    if (_timeLable==nil) {
        
        _timeLable=[[UILabel alloc] init];
        _timeLable.backgroundColor=[UIColor clearColor];
        _timeLable.textColor=[UIColor greenColor];
        
        [self.countdownlable addSubview:_timeLable];
    }
    return _timeLable;
}
-(void)setTimelength:(NSInteger)timelength{
    self.timeLable.text=[NSString stringWithFormat:@"%zd",timelength];
    _timelength=timelength;
}
-(void)creatTimer{
    __weak typeof(self)weakself=self;
    dispatch_queue_t queuet=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //dispatch_queue_t queuet=dispatch_get_main_queue();
    /**
     第一个参数：   DISPATCH_SOURCE_TYPE_TIMER, 表示定时器
     */
    _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queuet);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        
        self.timelength--;
        [weakself zf_setTimeLableText];
    });
    dispatch_resume(_timer);
}
-(void)zf_setTimeLableText{
    //    dispatch_async(, ^{
    //
    //    })
    if (self.timelength==0) {
        [self zf_stopTimer];
        if (_advertisingEndBlock) {
            _advertisingEndBlock();
        }
    }
    self.timeLable.text=[NSString stringWithFormat:@"%zd",self.timelength];
}
-(void)zf_stopTimer{
    dispatch_source_cancel(_timer);
    _timer=nil;
}


@end
