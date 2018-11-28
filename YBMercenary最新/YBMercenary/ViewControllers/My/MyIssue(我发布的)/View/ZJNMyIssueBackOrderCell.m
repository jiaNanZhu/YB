//
//  ZJNMyIssueBackOrderCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyIssueBackOrderCell.h"
#import "DateTool.h"
@implementation ZJNMyIssueBackOrderCell

+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNMyIssueBackOrderCell";
    ZJNMyIssueBackOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNMyIssueBackOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
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
        
        [bgview addSubview:self.infoLabel];
        [bgview addSubview:self.dayLabel];
        [bgview addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.infoLabel);
            make.bottom.equalTo(bgview);
            make.height.mas_equalTo(AdFloat(60));
        }];
        
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.infoLabel);
            make.height.mas_equalTo(AdFloat(60));
            make.bottom.equalTo(self.dateLabel.mas_top);
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bgview).offset(AdFloat(20));
            make.left.equalTo(bgview).offset(AdFloat(30));
            make.right.equalTo(bgview).offset(-AdFloat(30));
            make.bottom.equalTo(self.dayLabel.mas_top);
          make.height.mas_greaterThanOrEqualTo(AdFloat(40));
        }];
        
        
        [self.contentView addSubview:self.shareLabel];
        [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.contentLabel.mas_bottom).offset(AdFloat(20));
            make.height.mas_equalTo(AdFloat(40));
        }];
        
        _shareImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"分享量 copy"]];
        [self.contentView addSubview:_shareImg];
        [_shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        _lookImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"眼睛 copy"]];
        [self.contentView addSubview:_lookImg];
        [_lookImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lookLabel);
            make.right.equalTo(self.lookLabel.mas_left).offset(-AdFloat(8));
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [self.contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(AdFloat(18));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(180), AdFloat(52)));
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
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.font = SetFont(AdFloat(28));
        _stateLabel.textColor = [UIColor hex:@"999999"];
        _stateLabel.backgroundColor = [UIColor hex:@"f5f5f5"];
        _stateLabel.layer.borderColor = [UIColor hex:@"e5e5e5"].CGColor;
        _stateLabel.layer.borderWidth = 1;
        _stateLabel.text = @"已延期处理";
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

-(UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.font = SetFont(AdFloat(28));
        _infoLabel.textColor = [UIColor hex:@"999999"];
        _infoLabel.numberOfLines = 0;
        _infoLabel.text = @"延期原因：";
    }
    return _infoLabel;
}
-(UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = SetFont(AdFloat(28));
        _dayLabel.textColor = [UIColor hex:@"999999"];
        _dayLabel.text = @"延期天数：";
    }
    return _dayLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = SetFont(AdFloat(28));
        _dateLabel.textColor = [UIColor hex:@"999999"];
        _dateLabel.text = @"延期时间：";
    }
    return _dateLabel;
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
    self.infoLabel.text = [NSString stringWithFormat:@"延期原因：%@",self.model.yanqi_reason];
    [Utile setUILabel:self.infoLabel data:nil setData:@"延期原因" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
    self.dayLabel.text = [NSString stringWithFormat:@"延期天数：%@",self.model.yanqi_days];
    [Utile setUILabel:self.dayLabel data:nil setData:@"延期天数" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
    self.dateLabel.text = [NSString stringWithFormat:@"延期时间：%@",[DateTool timeStampToString:[self.model.yanqi_start integerValue]]];
    [Utile setUILabel:self.dateLabel data:nil setData:@"延期时间" color:[UIColor hex:@"666666"] font:AdFloat(28) underLine:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
