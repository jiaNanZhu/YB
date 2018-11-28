//
//  IncomeDetailTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "IncomeDetailTableViewCell.h"

@implementation IncomeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(AdFloat(28));
            make.left.equalTo(self.contentView).offset(AdFloat(34));
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(34));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(AdFloat(10));
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SetFont(AdFloat(30));
        _titleLabel.textColor = [UIColor hex:@"444444"];
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = SetFont(AdFloat(26));
        _contentLabel.textColor = [UIColor hex:@"666666"];
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = SetFont(AdFloat(32));
        _priceLabel.textColor = [UIColor hex:@"444444"];
    }
    return _priceLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
