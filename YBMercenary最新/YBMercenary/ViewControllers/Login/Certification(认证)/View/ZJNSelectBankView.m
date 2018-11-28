//
//  ZJNSelectBankView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSelectBankView.h"
@interface ZJNSelectBankView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *bankNameArr;
    NSString *signText;
}
@property (nonatomic ,strong)UIView   *bgView;
@property (nonatomic ,strong)UIButton *leftBtn;
@property (nonatomic ,strong)UILabel  *middleLabel;
@property (nonatomic ,strong)UIButton *rightBtn;
@property (nonatomic ,strong)UIPickerView *pickerView;
@end
@implementation ZJNSelectBankView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COlOR_R_G_B_A(0, 0, 0, 0.3);
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(AdFloat(560));
        }];
        
        [self.bgView addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(AdFloat(160), AdFloat(100)));
        }];
        
        [self.bgView addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.bgView);
            make.size.mas_equalTo(CGSizeMake(AdFloat(160), AdFloat(100)));
        }];
        
        [self.bgView addSubview:self.middleLabel];
        [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.centerY.equalTo(self.rightBtn);
            
        }];
        
        [self.bgView addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgView).with.insets(UIEdgeInsetsMake(AdFloat(100), 0, 0, 0));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor hex:@"f5f5f5"];
        [self.bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.height.mas_equalTo(1);;
            make.top.equalTo(self.bgView).offset(AdFloat(100));
        }];
        
        [self getdataFromService];
    }
    return self;
}
-(void)getdataFromService{
    [[YBRequestManager sharedYBManager] postWithUrlString:GetBank parameters:nil success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            bankNameArr = data[@"data"];
            if (bankNameArr.count>0) {
                NSDictionary *dic = bankNameArr[0];
                signText = dic[@"bankname"];
            }
            [self.pickerView reloadAllComponents];
        }else{
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor= [UIColor whiteColor];
    }
    return _bgView;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = SetFont(AdFloat(30));
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UILabel *)middleLabel{
    if (!_middleLabel) {
        _middleLabel = [[UILabel alloc]init];
        _middleLabel.textColor = [UIColor hex:@"444444"];
        _middleLabel.font = SetFont(AdFloat(30));
        _middleLabel.text = @"开户行名称";
    }
    return _middleLabel;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = SetFont(AdFloat(30));
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
#pragma mark-
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return bankNameArr.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return AdFloat(88);
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return kScreenWidth;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc]init];
    }
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = [UIColor hex:@"444444"];
    textLabel.font = SetFont(AdFloat(32));
    textLabel.textAlignment = NSTextAlignmentCenter;
    NSDictionary *dic = bankNameArr[row];
    textLabel.text = dic[@"bankname"];
    [view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    return view;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return bankNameArr[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@",bankNameArr[row]);
    NSDictionary *dic = bankNameArr[row];
    signText = dic[@"bankname"];
}
-(void)leftBtnClick{
    [self removeFromSuperview];
}
-(void)rightBtnClick{
    if (self.selectBankBlock) {
        self.selectBankBlock(signText);
    }
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
