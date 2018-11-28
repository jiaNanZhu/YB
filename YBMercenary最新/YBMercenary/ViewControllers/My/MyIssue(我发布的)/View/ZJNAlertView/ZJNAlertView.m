//
//  ZJNAlertView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNAlertView.h"
//修改价格
#import "ZJNChangeMoneyView.h"
//未通过
#import "ZJNWTGView.h"
//延期处理
#import "ZJNBackOrderView.h"
//退款
#import "ZJNBackMoneyTypeView.h"
@interface ZJNAlertView()<ZJNBackMoneyTypeViewDelegate>
@property (nonatomic ,strong)ZJNChangeMoneyView *changeMoneyView;
@property (nonatomic ,strong)ZJNWTGView *wtgView;
@property (nonatomic ,strong)ZJNBackOrderView *backOrderView;
@property (nonatomic ,strong)ZJNBackMoneyTypeView *backMoneyView;
@end
@implementation ZJNAlertView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
    }
    return self;
}

-(ZJNChangeMoneyView *)changeMoneyView{
    if (!_changeMoneyView) {
        _changeMoneyView = [[ZJNChangeMoneyView alloc]init];
        __weak typeof(self)weakSelf = self;
        _changeMoneyView.changeMoneyBlock = ^(NSString * _Nonnull money) {
            ZJNAlertView *strongSelf = weakSelf;
            if (strongSelf.changeMoneyViewBlock) {
                strongSelf.changeMoneyViewBlock(money);
            }
        };
    }
    return _changeMoneyView;
}

-(ZJNWTGView *)wtgView{
    if (!_wtgView) {
        _wtgView = [[ZJNWTGView alloc]init];
        __weak typeof(self)weakSelf = self;
        _wtgView.wtgInfoBlock = ^(NSString * _Nonnull info) {
            ZJNAlertView *strongSelf = weakSelf;
            if (strongSelf.wtgViewInfoBlock) {
                strongSelf.wtgViewInfoBlock(info);
            }
        };
    }
    return _wtgView;
}

-(ZJNBackOrderView *)backOrderView{
    if (!_backOrderView) {
        _backOrderView = [[ZJNBackOrderView alloc]init];
        __weak typeof(self)weakSelf = self;
        _backOrderView.backOrderBlock = ^(NSDictionary * _Nonnull dic) {
            ZJNAlertView *strongSelf = weakSelf;
            if (strongSelf.backOrderViewBlock) {
                strongSelf.backOrderViewBlock(dic);
            }
        };
    }
    return _backOrderView;
}

-(ZJNBackMoneyTypeView *)backMoneyView{
    if (!_backMoneyView) {
        _backMoneyView = [[ZJNBackMoneyTypeView alloc]init];
        __weak typeof(self) weakSelf = self;
        _backMoneyView.okBtnBlock = ^(NSDictionary * _Nonnull dic) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(zjnAlertViewOkButtonClickWithBackMoneyDic:)]) {
                [weakSelf.delegate zjnAlertViewOkButtonClickWithBackMoneyDic:dic];
            }
        };
        
        _backMoneyView.delegate = self;
    }
    return _backMoneyView;
}
-(void)setAlertType:(ZJNAlertType)alertType{
    if (alertType == 0) {
        
        [self addSubview:self.changeMoneyView];
        [self.changeMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AdFloat(530), AdFloat(350)));
        }];
    }else if (alertType == 1){
        [self addSubview:self.wtgView];
        [self.wtgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AdFloat(530), AdFloat(430)));
        }];
    }else if (alertType == 2){
        [self addSubview:self.backOrderView];
        [self.backOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        }];
    }else{
        [self addSubview:self.backMoneyView];
        [self.backMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AdFloat(530), AdFloat(480)));
        }];
    }
}

-(void)zjnBackMoneyTypeViewTypeButtonClick:(NSInteger)type{
    if (type == 0) {
        [self.backMoneyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AdFloat(530), AdFloat(480)));
        }];
    }else{
        [self.backMoneyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(AdFloat(530), AdFloat(700)));
        }];
    }
}
-(void)zjnBackMoneyTypeViewDismiss{
    [self removeFromSuperview];
}
-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    if (self.alertType == 0) {
//        self.changeMoneyView.priceTextField.text = self.model.pay_amount;
    }
    self.backMoneyView.model = model;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
