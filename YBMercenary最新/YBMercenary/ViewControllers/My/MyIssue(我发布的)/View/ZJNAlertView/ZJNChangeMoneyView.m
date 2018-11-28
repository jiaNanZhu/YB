//
//  ZJNChangeMoneyView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNChangeMoneyView.h"
@interface ZJNChangeMoneyView()

@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *priceLabel;
@property (nonatomic ,strong)UIButton *okBtn;
@property (nonatomic ,strong)UIButton *cancelBtn;

@end

@implementation ZJNChangeMoneyView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(AdFloat(40));
    }];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor hex:@"f5f5f5"];
    bgView.layer.borderColor = [UIColor hex:@"ededed"].CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-AdFloat(50));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AdFloat(50));
        make.size.mas_equalTo(CGSizeMake(AdFloat(350), AdFloat(60)));
    }];
    
    [bgView addSubview:self.priceTextField];
    [self.priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView).with.insets(UIEdgeInsetsMake(0, AdFloat(16), 0, 0));

    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceTextField);
        make.right.equalTo(self.priceTextField.mas_left).offset(-AdFloat(32));
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-AdFloat(100));
        make.height.mas_equalTo(1);
    }];
    UIView *hLineV = [[UIView alloc]init];
    hLineV.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self addSubview:hLineV];
    [hLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(lineV.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
    [self addSubview:self.okBtn];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(hLineV.mas_left);
        make.bottom.equalTo(self);
    }];
    
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom);
        make.left.equalTo(hLineV.mas_right);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];

}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SetFont(AdFloat(32));
        _titleLabel.text = @"修改价格";
        _titleLabel.textColor = [UIColor hex:@"444444"];
    }
    return _titleLabel;
}
-(UITextField *)priceTextField{
    if (!_priceTextField) {
        _priceTextField = [[UITextField alloc]init];
        _priceTextField.keyboardType = UIKeyboardTypePhonePad;
        _priceTextField.font = SetFont(AdFloat(24));
        _priceTextField.placeholder = @"请输入价格";
    }
    return _priceTextField;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = SetFont(AdFloat(28));
        _priceLabel.textColor = [UIColor hex:@"666666"];
        _priceLabel.text = @"价格：";
    }
    return _priceLabel;
}
-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.titleLabel.font = SetFont(AdFloat(30));
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = SetFont(AdFloat(30));
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(void)okBtnClick{
    if (self.priceTextField.text.length == 0) {
        return;
    }
    [self.superview removeFromSuperview];
    CGFloat money = [self.priceTextField.text floatValue];
    if (self.changeMoneyBlock) {
        self.changeMoneyBlock([NSString stringWithFormat:@"%.2f",100*money]);
    }
}

-(void)cancelBtnClick{
    [self.superview removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
