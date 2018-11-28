//
//  ZJNEvaluateView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNEvaluateView.h"
@interface ZJNEvaluateView()
@property(nonatomic, assign)NSInteger stars;
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UILabel *topLabel;
@property(nonatomic, strong)UIView *lineV;
@property(nonatomic, strong)UIButton *okButton;
@end

@implementation ZJNEvaluateView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _stars = 1;
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AdFloat(570), AdFloat(364)));
        }];
        
        [self.bgView addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.bgView);
            make.height.mas_equalTo(AdFloat(100));
        }];
        [self.bgView addSubview:self.lineV];
        [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLabel.mas_bottom);
            make.left.right.equalTo(self.bgView);
            make.height.mas_equalTo(1);
        }];
        
        CGFloat width = AdFloat(318)/5.0;
        UIButton *signBtn;
        for (int i =0; i <5; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.highlighted = NO;
            button.tag = 10+i;
            [button addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:button];
            if (i == 0) {
                [button setBackgroundImage:SetImage(@"Star1") forState:UIControlStateNormal];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.bgView).offset(AdFloat(70));
                    make.top.equalTo(self.lineV.mas_bottom).offset(AdFloat(48));
                    make.size.mas_equalTo(CGSizeMake(width, width));
                }];
                signBtn = button;
            }else{
                [button setBackgroundImage:SetImage(@"Star2") forState:UIControlStateNormal];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(signBtn.mas_right).offset(AdFloat(28));
                    make.top.equalTo(signBtn);
                    make.size.equalTo(signBtn);
                }];
                signBtn = button;
            }
        }
        [self.bgView addSubview:self.okButton];
        [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(AdFloat(70));
            make.right.equalTo(self.bgView).offset(-AdFloat(70));
            make.bottom.equalTo(self.bgView).offset(-AdFloat(20));
            make.height.mas_equalTo(AdFloat(80));
        }];
    }
    return self;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textColor = [UIColor hex:@"444444"];
        _topLabel.text = @"评价";
        _topLabel.font = SetFont(AdFloat(32));
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}
-(UIView *)lineV{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = [UIColor hex:@"f5f5f5"];
    }
    return _lineV;
}
-(UIButton *)okButton{
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.backgroundColor = [UIColor hex:@"0386FF"];
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okButton.titleLabel.font = SetFont(AdFloat(32));
        [_okButton addTarget:self action:@selector(ovButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}
-(void)starButtonClick:(UIButton *)button{
    self.stars = button.tag-9;
    for (int i =0; i <5; i ++) {
        UIButton *btn = (UIButton *)[self.bgView viewWithTag:10+i];
        NSLog(@"%ld",(long)button.tag);
        if (btn.tag<=button.tag) {
            [btn setBackgroundImage:SetImage(@"Star1") forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:SetImage(@"Star2") forState:UIControlStateNormal];
        }
    }
}
#pragma mark-确认
-(void)ovButtonClick{
    if (self.evaluteStarBlock) {
        self.evaluteStarBlock(self.stars);
    }
    [self removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    point = [self.bgView.layer convertPoint:point fromLayer:self.layer];
    if (![self.bgView.layer containsPoint:point]) {
        [self removeFromSuperview];
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
