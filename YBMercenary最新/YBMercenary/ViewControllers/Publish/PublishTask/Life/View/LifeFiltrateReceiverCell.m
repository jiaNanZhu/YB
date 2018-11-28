//
//  LifeFiltrateReceiverCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "LifeFiltrateReceiverCell.h"

@interface LifeFiltrateReceiverCell ()<UITextFieldDelegate>


@end

@implementation LifeFiltrateReceiverCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    LifeFiltrateReceiverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LifeFiltrateReceiverCell"];
    if (cell == nil) {
        cell = [[LifeFiltrateReceiverCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LifeFiltrateReceiverCell"];
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
    
    UILabel *reciver = [F_UI SL_UI_Label:@"筛选接单人" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:reciver];
    [reciver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    UIButton *choseBtn = [F_UI creatBtnWithTager:self title:@"" font:AdFloat(28) image:[UIImage imageNamed:@"选中"] backImage:nil color:nil textColor:nil cornerRadius:0 action:@selector(choseAction:)];
    [choseBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateSelected];
    [self.contentView addSubview:choseBtn];
    [choseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(reciver);
        make.left.equalTo(reciver.mas_right).offset(Width(10));
        make.width.height.mas_equalTo(Width(30));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(reciver.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    UILabel *money = [F_UI SL_UI_Label:@"佣金 /元" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [Utile setUILabel:money data:@"佣金" setData:@" /元" color:[UIColor redColor] font:AdFloat(20) underLine:NO];
    [self.contentView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    _moneyField = [[UITextField alloc]init];
    _moneyField.backgroundColor = [UIColor clearColor];
    _moneyField.placeholder = @"请输入佣金金额";
    _moneyField.textColor = [UIColor hex:@"999999"];
    _moneyField.font = [UIFont fontSize:AdFloat(28)];
    _moneyField.delegate = self;
    _moneyField.returnKeyType = UIReturnKeyDone;
    _moneyField.keyboardType = UIKeyboardTypePhonePad;
    [_moneyField addTarget:self action:@selector(moneyFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_moneyField];
    [_moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(money);
        make.right.lessThanOrEqualTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(choseBtn).offset(AdFloat(40));
        make.height.mas_equalTo(Width(24));
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(money.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    UILabel *date = [F_UI SL_UI_Label:@"任务有效期 /天" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [Utile setUILabel:date data:@"任务有效期" setData:@" /天" color:[UIColor redColor] font:AdFloat(20) underLine:NO];
    [self.contentView addSubview:date];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(15));
    }];
    
    _dateField = [[UITextField alloc]init];
    _dateField.backgroundColor = [UIColor clearColor];
    _dateField.placeholder = @"请输入任务有效期";
    _dateField.textColor = [UIColor hex:@"999999"];
    _dateField.font = [UIFont fontSize:AdFloat(28)];
    _dateField.delegate = self;
    _dateField.returnKeyType = UIReturnKeyDone;
    _dateField.keyboardType = UIKeyboardTypePhonePad;
    [_dateField addTarget:self action:@selector(dateFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.contentView addSubview:_dateField];
    [_dateField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(date);
        make.right.lessThanOrEqualTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(choseBtn).offset(AdFloat(40));
        make.height.mas_equalTo(Width(24));
    }];
    
//    UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [coverButton addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:coverButton];
//    [coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.dateField);
//    }];
}

- (void)choseAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)moneyFieldTextChanged:(UITextField *)textField{
    if (self.moneyFieldBlock) {
        self.moneyFieldBlock(textField.text);
    }
}
-(void)dateFieldValueChange:(UITextField *)textField{
    if (self.timeFieldBlock) {
        self.timeFieldBlock(textField.text);
    }
}
/*
-(void)selectTime{
    NSDate *maxDate = [NSDate date];
    [BRDatePickerView showDatePickerWithTitle:@"任务有效期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:maxDate maxDate:nil isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"yyyy-MM-dd"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        
        
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        
        [formatter setTimeZone:timeZone];
        
        
        
        NSDate* date = [formatter dateFromString:selectValue];
        NSString *currentDateString = [formatter stringFromDate:date];
        
        NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
        self.dateField.text = currentDateString;
        if (self.timeFieldBlock) {
            self.timeFieldBlock(timeString);
        }
        
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
