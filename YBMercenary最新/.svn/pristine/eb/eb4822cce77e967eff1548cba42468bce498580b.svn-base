//
//  SignupTaskDetailCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "SignupPaotuiTaskCell.h"

@interface SignupPaotuiTaskCell ()

@end

@implementation SignupPaotuiTaskCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    SignupPaotuiTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignupPaotuiTaskCell"];
    if (cell == nil) {
        cell = [[SignupPaotuiTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SignupPaotuiTaskCell"];
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
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        
    }];
    
    UILabel *name = [F_UI SL_UI_Label:@"物品名称" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView1).offset(Width(15));
        make.width.mas_equalTo(AdFloat(124));
    }];
    
    _nameLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(AdFloat(30));
        make.top.equalTo(name);
        make.height.mas_greaterThanOrEqualTo(20);
        make.right.equalTo(backView1).offset(-Width(15));
    }];
    
    UILabel *count = [F_UI SL_UI_Label:@"数量" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.equalTo(name);
        make.top.equalTo(_nameLabel.mas_bottom).offset(Width(15));
    }];
    
    _countLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(AdFloat(30));
        make.top.equalTo(count);
        make.height.mas_greaterThanOrEqualTo(20);
        make.right.equalTo(backView1).offset(-Width(15));
    }];
    
    UILabel *begin = [F_UI SL_UI_Label:@"开始地址" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:begin];
    [begin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.equalTo(name);
        make.top.equalTo(_countLabel.mas_bottom).offset(Width(15));
    }];
    
    _beginLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_beginLabel];
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(AdFloat(30));
        make.top.equalTo(begin);
        make.height.mas_greaterThanOrEqualTo(20);
        make.right.equalTo(backView1).offset(-Width(15));
    }];
    
    UILabel *end = [F_UI SL_UI_Label:@"目的地址" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:end];
    [end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.equalTo(name);
        make.top.equalTo(_beginLabel.mas_bottom).offset(Width(15));
    }];
    
    _endLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(AdFloat(30));
        make.top.equalTo(end);
        make.right.equalTo(backView1).offset(-Width(15));
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    UILabel *time = [F_UI SL_UI_Label:@"送达时间" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.equalTo(name);
        make.top.equalTo(_endLabel.mas_bottom).offset(Width(15));
        make.bottom.equalTo(backView1.mas_bottom).offset(-Width(15));
    }];
    
    _timeLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(AdFloat(30));
        make.top.equalTo(time);
        make.height.mas_greaterThanOrEqualTo(20);
        make.right.equalTo(backView1).offset(-Width(15));
        make.bottom.equalTo(backView1.mas_bottom).offset(-Width(15));
    }];
    
    UIView *backView2 = [[UIView alloc]init];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(backView1.mas_bottom).offset(Width(8));
        make.bottom.equalTo(self.contentView);
    }];
    
    UILabel *require = [F_UI SL_UI_Label:@"运输要求" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:require];
    [require mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView2).offset(Width(15));
        make.width.mas_equalTo(AdFloat(124));
        
    }];
    
    _requireLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_requireLabel];
    [_requireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(require.mas_right).offset(AdFloat(30));
        make.top.equalTo(require);
        make.right.equalTo(backView2).offset(-Width(15));
        make.height.mas_greaterThanOrEqualTo(20);
        make.bottom.equalTo(backView2.mas_bottom).offset(-Width(15));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
