//
//  ZJNMyDetailMoneyTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyDetailMoneyTableViewCell.h"

@implementation ZJNMyDetailMoneyTableViewCell

+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNMyDetailMoneyTableViewCell";
    ZJNMyDetailMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNMyDetailMoneyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.width.mas_greaterThanOrEqualTo(AdFloat(100));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.priceLabel.mas_left).offset(-AdFloat(30));
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(AdFloat(20));
        }];
        
        UILabel *signLabel;
        for (int i = 0; i <3; i ++) {
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor hex:@"f5513c"];
            label.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(24)];
            label.layer.borderColor = [UIColor hex:@"f5513c"].CGColor;
            label.layer.borderWidth = 1;
            label.tag = 10+i;
            [self.contentView addSubview:label];
            if (i == 0) {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).offset(AdFloat(30));
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(AdFloat(20));
                    make.height.mas_equalTo(AdFloat(40));
                }];
                signLabel = label;
            }else{
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(signLabel.mas_right).offset(AdFloat(20));
                    make.top.equalTo(signLabel);
                    make.height.mas_equalTo(AdFloat(40));
                }];
                signLabel = label;
            }
        }
        
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.contentView).offset(-AdFloat(100));
        }];
        
        UIView *bgview = [[UIView alloc]init];
        bgview.backgroundColor = [UIColor hex:@"f5f5f5"];
        [self.contentView addSubview:bgview];
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(signLabel.mas_bottom).offset(AdFloat(30));
            make.bottom.equalTo(self.lineView.mas_top).offset(-AdFloat(20));
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
        }];
        
        [bgview addSubview:self.zfMoneyLabel];
        [bgview addSubview:self.ptMoneyLabel];
        [bgview addSubview:self.jsMoneyLabel];
        [bgview addSubview:self.fbMoneyLabel];

        [self.zfMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgview).offset(AdFloat(30));
            make.top.equalTo(bgview);
            make.right.equalTo(self.ptMoneyLabel.mas_left).offset(-AdFloat(30));
            make.height.mas_equalTo(AdFloat(60));
            make.width.equalTo(self.ptMoneyLabel);
        }];
        
        [self.ptMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.zfMoneyLabel.mas_right).offset(AdFloat(30));
            make.right.equalTo(bgview).offset(-AdFloat(30));
            make.height.mas_equalTo(AdFloat(60));
            make.width.equalTo(self.zfMoneyLabel);
        }];
        
        [self.jsMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.zfMoneyLabel);
            make.size.equalTo(self.zfMoneyLabel);
            make.top.equalTo(self.zfMoneyLabel.mas_bottom);
            make.bottom.equalTo(bgview);
            
        }];
        
        [self.fbMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ptMoneyLabel);
            make.size.equalTo(self.ptMoneyLabel);
            make.top.equalTo(self.ptMoneyLabel.mas_bottom);
            make.bottom.equalTo(bgview);
        }];
        
        [self.contentView addSubview:self.shareLabel];
        [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.contentLabel.mas_bottom).offset(AdFloat(20));
            make.height.mas_equalTo(AdFloat(40));
        }];
        
        UIImageView *shareImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"分享量 copy"]];
        [self.contentView addSubview:shareImg];
        [shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel);
            make.right.equalTo(self.shareLabel.mas_left).offset(-AdFloat(8));
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [self.contentView addSubview:self.lookLabel];
        [self.lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareLabel.mas_left).offset(-AdFloat(60));
            make.height.equalTo(self.shareLabel);
            make.top.equalTo(self.shareLabel);
        }];
        
        UIImageView *lookImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"眼睛 copy"]];
        [self.contentView addSubview:lookImg];
        [lookImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lookLabel);
            make.right.equalTo(self.lookLabel.mas_left).offset(-AdFloat(8));
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [self.contentView addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(AdFloat(18));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.width.mas_equalTo(AdFloat(140));
            make.height.mas_equalTo(AdFloat(52));
        }];
        
        [self.contentView addSubview:self.middleBtn];
        [self.middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightBtn);
            make.right.equalTo(self.rightBtn.mas_left).offset(-AdFloat(16));
            make.width.mas_equalTo(AdFloat(140));
            make.height.equalTo(self.rightBtn);
        }];
        
        [self.contentView addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightBtn);
            make.right.equalTo(self.middleBtn.mas_left).offset(-AdFloat(16));
            make.width.mas_equalTo(AdFloat(120));
            make.height.equalTo(self.rightBtn);
        }];
        
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SetFont(AdFloat(28));
        _titleLabel.textColor = [UIColor hex:@"444444"];
    }
    return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = SetFont(AdFloat(38));
        _priceLabel.textColor = [UIColor hex:@"ffc90e"];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = SetFont(AdFloat(28));
        _contentLabel.textColor = [UIColor hex:@"666666"];
    }
    return _contentLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor hex:@"f5f5f5"];
    }
    return _lineView;
}
-(UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel = [[UILabel alloc]init];
        _lookLabel.font = SetFont(AdFloat(23));
        _lookLabel.textColor = [UIColor hex:@"666666"];
    }
    return _lookLabel;
}
-(UILabel *)shareLabel{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.font = SetFont(AdFloat(23));
        _shareLabel.textColor = [UIColor hex:@"666666"];
    }
    return _shareLabel;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _leftBtn.layer.borderWidth = 0.5;
        _leftBtn.titleLabel.font = SetFont(AdFloat(28));
        [_leftBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setTitle:@" 未通过 " forState:UIControlStateNormal];
    }
    return _leftBtn;
}
-(UIButton *)middleBtn{
    if (!_middleBtn) {
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _middleBtn.layer.borderWidth = 0.5;
        _middleBtn.titleLabel.font = SetFont(AdFloat(28));
        [_middleBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        [_middleBtn addTarget:self action:@selector(middleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.middleBtn setTitle:@" 确认审核 " forState:UIControlStateNormal];
        
    }
    return _middleBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _rightBtn.layer.borderWidth = 0.5;
        _rightBtn.titleLabel.font = SetFont(AdFloat(28));
        [_rightBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setTitle:@" 延期处理 " forState:UIControlStateNormal];
    }
    return _rightBtn;
}

-(UILabel *)zfMoneyLabel{
    if (!_zfMoneyLabel) {
        _zfMoneyLabel = [[UILabel alloc]init];
        _zfMoneyLabel.font = SetFont(AdFloat(28));
        _zfMoneyLabel.textColor = [UIColor hex:@"999999"];
        _zfMoneyLabel.numberOfLines = 0;
        _zfMoneyLabel.text = @"支付平台手续费：";
    }
    return _zfMoneyLabel;
}
-(UILabel *)ptMoneyLabel{
    if (!_ptMoneyLabel) {
        _ptMoneyLabel = [[UILabel alloc]init];
        _ptMoneyLabel.font = SetFont(AdFloat(28));
        _ptMoneyLabel.textColor = [UIColor hex:@"999999"];
        _ptMoneyLabel.text = @"平台手续费：";
    }
    return _ptMoneyLabel;
}
-(UILabel *)jsMoneyLabel{
    if (!_jsMoneyLabel) {
        _jsMoneyLabel = [[UILabel alloc]init];
        _jsMoneyLabel.font = SetFont(AdFloat(28));
        _jsMoneyLabel.textColor = [UIColor hex:@"999999"];
        _jsMoneyLabel.text = @"接受者：";
    }
    return _jsMoneyLabel;
}
-(UILabel *)fbMoneyLabel{
    if (!_fbMoneyLabel) {
        _fbMoneyLabel = [[UILabel alloc]init];
        _fbMoneyLabel.font = SetFont(AdFloat(28));
        _fbMoneyLabel.textColor = [UIColor hex:@"999999"];
        _fbMoneyLabel.text = @"发布者：";
    }
    return _fbMoneyLabel;
}

-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    self.titleLabel.text = self.model.task_name;
    self.contentLabel.text = self.model.task_description;
    self.lookLabel.text = [NSString stringWithFormat:@"%@",self.model.view_num];
    self.shareLabel.text = [NSString stringWithFormat:@"%@",self.model.share_num];
    if(self.model.task_tag !=nil && self.model.task_tag.length !=0 && ![self.model.task_tag isEqual:@""]&& self.model.task_tag != NULL && ![self.model.task_tag isEqualToString:@""]){
        NSArray *tagArray = [self.model.task_tag componentsSeparatedByString:@"|"];
        for (int i = 0; i <3; i ++) {
            UILabel *label = (UILabel *)[self.contentView viewWithTag:10+i];
            if (i <tagArray.count) {
                NSString *tagStr = [NSString stringWithFormat:@" %@ ",tagArray[i]];
                label.text = tagStr;
            }else{
                label.text = nil;
            }
        }
    }
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.model.pay_amount];
    self.zfMoneyLabel.text = [NSString stringWithFormat:@"支付平台手续费：%@元",[self fenToYuan:self.model.zfpt_ticheng]];
    [Utile setUILabel:self.zfMoneyLabel data:nil setData:@"支付平台手续费" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
    self.ptMoneyLabel.text = [NSString stringWithFormat:@"平台手续费：%@元",[self fenToYuan:self.model.ticheng]];
    [Utile setUILabel:self.ptMoneyLabel data:nil setData:@"平台手续费" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
    self.jsMoneyLabel.text = [NSString stringWithFormat:@"接受者：%@元",[self fenToYuan:self.model.fafang_money]];
    [Utile setUILabel:self.jsMoneyLabel data:nil setData:@"接受者" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
    self.fbMoneyLabel.text = [NSString stringWithFormat:@"发布者：%@元",[self fenToYuan:self.model.fabu_money]];
    [Utile setUILabel:self.fbMoneyLabel data:nil setData:@"发布者" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
}
-(void)leftBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(myDetailMoneyTableViewCellWTGButtonClickWithCell:)]) {
        [self.delegate myDetailMoneyTableViewCellWTGButtonClickWithCell:self];
    }
}
-(void)middleButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(myDetailMoneyTableViewCellAuditButtonClickWithCell:)]) {
        [self.delegate myDetailMoneyTableViewCellAuditButtonClickWithCell:self];
    }
}
-(void)rightButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(myDetailMoneyTableViewCellBackOrderButtonClickWithCell:)]) {
        [self.delegate myDetailMoneyTableViewCellBackOrderButtonClickWithCell:self];
    }
}
-(NSString *)fenToYuan:(NSString *)fen{
    CGFloat yuan = [fen floatValue];
    yuan = yuan/100.0;
    return [NSString stringWithFormat:@"%.2f",yuan];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
