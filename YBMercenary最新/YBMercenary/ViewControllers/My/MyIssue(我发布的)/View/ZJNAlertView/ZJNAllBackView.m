//
//  ZJNAllBackView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNAllBackView.h"

@interface ZJNAllBackView()

@end
@implementation ZJNAllBackView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.chargeView];
        [self.chargeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(AdFloat(60));
        }];
        
        [self addSubview:self.cutOffView];
        [self.cutOffView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.chargeView.mas_bottom);
            make.height.mas_equalTo(AdFloat(60));
        }];
    }
    return self;
}
-(ZJNServiceChargeView *)chargeView{
    if (!_chargeView) {
        _chargeView = [[ZJNServiceChargeView alloc]init];
        _chargeView.leftLabel.text = @"支付平台手续费：0.6%";
    }
    return _chargeView;
}

-(ZJNCutOffView *)cutOffView{
    if (!_cutOffView) {
        _cutOffView = [[ZJNCutOffView alloc]init];
        _cutOffView.middleLabel.userInteractionEnabled = NO;
        _cutOffView.leftLabel.text = @"发布人：";
    }
    return _cutOffView;
}

-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    CGFloat money = [model.pay_amount floatValue];
    CGFloat zfService = 0.006 * money;
    CGFloat backMoney = money-zfService;
    self.cutOffView.leftLabel.text = [NSString stringWithFormat:@"发布人：%@",self.model.fabu_name];
    self.chargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",zfService];
    self.cutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",backMoney];
}
-(float)roundFloat:(float)price{
    
    return (floorf(price*100 + 0.5))/100;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
