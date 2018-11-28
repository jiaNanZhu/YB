//
//  SignupCustomTaskCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "SignupCustomTaskCell.h"


@interface SignupCustomTaskCell ()

@end

@implementation SignupCustomTaskCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    SignupCustomTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignupCustomTaskCell"];
    if (cell == nil) {
        cell = [[SignupCustomTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SignupCustomTaskCell"];
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
    }];
    
    UILabel *require = [F_UI SL_UI_Label:@"任务要求" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:require];
    [require mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView1).offset(Width(15));
        make.width.mas_equalTo(AdFloat(124));
        
    }];
    
    _requireLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_requireLabel];
    [_requireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(require.mas_right).offset(AdFloat(30));
        make.top.equalTo(require);
        make.right.equalTo(backView1).offset(-Width(15));
        make.height.mas_greaterThanOrEqualTo(20);
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
    
    _detaileLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:0];
    [self.contentView addSubview:_detaileLabel];
    [_detaileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView2).offset(Width(15));
        make.top.equalTo(backView2).offset(Width(10));
        make.right.equalTo(backView2).offset(-Width(15));
    }];
    
    _photoView = [[PhotoListView alloc]init];
    [self.contentView addSubview:_photoView];
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detaileLabel.mas_bottom).offset(Width(10));
        make.left.equalTo(backView2).offset(Width(15));
        make.right.equalTo(backView2).offset(-Width(15));
        make.height.mas_equalTo((kScreenWidth - Width(40))/3);
        make.bottom.equalTo(backView2.mas_bottom).offset(-Width(10));
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
