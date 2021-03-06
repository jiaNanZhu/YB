//
//  IncomeTimeTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "IncomeTimeTableViewCell.h"

@implementation IncomeTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(AdFloat(30));
        }];
        
        [self.contentView addSubview:self.incomeLabel];
        [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(AdFloat(14));
        }];
        
        [self.contentView addSubview:self.expenditureLabel];
        [self.expenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.incomeLabel);
            make.left.equalTo(self.incomeLabel.mas_right).offset(AdFloat(80));
        }];
        
        [self.contentView addSubview:self.timeButton];
        [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
    }
    return self;
}
-(UILabel *)timeLabel{
    if (!_timeLabel ) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = SetFont(AdFloat(28));
        _timeLabel.textColor = [UIColor hex:@"444444"];
    }
    return _timeLabel;
}
-(UILabel *)incomeLabel{
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc]init];
        _incomeLabel.font = SetFont(AdFloat(26));
        _incomeLabel.textColor = [UIColor hex:@"666666"];
    }
    return _incomeLabel;
}
-(UILabel *)expenditureLabel{
    if (!_expenditureLabel) {
        _expenditureLabel = [[UILabel alloc]init];
        _expenditureLabel.font = SetFont(AdFloat(26));
        _expenditureLabel.textColor = [UIColor hex:@"666666"];
    }
    return _expenditureLabel;
}
-(UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setImage:SetImage(@"日历") forState:UIControlStateNormal];
    }
    return _timeButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
