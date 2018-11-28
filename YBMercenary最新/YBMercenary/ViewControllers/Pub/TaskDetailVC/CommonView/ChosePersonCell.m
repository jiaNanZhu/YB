//
//  ChosePersonCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ChosePersonCell.h"

@interface ChosePersonCell ()

@property (nonatomic, strong) UIButton *xuanding;
@property (nonatomic, strong) UIButton *daixuan;
@property (nonatomic, strong) UIButton *fangqi;

@end

@implementation ChosePersonCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    ChosePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChosePersonCell"];
    if (cell == nil) {
        cell = [[ChosePersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChosePersonCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)initSubViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _iconImage = [[UIImageView alloc]init];
    _iconImage.layer.cornerRadius = Width(20);
    _iconImage.layer.borderWidth = 1;
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width(15));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(Width(40));
    }];
    
    _nameLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImage);
        make.left.equalTo(_iconImage.mas_right).offset(Width(10));
    }];
    
    _priceLabel = [F_UI SL_UI_Label:@"¥100.00" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImage);
        make.left.equalTo(_nameLabel.mas_right).offset(Width(40));
    }];
    
    _fangqi = [F_UI creatBtnWithTager:self title:@"放弃" font:AdFloat(28) image:nil backImage:nil color:nil textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(fangqiAction)];
    [self.contentView addSubview:_fangqi];
    [_fangqi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-Width(15));
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(Width(50));
    }];
    
    _daixuan = [F_UI creatBtnWithTager:self title:@"待选" font:AdFloat(28) image:nil backImage:nil color:nil textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(daixuanAction)];
    [self.contentView addSubview:_daixuan];
    [_daixuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fangqi.mas_left);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(Width(45));
    }];
    
    _xuanding = [F_UI creatBtnWithTager:self title:@"选定" font:AdFloat(28) image:nil backImage:nil color:nil textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(xuandingAction)];
    [self.contentView addSubview:_xuanding];
    [_xuanding mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_daixuan.mas_left);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(Width(45));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width(15));
        make.right.equalTo(self.contentView.mas_right).offset(-Width(15));
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(Width(1));
    }];
}

- (void)setType:(NSString *)type{
    _type = type;
    if ([_type isEqualToString:@"signup"]) {
        [_fangqi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Width(45));
        }];
        [_daixuan mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Width(45));
        }];
    }else{
        [_fangqi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Width(0));
        }];
        [_daixuan mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Width(0));
        }];
    }
}

- (void)fangqiAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chosePersonCellButtonCLickWithType:withCell:)]) {
        [self.delegate chosePersonCellButtonCLickWithType:@"放弃" withCell:self];
    }
}

- (void)daixuanAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chosePersonCellButtonCLickWithType:withCell:)]) {
        [self.delegate chosePersonCellButtonCLickWithType:@"待选" withCell:self];
    }
}

- (void)xuandingAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chosePersonCellButtonCLickWithType:withCell:)]) {
        [self.delegate chosePersonCellButtonCLickWithType:@"选定" withCell:self];
    }
}
-(void)setBtnTitle:(NSString *)btnTitle{
    [_fangqi setTitle:btnTitle forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
