//
//  ZJNBankCardtableFootView.m
//  YBMercenary
//
//  Created by JW on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNBankCardtableFootView.h"

@implementation ZJNBankCardtableFootView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self  setUI];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self  setUI];
    }
    
    return self;
}
-(UIButton *)btn
{
    if (!_btn) {
        _btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor=[UIColor whiteColor];
        _btn.clipsToBounds=YES;
        _btn.layer.cornerRadius=5;
        [_btn setTitle:@"+  添加银行卡" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn;
    
}
-(void)setUI
{
    
    [self addSubview:self.btn];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top).offset(AdFloat(50*2));
        make.left.equalTo(self.mas_left).offset(AdFloat(15*2));
        make.right.equalTo(self.mas_right).offset(-AdFloat(15*2));
        
        make.height.mas_equalTo(AdFloat(60*2));
    }];
}
-(void)click:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(addcard)]) {
        [self.delegate addcard];
    }
}
@end
