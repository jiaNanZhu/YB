//
//  ZJNSearchCollectionViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/1.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSearchCollectionViewCell.h"

@implementation ZJNSearchCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 15;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor hex:@"ececec"];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"测试数据";
        _contentLabel.font = SetFont(AdFloat(28));
        _contentLabel.textColor = [UIColor hex:@"666666"];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}
@end
