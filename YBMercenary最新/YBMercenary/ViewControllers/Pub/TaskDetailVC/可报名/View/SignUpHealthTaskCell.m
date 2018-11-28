//
//  SignUpHealthTaskCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "SignUpHealthTaskCell.h"

@interface SignUpHealthTaskCell ()

@end

@implementation SignUpHealthTaskCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    SignUpHealthTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignUpHealthTaskCell"];
    if (cell == nil) {
        cell = [[SignUpHealthTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SignUpHealthTaskCell"];
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
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView);
        make.height.mas_greaterThanOrEqualTo(Width(30)+20);
    }];
    
    UILabel *purpose = [F_UI SL_UI_Label:@"任务达成目的" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:purpose];
    [purpose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView1).offset(Width(15));
        make.width.mas_equalTo(AdFloat(186));
        make.height.mas_equalTo(20);
    }];
    
    _purposeLabel = [F_UI SL_UI_Label:@"上地七街北口" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_purposeLabel];
    [_purposeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(purpose.mas_right).offset(AdFloat(30));
        make.top.equalTo(purpose);
        make.right.equalTo(backView1).offset(-Width(15));
        make.bottom.equalTo(backView1.mas_bottom).offset(-Width(15));
    }];
    
    UIView *backView2 = [[UIView alloc]init];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(backView1.mas_bottom).offset(Width(8));
        make.height.mas_greaterThanOrEqualTo(Width(30)+20);
    }];
    
    UILabel *require = [F_UI SL_UI_Label:@"任务要求" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:require];
    [require mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView2).offset(Width(15));
        make.width.mas_equalTo(Width(75));
        make.height.mas_equalTo(20);
    }];
    
    _requireLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_requireLabel];
    [_requireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_purposeLabel);
        make.top.equalTo(require);
        make.right.equalTo(backView2).offset(-Width(15));
        make.bottom.equalTo(backView2.mas_bottom).offset(-Width(15));
    }];
    
    UIView *backView3 = [[UIView alloc]init];
    backView3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView3];
    [backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(backView2.mas_bottom).offset(Width(8));
        make.bottom.equalTo(self.contentView);
    }];
    
    _detailLabel = [F_UI SL_UI_Label:@"任务描述相关文字" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView3).offset(Width(15));
        make.top.equalTo(backView3).offset(Width(10));
        make.right.equalTo(backView3).offset(-Width(15));
    }];
    
    _photoView = [[PhotoListView alloc]init];
    [self.contentView addSubview:_photoView];
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailLabel.mas_bottom).offset(Width(10));
        make.left.equalTo(backView3).offset(Width(15));
        make.right.equalTo(backView3).offset(-Width(15));
        make.height.mas_equalTo((kScreenWidth - Width(40))/3);
        make.bottom.equalTo(backView3.mas_bottom).offset(-Width(10));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
