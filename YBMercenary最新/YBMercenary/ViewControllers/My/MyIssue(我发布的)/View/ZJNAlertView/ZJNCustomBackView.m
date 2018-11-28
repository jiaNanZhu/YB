//
//  ZJNCustomBackView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNCustomBackView.h"

#import "ZJNSliderView.h"
@interface ZJNCustomBackView()

@property (nonatomic ,strong)ZJNSliderView *sliderView;
@end
@implementation ZJNCustomBackView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.firstChargeView];
        [self.firstChargeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(AdFloat(60));
        }];
        
        [self addSubview:self.secondChargeView];
        [self.secondChargeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.firstChargeView);
            make.top.equalTo(self.firstChargeView.mas_bottom);
        }];
        
        [self addSubview:self.firstCutOffView];
        [self.firstCutOffView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.firstChargeView);
            make.top.equalTo(self.secondChargeView.mas_bottom);
        }];
        
        [self addSubview:self.secondCutOffView];
        [self.secondCutOffView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.firstChargeView);
            make.top.equalTo(self.firstCutOffView.mas_bottom);
        }];
        
        [self addSubview:self.sliderView];
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.firstChargeView);
            make.top.equalTo(self.secondCutOffView.mas_bottom).offset(AdFloat(40));
        }];
    }
    return self;
}

-(ZJNServiceChargeView *)firstChargeView{
    if (!_firstChargeView) {
        _firstChargeView = [[ZJNServiceChargeView alloc]init];
        _firstChargeView.leftLabel.text = @"支付平台手续费：0.6%";
    }
    return _firstChargeView;
}

-(ZJNServiceChargeView *)secondChargeView{
    if (!_secondChargeView) {
        _secondChargeView = [[ZJNServiceChargeView alloc]init];
        _secondChargeView.leftLabel.text = @"平台手续费：4.4%";
    }
    return _secondChargeView;
}

-(ZJNCutOffView *)firstCutOffView{
    if (!_firstCutOffView) {
        _firstCutOffView = [[ZJNCutOffView alloc]init];
        _firstCutOffView.leftLabel.text = @"发布人：";
        [_firstCutOffView.middleLabel addTarget:self action:@selector(fabuTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _firstCutOffView;
}

-(ZJNCutOffView *)secondCutOffView{
    if (!_secondCutOffView) {
        _secondCutOffView = [[ZJNCutOffView alloc]init];
        _secondCutOffView.leftLabel.text = @"接受任务者：";
        [_secondCutOffView.middleLabel addTarget:self action:@selector(jieshouTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _secondCutOffView;
}

-(ZJNSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[ZJNSliderView alloc]init];
        __weak typeof(self) weakSelf = self;
        _sliderView.sliderViewBlock = ^(CGFloat value) {
            CGFloat money = [weakSelf.model.pay_amount floatValue];
            CGFloat zfService =  [weakSelf roundFloat:0.006 * money];
            CGFloat allBackMoney = [weakSelf roundFloat:money - zfService];//可以返回的总金额
            CGFloat fbMoney = value;//需返回给发布者的金额
            //滑杆左边为返还给发布人的金额，默认为0；右边为给接单人的金额，默认可返回的总金额
            CGFloat jdAllMoney = [weakSelf roundFloat:allBackMoney-value];//需给接单人的总金额;
            CGFloat ptService = [weakSelf roundFloat:jdAllMoney * 0.044];//平台手续费
            CGFloat jdMoney = [weakSelf roundFloat:jdAllMoney-ptService];//接单人得到的最终金额;
            weakSelf.firstChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",zfService];
            if (jdAllMoney<0.01) {
                weakSelf.secondChargeView.middleLabel.text = @" 0.00 ";
                weakSelf.secondCutOffView.middleLabel.text = @" 0.00 ";
            }else{
                weakSelf.secondChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",ptService];
                weakSelf.secondCutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",jdMoney];
            }
            weakSelf.firstCutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",fbMoney];
            
        };
    }
    return _sliderView;
}
-(void)fabuTextFieldValueChanged:(UITextField *)textField{
    NSLog(@"会执行几次");
    CGFloat money = [self.model.pay_amount floatValue];
    CGFloat zfService = [self roundFloat:0.006 * money];
    CGFloat allBackMoney = [self roundFloat:money - zfService];
    
    CGFloat tfMoney = [textField.text floatValue];
    if (tfMoney >allBackMoney) {
        [DWBToast showCenterWithText:@"金额超过最大值"];
        textField.text = @"0.00";
    }
    CGFloat fbMoney = [textField.text floatValue];
    //滑杆左边为返还给发布人的金额，默认为0；右边为给接单人的金额，默认可返回的总金额
    CGFloat jdAllMoney = [self roundFloat:allBackMoney-fbMoney];//需给接单人的总金额;
    CGFloat ptService = [self roundFloat:jdAllMoney * 0.044];//平台手续费
    CGFloat jdMoney = [self roundFloat:jdAllMoney-ptService];//接单人得到的最终金额;
    self.firstChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",zfService];
    self.secondChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",ptService];
//    self.firstCutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",fbMoney];
    self.secondCutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",jdMoney];
    self.sliderView.slider.value = tfMoney;
}
-(void)jieshouTextFieldValueChanged:(UITextField *)textField{
    CGFloat money = [self.model.pay_amount floatValue];
    CGFloat zfService = [self roundFloat:0.006 * money];
    CGFloat allBackMoney = [self roundFloat:money - zfService];
    
    CGFloat jsMoney = [textField.text floatValue];
    if (jsMoney >allBackMoney) {
        [DWBToast showCenterWithText:@"金额超过最大值"];
        textField.text = [NSString stringWithFormat:@"%.2f",allBackMoney];
    }else if (textField.text.length == 0){
        textField.text = @"0.00";
    }
    CGFloat jieshouMoney = [textField.text floatValue];//接单人扣除平台手续费后到手的实际费用，平台手续费和发布者得到的金额 需要推算出来
    
    //滑杆左边为返还给发布人的金额，默认为0；右边为给接单人的金额，默认可返回的总金额
    CGFloat jdAllMoney = [self roundFloat:jieshouMoney / 0.956];//需给接单人的总金额;
    CGFloat ptService = [self roundFloat:jdAllMoney * 0.044];//平台手续费
    CGFloat fbMoney = [self roundFloat:allBackMoney-ptService-jieshouMoney];//接单人得到的最终金额;
    self.firstChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",zfService];
    self.secondChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",ptService];
    self.firstCutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",fbMoney];
    self.sliderView.slider.value = fbMoney;
}
-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    CGFloat money = [model.pay_amount floatValue];
    CGFloat zfService = 0.006 * money;
    CGFloat allBackMoney = money - zfService;//可以返回的总金额
    //滑杆左边为返还给发布人的金额，默认为0；右边为给接单人的金额，默认可返回的总金额
    CGFloat ptService = allBackMoney * 0.044;//平台手续费
    self.firstChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",zfService];
    self.secondChargeView.middleLabel.text = [NSString stringWithFormat:@"（%.2f）",ptService];
    self.firstCutOffView.leftLabel.text = [NSString stringWithFormat:@"发布人：%@",self.model.fabu_name];
    self.firstCutOffView.middleLabel.text = @"0.00";
    self.secondCutOffView.middleLabel.text = [NSString stringWithFormat:@"%.2f",allBackMoney-ptService];
    self.sliderView.slider.minimumValue = 0.00;
    self.sliderView.slider.maximumValue = allBackMoney;
    
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
