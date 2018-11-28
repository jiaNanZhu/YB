//
//  ZJNCutOffView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNCutOffView.h"

@implementation ZJNCutOffView
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
            make.width.mas_equalTo(AdFloat(160));
            make.height.mas_equalTo(AdFloat(40));
        }];

        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor hex:@"f5f5f5"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.middleLabel);
            make.top.equalTo(self.middleLabel.mas_bottom);
            make.height.mas_equalTo(1);
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
    }
    return _leftLabel;
}

-(UITextField *)middleLabel{
    if (!_middleLabel) {
        _middleLabel = [[UITextField alloc]init];
        _middleLabel.textColor = [UIColor colorWithRed:82/255.0 green:153/255.0 blue:245/255.0 alpha:1];
        _middleLabel.font = SetFont(AdFloat(28));
        _middleLabel.textAlignment = NSTextAlignmentCenter;
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
