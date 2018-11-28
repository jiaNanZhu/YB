//
//  ZJNServiceChargeView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNServiceChargeView.h"

@implementation ZJNServiceChargeView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(AdFloat(58));
            make.centerY.equalTo(self);
        }];
        
        [self addSubview:self.middleLabel];
        [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLabel.mas_right).offset(AdFloat(8));
            make.centerY.equalTo(self.leftLabel);
        }];
        
        [self addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.middleLabel.mas_right).offset(AdFloat(8));
            make.centerY.equalTo(self.leftLabel);
        }];
    }
    return self;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = [UIColor hex:@"444444"];
        _leftLabel.font = SetFont(AdFloat(28));
        _leftLabel.text = @"支付平台手续费：0.6%";
    }
    return _leftLabel;
}

-(UILabel *)middleLabel{
    if (!_middleLabel) {
        _middleLabel = [[UILabel alloc]init];
        _middleLabel.textColor = [UIColor colorWithRed:82/255.0 green:153/255.0 blue:245/255.0 alpha:1];
        _middleLabel.font = SetFont(AdFloat(28));
        _middleLabel.text = @"（4）";
    }
    return _middleLabel;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = [UIColor hex:@"444444"];
        _rightLabel.font = SetFont(AdFloat(28));
        _rightLabel.text = @"元";
    }
    return _rightLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
