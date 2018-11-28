//
//  CustomTaskHeaderCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "CustomTaskHeaderCell.h"

@interface CustomTaskHeaderCell ()<UITextFieldDelegate>



@end

@implementation CustomTaskHeaderCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    CustomTaskHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTaskHeaderCell"];
    if (cell == nil) {
        cell = [[CustomTaskHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomTaskHeaderCell"];
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
        make.left.right.bottom.equalTo(self.contentView);
    }];
    
    UILabel *name = [F_UI SL_UI_Label:@"定制物品" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Width(15));
        make.right.equalTo(backView).mas_offset(-Width(15));
        make.top.equalTo(name.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    UILabel *reciver = [F_UI SL_UI_Label:@"筛选接单人" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [self.contentView addSubview:reciver];
    [reciver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    UIButton *choseBtn = [F_UI creatBtnWithTager:self title:@"" font:14 image:[UIImage imageNamed:@"选中"] backImage:nil color:nil textColor:nil cornerRadius:0 action:@selector(choseAction:)];
    [choseBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateSelected];
    [self.contentView addSubview:choseBtn];
    [choseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reciver);
        make.left.equalTo(reciver.mas_right).offset(Width(15));
        make.width.height.mas_equalTo(Width(15));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(reciver.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    UILabel *money = [F_UI SL_UI_Label:@"佣金 /元" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [Utile setUILabel:money data:@"佣金" setData:@" /元" color:[UIColor redColor] font:AdFloat(20) underLine:NO];
    [self.contentView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(15));
    }];
    
    _moneyField = [[UITextField alloc]init];
    _moneyField.backgroundColor = [UIColor clearColor];
    _moneyField.placeholder = @"请输入佣金";
    _moneyField.textColor = [UIColor hex:@"999999"];
    _moneyField.font = [UIFont fontSize:14];
    _moneyField.delegate = self;
    _moneyField.keyboardType = UIKeyboardTypePhonePad;
    _moneyField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_moneyField];
    [_moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(money);
        make.right.lessThanOrEqualTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(choseBtn);
        make.height.mas_equalTo(Width(24));
    }];
    
    _nameField = [[UITextField alloc]init];
    _nameField.backgroundColor = [UIColor clearColor];
    _nameField.placeholder = @"请输入定制物品";
    _nameField.textColor = [UIColor hex:@"999999"];
    _nameField.font = [UIFont fontSize:14];
    _nameField.delegate = self;
    _nameField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_nameField];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(name);
        make.right.lessThanOrEqualTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(choseBtn);
        make.height.mas_equalTo(Width(24));
    }];
    
}

- (void)choseAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
