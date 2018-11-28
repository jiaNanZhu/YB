//
//  ZJNMyAcceptSecondTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyAcceptSecondTableViewCell.h"
@interface ZJNMyAcceptSecondTableViewCell()
@property (nonatomic ,strong)UIButton *bottomBtn;
@end
@implementation ZJNMyAcceptSecondTableViewCell

+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNMyAcceptSecondTableViewCell";
    ZJNMyAcceptSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNMyAcceptSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(160));
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(AdFloat(20));
            make.height.mas_equalTo(AdFloat(40));
        }];
        
        UILabel *signLabel;
        for (int i = 0; i <5; i ++) {
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
        [self.contentView addSubview:self.doneImageV];
        [self.doneImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-AdFloat(22));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(100), AdFloat(76)));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor hex:@"f5f5f5"];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-AdFloat(80));
            make.height.mas_equalTo(1);
        }];
        
        [self.contentView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(lineView.mas_bottom).offset(AdFloat(20));
            make.height.mas_equalTo(AdFloat(52));
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
-(UIImageView *)doneImageV{
    if (!_doneImageV) {
        _doneImageV = [[UIImageView alloc]init];
        _doneImageV.image = SetImage(@"已完成");
    }
    return _doneImageV;
}
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _bottomBtn.layer.borderWidth = 0.5;
        _bottomBtn.titleLabel.font = SetFont(AdFloat(28));
        [_bottomBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        [_bottomBtn setTitle:@"  退款  " forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}
-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    self.titleLabel.text = self.model.task_name;
    self.contentLabel.text = self.model.task_description;
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
    if ([self.model.task_status isEqualToString:@"6"]||[self.model.task_status isEqualToString:@"7"]) {
        self.doneImageV.hidden = NO;
    }else{
        self.doneImageV.hidden = YES;
    }
    if ([self.model.settle_status isEqualToString:@"2"]) {
        [self.bottomBtn setTitle:@" 退款中 " forState:UIControlStateNormal];
        self.bottomBtn.userInteractionEnabled = NO;
    }else{
        self.bottomBtn.userInteractionEnabled = YES;
    }
}
-(void)bottomBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZJNMyAcceptSecondCellBottomBtnClickWithCell:)]) {
        [self.delegate ZJNMyAcceptSecondCellBottomBtnClickWithCell:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
