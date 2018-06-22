//
//  HLPlayerPlaceholderView.m
//  HLPlayerDemo
//
//  Created by 靓萌服饰靓萌服饰 on 2018/6/20.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "HLPlayerPlaceholderView.h"
#import <Masonry/Masonry.h>
@implementation HLPlayerPlaceholderView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.placeholderView];
    [self addSubview:self.textLable];
    CGFloat height=   self.bounds.size.height;
    CGFloat width=   self.bounds.size.width;
    NSLog(@"%f===%f",height,width);
    
    [self.placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.greaterThanOrEqualTo(self);
        make.centerY.greaterThanOrEqualTo(self);
        make.height.mas_equalTo(height*0.5);
        make.width.mas_equalTo(width*0.5);
    }];
    [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.greaterThanOrEqualTo(self);
        make.bottom.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    
}
-(UILabel *)textLable{
    
    if (!_textLable) {
        _textLable=[[UILabel alloc] init];
        _textLable.text=@"正在加载";
        _textLable.textColor       = [UIColor whiteColor];
        _textLable.textAlignment   = NSTextAlignmentCenter;
        _textLable.font       = [UIFont systemFontOfSize:15.0];
        _textLable.backgroundColor = [UIColor colorWithRed:69/255.0 green:66/255.0 blue:63/255.0 alpha:1];
        _textLable.textColor=[UIColor whiteColor];
        //[  placeholderView addSubview:self.placeholderImageView];
        // [_placeholderView addSubview:lable];
        CGFloat height=   self.bounds.size.height;
        CGFloat width=   self.bounds.size.width;
    }
    return _textLable;
}
-(UIImageView *)placeholderImageView{
    if (!_placeholderImageView) {
        _placeholderImageView=[[UIImageView alloc] init];
        _placeholderImageView.backgroundColor=[UIColor clearColor];
        _placeholderImageView.image=[UIImage imageNamed:@"loadinglogo"];
    }
    return _placeholderImageView;
}
@end
