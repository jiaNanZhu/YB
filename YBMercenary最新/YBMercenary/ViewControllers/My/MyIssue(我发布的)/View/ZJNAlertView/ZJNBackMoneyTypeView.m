//
//  ZJNBackMoneyTypeView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNBackMoneyTypeView.h"
#import "ZJNAllBackView.h"
#import "ZJNCustomBackView.h"
@interface ZJNBackMoneyTypeView(){
    NSInteger type;
}
@property (nonatomic ,strong)UILabel  *titleLabel;
@property (nonatomic ,strong)UIButton *allBackBtn;
@property (nonatomic ,strong)UIButton *customBtn;
@property (nonatomic ,strong)UIButton *okBtn;
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIView   *bgView;
@property (nonatomic ,strong)ZJNAllBackView *allBackView;
@property (nonatomic ,strong)ZJNCustomBackView *customBackView;
@end
@implementation ZJNBackMoneyTypeView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        type = 0;
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(AdFloat(60));
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
    
    [self addSubview:self.allBackBtn];
    [self.allBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AdFloat(40));
        make.right.equalTo(hLineV.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AdFloat(30));
        make.height.mas_equalTo(AdFloat(88));
    }];
    
    [self addSubview:self.customBtn];
    [self.customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hLineV.mas_right);
        make.right.equalTo(self).offset(-AdFloat(40));
        make.top.height.equalTo(self.allBackBtn);
    }];
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.allBackBtn.mas_bottom);
        make.height.mas_equalTo(AdFloat(60));
    }];
    
    [self.bgView addSubview:self.allBackView];
    [self.allBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView);
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
        _titleLabel.textColor = [UIColor hex:@"444444"];
        _titleLabel.text = @"请选择退款方式";
    }
    return _titleLabel;
}
-(UIButton *)allBackBtn{
    if (!_allBackBtn) {
        _allBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBackBtn.titleLabel.font = SetFont(AdFloat(28));
        [_allBackBtn setTitle:@"全额退款" forState:UIControlStateNormal];
        [_allBackBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        [_allBackBtn setImage:SetImage(@"为选中") forState:UIControlStateNormal];
        [_allBackBtn setImage:SetImage(@"一选中") forState:UIControlStateSelected];
        //交换button中title和image的位置
        [_allBackBtn sizeToFit];
        _allBackBtn.titleLabel.backgroundColor = _allBackBtn.backgroundColor;
        _allBackBtn.imageView.backgroundColor = _allBackBtn.backgroundColor;
        CGFloat labelWidth = _allBackBtn.titleLabel.width;
        CGFloat imageWith = _allBackBtn.imageView.width;
        _allBackBtn.imageEdgeInsets = UIEdgeInsetsMake(2, labelWidth+5, 0, -labelWidth-5);
        _allBackBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
        _allBackBtn.selected = YES;
        [_allBackBtn addTarget:self action:@selector(allBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBackBtn;
}
-(UIButton *)customBtn{
    if (!_customBtn) {
        _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _customBtn.titleLabel.font = SetFont(AdFloat(28));
        _customBtn.titleLabel.textColor = [UIColor hex:@"444444"];
        [_customBtn setTitle:@"自定义退款" forState:UIControlStateNormal];
        [_customBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        [_customBtn setImage:SetImage(@"为选中") forState:UIControlStateNormal];
        [_customBtn setImage:SetImage(@"一选中") forState:UIControlStateSelected];
        //交换button中title和image的位置
        [_customBtn sizeToFit];
        _customBtn.titleLabel.backgroundColor = _customBtn.backgroundColor;
        _customBtn.imageView.backgroundColor = _customBtn.backgroundColor;
        CGFloat labelWidth = _customBtn.titleLabel.width;
        CGFloat imageWith = _customBtn.imageView.width;
        _customBtn.imageEdgeInsets = UIEdgeInsetsMake(2, labelWidth+5, 0, -labelWidth-5);
        _customBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
        [_customBtn addTarget:self action:@selector(customBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customBtn;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}
-(ZJNAllBackView *)allBackView{
    if (!_allBackView) {
        _allBackView = [[ZJNAllBackView alloc]init];
    }
    return _allBackView;
}
-(ZJNCustomBackView *)customBackView{
    if (!_customBackView) {
        _customBackView = [[ZJNCustomBackView alloc]init];
    }
    return _customBackView;
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
-(void)allBackBtnClick{
    if (self.allBackBtn.selected) {
        return;
    }
    type = 0;
    self.allBackBtn.selected = YES;
    self.customBtn.selected = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnBackMoneyTypeViewTypeButtonClick:)]) {
        [self.delegate zjnBackMoneyTypeViewTypeButtonClick:type];
    }

    [self.customBackView removeFromSuperview];
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.allBackBtn.mas_bottom);
        make.height.mas_equalTo(AdFloat(60));
    }];
    [self.bgView addSubview:self.allBackView];
    [self.allBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.allBackBtn.mas_bottom);
        make.height.mas_equalTo(AdFloat(60));
    }];
}

-(void)customBtnClick{
    if (self.customBtn.selected) {
        return;
    }
    type = 1;
    self.allBackBtn.selected = NO;
    self.customBtn.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnBackMoneyTypeViewTypeButtonClick:)]) {
        [self.delegate zjnBackMoneyTypeViewTypeButtonClick:type];
    }
    
    [self.allBackView removeFromSuperview];
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.allBackBtn.mas_bottom);
        make.height.mas_equalTo(AdFloat(370));
    }];
    [self.bgView addSubview:self.customBackView];
    [self.customBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.allBackBtn.mas_bottom);
        make.height.mas_equalTo(AdFloat(370));
    }];

}

