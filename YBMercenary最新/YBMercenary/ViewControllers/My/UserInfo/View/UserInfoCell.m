//
//  UserInfoCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell ()

@property (nonatomic, strong) UILabel *hangyeLabel;
@property (nonatomic, strong) UILabel *techangLabel;
@property (nonatomic, strong) UILabel *yearsLabel;

@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation UserInfoCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
    if (cell == nil) {
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}

- (void)initSubViews{
    
    UIView *backView1 = [[UIView alloc]init];
    backView1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
    }];
    
    UILabel *hangye = [F_UI SL_UI_Label:@"行业" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:hangye];
    [hangye mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView1).offset(Width(15));
        make.width.mas_equalTo(Width(70));
    }];
    
    _hangyeLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:_hangyeLabel];
    [_hangyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hangye.mas_right).offset(Width(15));
        make.centerY.equalTo(hangye);
    }];
    
    UILabel *techang = [F_UI SL_UI_Label:@"特长" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:techang];
    [techang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hangye);
        make.top.equalTo(hangye.mas_bottom).offset(Width(15));
        make.width.mas_equalTo(Width(70));
    }];
    
    _techangLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:_techangLabel];
    [_techangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hangyeLabel);
        make.right.equalTo(self.mas_right).offset(-AdFloat(15*2));
        make.centerY.equalTo(techang);
    }];
    
    UILabel *years = [F_UI SL_UI_Label:@"工作年限" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:years];
    [years mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hangye);
        make.top.equalTo(techang.mas_bottom).offset(Width(15));
        make.width.mas_equalTo(Width(70));
        make.bottom.equalTo(backView1.mas_bottom).offset(-Width(15));
//        make.bottom.equalTo(self.contentView).offset(-Width(20));
    }];
    
    _yearsLabel = [F_UI SL_UI_Label:@"12年" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:_yearsLabel];
    [_yearsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_techangLabel);
        make.centerY.equalTo(years);
    }];
    
    UIView *backView2 = [[UIView alloc]init];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView1.mas_bottom).offset(Width(10));
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(10));
    }];
    
    UILabel *jieshao = [F_UI SL_UI_Label:@"我的介绍" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:jieshao];
    [jieshao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView2).offset(Width(15));
        make.top.equalTo(backView2).offset(Width(15));
    }];

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView2);
        make.top.equalTo(jieshao.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(1));
    }];

    _infoLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    _infoLabel.numberOfLines = 0;
    [self.contentView addSubview:_infoLabel];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(line).offset(Width(15));
        make.right.equalTo(backView2.mas_right).offset(-Width(15));
        make.bottom.equalTo(backView2.mas_bottom).offset(-Width(15));
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurationwith:(UservitaeModel *)model
{
    
    _hangyeLabel.text=model.industry;
    _techangLabel.text=model.speciality;
    _yearsLabel.text=model.workyear;
    _infoLabel.text=model.introduce;
}

@end
