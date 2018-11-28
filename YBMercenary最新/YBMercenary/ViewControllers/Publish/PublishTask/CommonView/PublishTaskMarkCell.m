//
//  PublishTaskMarkCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishTaskMarkCell.h"

@interface PublishTaskMarkCell()<UITextFieldDelegate>


@end

@implementation PublishTaskMarkCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    PublishTaskMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishTaskMarkCell"];
    if (cell == nil) {
        cell = [[PublishTaskMarkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PublishTaskMarkCell"];
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
    
    UILabel *taskMark = [F_UI SL_UI_Label:@"标签" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [self.contentView addSubview:taskMark];
    [taskMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    UIButton *addBtn = [F_UI creatBtnWithTager:self title:@"添加" font:14 image:nil backImage:nil color:nil textColor:[UIColor hex:Blue_Color] cornerRadius:0 action:@selector(addMarkAction)];
    [self.contentView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskMark);
        make.right.equalTo(backView.mas_right).offset(-Width(15));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(taskMark.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    _textField = [[UITextField alloc]init];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.placeholder = @"请输入2-4个的文字标签";
    _textField.textColor = [UIColor hex:@"999999"];
    _textField.font = [UIFont fontSize:14];
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(12));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.left.equalTo(backView).offset(Width(15));
        make.height.mas_equalTo(Width(24));
        
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textField.mas_bottom).offset(Width(40));
        make.left.equalTo(backView).offset(Width(15));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.height.mas_equalTo(Width(1));
    }];
    
    UIButton *deleteBtn = [F_UI creatBtnWithTager:self title:@"删除" font:13 image:nil backImage:nil color:nil textColor:[UIColor hex:@"999999"] cornerRadius:0 action:@selector(deleteAction:)];
    [deleteBtn setTitle:@"完成" forState:UIControlStateSelected];
    [self.contentView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(Width(10));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
    }];
    
    _markView = [[TaskMarkView alloc]init];
    __weak typeof(self) weakSelf = self;
    _markView.deleteMarkBlock = ^(NSString *mark) {
        if (weakSelf.publishTaskDeleteMarkBlock) {
            weakSelf.publishTaskDeleteMarkBlock(mark);
        }
    };
    _markView.markArr = @[];
    [self.contentView addSubview:_markView];
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(Width(12));
        make.left.equalTo(backView).offset(Width(15));
        make.right.equalTo(deleteBtn.mas_left).offset(-Width(10));
        make.height.mas_equalTo(Width(20)).priority(999);
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(15));
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)addMarkAction{
    if (_markView.markArr.count >= 3) {
        [DWBToast showCenterWithText:@"最多只能添加3个标签"];
    }else{
        if (self.textField.text.length >= 2 && self.textField.text.length <= 4) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:_markView.markArr];
            [arr addObject:self.textField.text];
            _markView.markArr = arr;
            if (self.publishTaskAddMarkBlock) {
                self.publishTaskAddMarkBlock(self.textField.text);
            }
            self.textField.text = @"";
        }else{
            [DWBToast showCenterWithText:@"请输入两到四个字符"];
        }
    }
}

- (void)deleteAction:(UIButton *)sender{
    if (sender.selected) {
        sender.selected = NO;
        [_markView stopDelete];
    }else{
        sender.selected = YES;
        [_markView startDelete];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