-(void)okBtnClick{
    
    NSDictionary *dic;
    if (type == 0) {
        //全额退款
        NSString *zfpt = [[self.allBackView.chargeView.middleLabel.text stringByReplacingOccurrencesOfString:@"（" withString:@""] stringByReplacingOccurrencesOfString:@"）" withString:@""];
        

        dic = @{@"token":USERTOKEN,@"id":self.model.id,@"tuikuan_type":@"1",@"ticheng":@"0",@"zfpt_ticheng":[self yuanToFen:zfpt],@"fafang_money":@"0",@"fabu_money":[self yuanToFen:self.allBackView.cutOffView.middleLabel.text]};
    }else{
        //自定义退款
        NSString *zfpt = [[self.allBackView.chargeView.middleLabel.text stringByReplacingOccurrencesOfString:@"（" withString:@""] stringByReplacingOccurrencesOfString:@"）" withString:@""];
        
        
        NSString *ticheng = [[self.customBackView.secondChargeView.middleLabel.text stringByReplacingOccurrencesOfString:@"（" withString:@""] stringByReplacingOccurrencesOfString:@"）" withString:@""];
        
        
        NSString *fafangMoney = [[self.customBackView.secondCutOffView.middleLabel.text stringByReplacingOccurrencesOfString:@"（" withString:@""] stringByReplacingOccurrencesOfString:@"）" withString:@""];
        NSString *fabuMoney = [[self.customBackView.firstCutOffView.middleLabel.text stringByReplacingOccurrencesOfString:@"（" withString:@""] stringByReplacingOccurrencesOfString:@"）" withString:@""];
        dic = @{@"token":USERTOKEN,@"id":self.model.id,@"tuikuan_type":@"1",@"ticheng":[self yuanToFen:ticheng],@"zfpt_ticheng":[self yuanToFen:zfpt],@"fafang_money":[self yuanToFen:fafangMoney],@"fabu_money":[self yuanToFen:fabuMoney]};
    }
    if (self.okBtnBlock) {
        self.okBtnBlock(dic);
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnBackMoneyTypeViewDismiss)]) {
        [self.delegate zjnBackMoneyTypeViewDismiss];
        type = 0;
        [self allBackBtnClick];
    }
}

-(void)cancelBtnClick{
//    [self.superview removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnBackMoneyTypeViewDismiss)]) {
        [self.delegate zjnBackMoneyTypeViewDismiss];
        type = 0;
        [self allBackBtnClick];
    }
}

-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    self.allBackView.model = model;
    self.customBackView.model = model;
}

-(NSString *)yuanToFen:(NSString *)yuan{
    CGFloat fen = [yuan floatValue];
    fen = fen *100;
    return [NSString stringWithFormat:@"%.2f",fen];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
