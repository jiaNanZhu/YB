//
//  ZJNPhotoTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNPhotoTableViewCell.h"
@interface ZJNPhotoTableViewCell()
@property (nonatomic ,strong)UIView *bgView;

@end
@implementation ZJNPhotoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, AdFloat(40), AdFloat(20), AdFloat(40)));
        }];
        
        [self.bgView addSubview:self.centerImgV];
        [self.centerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.centerY.equalTo(self.bgView).offset(-AdFloat(20));
            make.size.mas_equalTo(CGSizeMake(AdFloat(90), AdFloat(90)));
        }];
        
        [self.bgView addSubview:self.centerLabel];
        [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.centerImgV.mas_bottom).offset(AdFloat(28));
            
        }];
        
        [self.bgView addSubview:self.coverImageView];
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bgView);
        }];
        
    }
    return self;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = COlOR_R_G_B_A(237, 237, 237, 1);
    }
    return _bgView;
}
-(UIImageView *)centerImgV{
    if (!_centerImgV) {
        _centerImgV = [[UIImageView alloc]initWithImage:SetImage(@"上传图片-3 copy 3")];
    }
    return _centerImgV;
}
-(UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.textColor = [UIColor hex:@"999999"];
        _centerLabel.font = SetFont(AdFloat(28));
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}
-(UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc]init];
    }
    return _coverImageView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
