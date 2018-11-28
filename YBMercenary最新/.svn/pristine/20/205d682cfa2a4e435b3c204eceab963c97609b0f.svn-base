//
//  PublishTaskNameCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishTaskNameCell.h"

@interface PublishTaskNameCell ()<UITextFieldDelegate>



@end

@implementation PublishTaskNameCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    PublishTaskNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishTaskNameCell"];
    if (cell == nil) {
        cell = [[PublishTaskNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PublishTaskNameCell"];
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
        make.height.mas_equalTo(Width(45));
    }];
    
    UILabel *taskName = [F_UI SL_UI_Label:@"任务名称" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:taskName];
    [taskName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.left.equalTo(self.contentView).offset(Width(15));
    }];
    
    _nameField = [[UITextField alloc]init];
    _nameField.backgroundColor = [UIColor clearColor];
    _nameField.placeholder = @"请输入任务名称";
    _nameField.textColor = [UIColor hex:@"999999"];
    _nameField.font = [UIFont fontSize:AdFloat(28)];
    _nameField.delegate = self;
    [_nameField addTarget:self action:@selector(nameTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    _nameField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_nameField];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(taskName.mas_right).offset(Width(15));
        make.width.mas_greaterThanOrEqualTo(Width(200));
        make.top.bottom.equalTo(backView);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)nameTextFieldValueChanged:(UITextField *)textField{
    if (self.publishNameBlock) {
        self.publishNameBlock(textField.text);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
