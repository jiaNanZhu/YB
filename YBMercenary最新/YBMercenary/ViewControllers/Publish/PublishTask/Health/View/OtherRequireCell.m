//
//  OtherRequireCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "OtherRequireCell.h"

@interface OtherRequireCell ()<UITextFieldDelegate>



@end

@implementation OtherRequireCell


+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    OtherRequireCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRequireCell"];
    if (cell == nil) {
        cell = [[OtherRequireCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherRequireCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor hex:Back_Color];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Width(8));
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(10));
    }];
    
    UILabel *reciver = [F_UI SL_UI_Label:@"其他要求" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [self.contentView addSubview:reciver];
    [reciver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(10));
    }];
    
    _textField = [[UITextField alloc]init];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.placeholder = @"请输入其他要求";
    _textField.textColor = [UIColor hex:@"999999"];
    _textField.font = [UIFont fontSize:14];
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reciver);
        make.right.lessThanOrEqualTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(reciver.mas_right).offset(Width(15));
        make.height.mas_equalTo(Width(24));
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
