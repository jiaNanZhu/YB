//
//  TypeSingleCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "TypeSingleCell.h"

@interface TypeSingleCell ()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TypeSingleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    CGFloat width = (kScreenWidth - Width(20)) / 5;
    _iconImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(-Width(10));
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(width - Width(28));
        make.height.mas_equalTo(width - Width(28));
    }];
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontSize:13];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(Width(8));
        make.bottom.left.right.equalTo(self.contentView);
    }];
}


- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title.length > 0) {
        self.iconImage.image = [UIImage imageNamed:title];
    }else{
        self.iconImage.image = nil;
    }
    self.titleLabel.text = title;
}


@end
