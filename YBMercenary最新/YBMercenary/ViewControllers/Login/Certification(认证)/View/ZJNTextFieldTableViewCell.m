//
//  ZJNTextFieldTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTextFieldTableViewCell.h"
@interface ZJNTextFieldTableViewCell()<UITextFieldDelegate>

@end
@implementation ZJNTextFieldTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(190), AdFloat(40)));
        }];
        
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.leftLabel.mas_right);
            make.right.equalTo(self.contentView).offset(-AdFloat(60));
        }];
        
        [self.contentView addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(12), AdFloat(24)));
        }];
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor hex:@"f5f5f5"];
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = [UIColor hex:@"444444"];
        _leftLabel.font = SetFont(AdFloat(28));
    }
    return _leftLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = [UIColor hex:@"999999"];
        _textField.font = SetFont(AdFloat(28));
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc]initWithImage:SetImage(@"返回-4 copy 15")];
    }
    return _imgV;
}

-(void)textFieldTextChanged:(UITextField *)textField{
    if (self.textFieldChangedBlock) {
        self.textFieldChangedBlock(textField.text);
    }
}
#pragma mark-UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.leftLabel.text isEqualToString:@"银行卡号"]) {
        [self verifyBankCardWithNumber:textField.text];
    }
}

-(void)verifyBankCardWithNumber:(NSString *)number{
    if (number.length == 0) {
        return;
    }
    [KVNProgress show];
    NSDictionary *dic = @{@"cardNo":number};
    [[YBRequestManager sharedYBManager] postWithUrlString:getBankName parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            if (self.verifyBankBlock) {
                self.verifyBankBlock(data[@"data"][@"bankname"]);
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(showInfoWithText:)]) {
                [self.delegate showInfoWithText:data[@"msg"]];
            }
            self.textField.text = @"";
        }
        [KVNProgress dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [KVNProgress dismiss];
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
