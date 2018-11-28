//
//  ZJNSignUpBottomView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/19.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSignUpBottomView.h"
@interface ZJNSignUpBottomView()

@end
@implementation ZJNSignUpBottomView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *rightImgV = [[UIImageView alloc]init];
        rightImgV.image = [UIImage imageNamed:@"背景"];
        [self addSubview:rightImgV];
        [rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.width.mas_equalTo(kScreenWidth/2.0);
        }];
        
        [self addSubview:self.collectBtn];
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.width.mas_equalTo(kScreenWidth/4.0);
            make.height.mas_equalTo(49);
        }];
        
        [self addSubview:self.complainBtn];
        [self.complainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.collectBtn.mas_right);
            make.top.equalTo(self);
            make.size.equalTo(self.collectBtn);
        }];
        
        [self addSubview:self.stateBtn];
        [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.left.equalTo(self.complainBtn.mas_right);
            make.height.equalTo(self.complainBtn);
        }];
    }
    return self;
}

-(UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [F_UI creatBtnWithTager:self title:@"收藏" font:15 image:[UIImage imageNamed:@"collect_no"] backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(collectMethod:)];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_yes"] forState:UIControlStateSelected];
        [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
        [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, Width(8))];
        [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, Width(8), 0, 0)];
    }
    return _collectBtn;
}
-(UIButton *)complainBtn{
    if (!_complainBtn) {
        _complainBtn = [F_UI creatBtnWithTager:self title:@"投诉" font:15 image:[UIImage imageNamed:@"投诉"] backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(complainMethod:)];
        [_complainBtn setImageEdgeInsets:UIEdgeInsetsMake(Width(2), 0, 0, Width(8))];
        [_complainBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, Width(8), 0, 0)];
    }
    return _complainBtn;
}
-(UIButton *)stateBtn{
    if (!_stateBtn) {
        _stateBtn = [F_UI creatBtnWithTager:self title:@"我要报名" font:15 image:nil backImage:nil color:[UIColor clearColor] textColor:[UIColor whiteColor] cornerRadius:0 action:@selector(stateMethod:)];
        [_stateBtn setTitle:@"已报名" forState:UIControlStateSelected];
    }
    return _stateBtn;
}

-(void)collectMethod:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomCollecBtnClick)]) {
        [self.delegate bottomCollecBtnClick];
    }
}
-(void)complainMethod:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomComplainBtnClick)]) {
        [self.delegate bottomComplainBtnClick];
    }
}
-(void)stateMethod:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomStateBtnClick)]) {
        [self.delegate bottomStateBtnClick];
    }
}

-(void)setType:(NSString *)type{
    _type = type;
    if ([self.type isEqualToString:@"0"]) {
        self.stateBtn.userInteractionEnabled = NO;
        [self.stateBtn setTitle:@"审核中" forState:UIControlStateNormal];
    }else if ([self.type isEqualToString:@"1"]){
        
    }else if ([self.type isEqualToString:@"2"]){
        self.stateBtn.userInteractionEnabled = NO;
        [self.stateBtn setTitle:@"已被领取" forState:UIControlStateNormal];
    }else if ([self.type isEqualToString:@"3"]){
        
    }else if ([self.type isEqualToString:@"4"]){
        self.stateBtn.userInteractionEnabled = NO;
        [self.stateBtn setTitle:@"已下架" forState:UIControlStateNormal];
    }else if ([self.type isEqualToString:@"5"]){
        self.stateBtn.userInteractionEnabled = NO;
        [self.stateBtn setTitle:@"审核未通过" forState:UIControlStateNormal];
    }else if ([self.type isEqualToString:@"6"]){
        
    }else if ([self.type isEqualToString:@"7"]){
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
