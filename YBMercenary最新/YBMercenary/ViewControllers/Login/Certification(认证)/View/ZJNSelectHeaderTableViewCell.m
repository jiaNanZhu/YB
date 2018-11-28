//
//  ZJNSelectHeaderTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSelectHeaderTableViewCell.h"

@implementation ZJNSelectHeaderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(190), AdFloat(40)));
        }];
        
        [self.contentView addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(12), AdFloat(24)));
        }];
        
        [self.contentView addSubview:self.headerImgV];
        [self.headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.imgV.mas_left).offset(-AdFloat(16));
            make.size.mas_equalTo(CGSizeMake(AdFloat(80), AdFloat(80)));
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
        _leftLabel.text = @"头像";
    }
    return _leftLabel;
}
-(UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc]initWithImage:SetImage(@"返回-4 copy 15")];
    }
    return _imgV;
}
-(UIImageView *)headerImgV{
    if (!_headerImgV) {
        _headerImgV = [[UIImageView alloc]initWithImage:SetImage(@"Group1")];
        _headerImgV.layer.masksToBounds = YES;
        _headerImgV.layer.cornerRadius = AdFloat(40);
    }
    return _headerImgV;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
