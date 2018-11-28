//
//  ZJNBankCardCell.m
//  YBMercenary
//
//  Created by JW on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNBankCardCell.h"

@implementation ZJNBankCardCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self setUI];
        
    }
    return self;
}
-(UIImageView *)imgView
{
    if(!_imgView)
    {
        _imgView =[[UIImageView alloc]init];
        _imgView.clipsToBounds=YES;
        _imgView.layer.cornerRadius=AdFloat(20*2);
        
//        _imgView.backgroundColor=[UIColor redColor];
        
    }
    return _imgView;
}
-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab =[[UILabel alloc]init];
        _titleLab.textColor=[UIColor blackColor];
        _titleLab.font=[UIFont systemFontOfSize:14];
    
        _titleLab.text=@"中国建设银行";
    }
    return _titleLab;
}
-(UILabel *)typeLab
{
    if(!_typeLab)
    {
        _typeLab =[[UILabel alloc]init];
        _typeLab.textColor=[UIColor blackColor];
        _typeLab.font=[UIFont systemFontOfSize:12];
        _typeLab.textColor=[UIColor lightGrayColor];
        _typeLab.text=@"储蓄卡";
    }
    return _typeLab;
}
-(UILabel *)cardNumLab
{
    if(!_cardNumLab)
    {
        _cardNumLab =[[UILabel alloc]init];
        _cardNumLab.textColor=[UIColor blackColor];
        _cardNumLab.font=[UIFont systemFontOfSize:12];
        _cardNumLab.textColor=[UIColor lightGrayColor];
        _cardNumLab.text=@"0000";
    }
    return _cardNumLab;
}
-(UIButton *)delegateBtn
{
    if (!_delegateBtn) {
        _delegateBtn =[UIButton buttonWithType:UIButtonTypeCustom];
       
        [_delegateBtn setTitle:@"解绑" forState:UIControlStateNormal];
        [_delegateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        _delegateBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        
    }
    return _delegateBtn;
    
}
-(void)setUI
{
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.typeLab];
    [self.contentView addSubview:self.cardNumLab];
    [self.contentView addSubview:self.delegateBtn];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self.contentView).offset(AdFloat(15*2));
        make.height.width.mas_equalTo(AdFloat(40*2));
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imgView.mas_top);
        make.left.equalTo(self.imgView.mas_right).offset(AdFloat(15*2));
        make.right.equalTo(self.contentView.mas_right).offset(-AdFloat(15*2));
        
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(AdFloat(10));
        make.left.equalTo(self.titleLab.mas_left);
    }];
    
    
    [self.cardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(AdFloat(10));
        make.left.equalTo(self.typeLab.mas_right).offset(AdFloat(20*2));
        
    }];
    
    
    [self.delegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-AdFloat(15*2));
        make.width.mas_equalTo(60);
        
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
