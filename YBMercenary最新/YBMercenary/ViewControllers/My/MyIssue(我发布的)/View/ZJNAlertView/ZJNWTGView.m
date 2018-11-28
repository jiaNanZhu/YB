//
//  ZJNWTGView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//  未通过

#import "ZJNWTGView.h"
@interface ZJNWTGView()
@property (nonatomic ,strong)UITextView *textView;
@property (nonatomic ,strong)UIButton *okBtn;
@property (nonatomic ,strong)UIButton *cancelBtn;
@end
@implementation ZJNWTGView

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
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor hex:@"f5f5f5"];
    bgView.layer.borderColor = [UIColor hex:@"ededed"].CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AdFloat(30));
        make.right.equalTo(self).offset(-AdFloat(30));
        make.top.equalTo(self).offset(AdFloat(40));
        make.bottom.equalTo(self).offset(-AdFloat(130));
    }];
    
    [bgView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView).with.insets(UIEdgeInsetsMake(8, 8, 8, 8));
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
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = SetFont(AdFloat(26));
        _textView.textColor = [UIColor hex:@"666666"];
        _textView.backgroundColor = [UIColor clearColor];
        //创建一个label
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.font = SetFont(13);
        placeholderLabel.textColor = [UIColor hex:@"999999"];
        placeholderLabel.text = @"请输入未通过原因";
        [_textView addSubview:placeholderLabel];
        //最关键的一句
        [_textView setValue:placeholderLabel forKey:@"_placeholderLabel"];
    }
    return _textView;
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
    [self.superview removeFromSuperview];
    if (self.wtgInfoBlock) {
        self.wtgInfoBlock(self.textView.text);
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
