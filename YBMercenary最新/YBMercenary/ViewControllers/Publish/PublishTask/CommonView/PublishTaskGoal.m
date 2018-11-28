//
//  PublishTaskNameGoal.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishTaskGoal.h"
#import "NSString+Size.h"
@interface PublishTaskGoal ()<UITextViewDelegate>
{
    UILabel *countLabel;
}

@end

@implementation PublishTaskGoal

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    PublishTaskGoal *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishTaskGoal"];
    if (cell == nil) {
        cell = [[PublishTaskGoal alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PublishTaskGoal"];
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
    
    UILabel *taskGoal = [F_UI SL_UI_Label:@"任务目的" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:taskGoal];
    [taskGoal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    countLabel = [F_UI SL_UI_Label:@"0/200" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskGoal);
        make.right.equalTo(backView).offset(-Width(15));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(taskGoal.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.font = [UIFont fontSize:14];
    _textView.textColor = [UIColor hex:@"444444"];
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(10));
        make.left.equalTo(backView).offset(Width(10));
        make.right.equalTo(backView.mas_right).offset(-Width(10));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(10));
        make.height.mas_equalTo(Width(130));
    }];

    
    _tipLabel = [F_UI SL_UI_Label:@"请输入任务目的" color:[UIColor hex:@"999999"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView).offset(Width(7));
        make.left.equalTo(_textView).offset(Width(5));
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        _tipLabel.hidden = YES;
        if (self.publishTaskGoalBlock) {
            self.publishTaskGoalBlock(textView.text);
        }
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
        if (selectedRange && pos) {
            return;
        }
        NSString  *nsTextContent = textView.text;
        NSInteger existTextNum = nsTextContent.length;
        if (existTextNum > 200){
            NSString *s = [nsTextContent substringToIndex:200];
            textView.text = s;
        }
        //不支持系统表情的输入
        if ([NSString isStringContainsEmoji:textView.text]) {
            
            self.textView.text = [textView.text substringToIndex:textView.text.length - 2];
        }
        
    }else{
        _tipLabel.hidden = NO;
    }
    countLabel.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
