//
//  ZJNTaskBasicInfoTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/24.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTaskBasicInfoTableViewCell.h"
@interface ZJNTaskBasicInfoTableViewCell()

@end
@implementation ZJNTaskBasicInfoTableViewCell
+(instancetype)creatTableViewWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNTaskBasicInfoTableViewCell";
    ZJNTaskBasicInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNTaskBasicInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.taskNameLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_greaterThanOrEqualTo(AdFloat(40)); make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.priceLabel.mas_left).offset(-AdFloat(20));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AdFloat(40));
            make.width.mas_greaterThanOrEqualTo(AdFloat(180));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            
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
                    make.top.equalTo(self.taskNameLabel.mas_bottom).offset(AdFloat(24));
                    make.height.mas_equalTo(AdFloat(40));
                    make.bottom.equalTo(self.contentView).offset(-AdFloat(30));
                }];
                signLabel = label;
            }else{
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(signLabel.mas_right).offset(AdFloat(20));
                    make.top.equalTo(self.taskNameLabel.mas_bottom).offset(AdFloat(24));
                    make.height.mas_equalTo(AdFloat(40));
                    make.bottom.equalTo(self.contentView).offset(-AdFloat(30));
                }];
                signLabel = label;
            }
        }
    }
    return self;
}
-(UILabel *)taskNameLabel{
    if (!_taskNameLabel) {
        _taskNameLabel = [[UILabel alloc]init];
        _taskNameLabel.textColor = [UIColor hex:@"444444"];
        _taskNameLabel.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(28)];
        _taskNameLabel.numberOfLines = 0;
    }
    return _taskNameLabel;
}
//价格标签
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor hex:@"444444"];
        _priceLabel.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(28)];
    }
    return _priceLabel;
}
-(void)setTagArray:(NSArray *)tagArray{
    _tagArray = tagArray;
    for (int i = 0; i <self.tagArray.count ; i ++) {
        UILabel *label = (UILabel *)[self.contentView viewWithTag:10+i];
        NSString *tagStr = [NSString stringWithFormat:@" %@ ",self.tagArray[i]];
        label.text = tagStr;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
