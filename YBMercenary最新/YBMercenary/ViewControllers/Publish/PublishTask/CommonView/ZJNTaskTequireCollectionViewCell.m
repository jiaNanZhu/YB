//
//  ZJNTaskTequireCollectionViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTaskTequireCollectionViewCell.h"
@interface ZJNTaskTequireCollectionViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *requireLabel;
@end
@implementation ZJNTaskTequireCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    _requireLabel = [F_UI SL_UI_Label:@"标签1" color:[UIColor hex:@"444444"] textAlignment:0 textFont:AdFloat(28) numberOfLines:1];
    [self.contentView addSubview:_requireLabel];
    [_requireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(Width(4));
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    UIButton *reduceBtn = [F_UI creatBtnWithTager:self title:nil font:0 image:[UIImage imageNamed:@"删除"] backImage:nil color:[UIColor clearColor] textColor:nil cornerRadius:0 action:@selector(reduceAction)];
    [self.contentView addSubview:reduceBtn];
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(_requireLabel);
        make.width.height.mas_equalTo(Width(18));
    }];
    
    _textField = [[UITextField alloc]init];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = [UIColor hex:Back_Color].CGColor;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = leftView;
    _textField.placeholder = @"请输入任务标签 (0/5)";
    _textField.delegate = self;
    _textField.textColor = [UIColor hex:@"999999"];
    _textField.font = SetFont(AdFloat(28));
    [self.contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Width(8));
        make.right.equalTo(reduceBtn.mas_left).offset(-Width(8));
        make.left.equalTo(_requireLabel.mas_right).offset(Width(11));
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)reduceAction{
    [self.delegate zjnDeleteRowWithIndex:self.row];
}

- (void)setRow:(NSInteger)row{
    _row = row;
    _requireLabel.text = [NSString stringWithFormat:@"标签%ld",_row + 1];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
