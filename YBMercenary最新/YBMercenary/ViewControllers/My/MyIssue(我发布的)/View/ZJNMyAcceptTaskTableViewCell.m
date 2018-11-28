//
//  ZJNMyAcceptTaskTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyAcceptTaskTableViewCell.h"

@implementation ZJNMyAcceptTaskTableViewCell
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNMyAcceptTaskTableViewCell";
    ZJNMyAcceptTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNMyAcceptTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
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
            make.right.equalTo(self.contentView).offset(-AdFloat(200));
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
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
