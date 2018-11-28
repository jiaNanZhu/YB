//
//  TaskListHeaderView.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskListHeaderView.h"
#import "MarkItemCell.h"
#import "QL_CustomFlowLayout.h"
#import "PubTaskVC.h"

@interface TaskListHeaderView ()



@end

@implementation TaskListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCreatSubView];
    }
    return self;
}

- (void)setCreatSubView{
//    self.backgroundColor= [UIColor orangeColor];
    _headerImage = [[UIImageView alloc]init];
    _headerImage.image = [UIImage imageNamed:@"酒馆-顶部-广告"];
    [self addSubview:_headerImage];
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Width(10));
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(Width(120));
    }];
    
    _titleLabel = [F_UI SL_UI_Label:@"热门推荐" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentCenter textFont:14 numberOfLines:1];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImage.mas_bottom).offset(Width(12));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-Width(8));
    }];
    
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = [UIColor hex:@"999999"];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Width(25)).priority(999);
        make.right.equalTo(_titleLabel.mas_left).offset(-Width(10));
        make.height.mas_equalTo(Width(1)).priority(999);
        make.centerY.equalTo(_titleLabel);
    }];
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = [UIColor hex:@"999999"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(Width(10));
        make.right.equalTo(self.mas_right).offset(-Width(25)).priority(999);
        make.height.mas_equalTo(Width(1)).priority(999);
        make.centerY.equalTo(_titleLabel);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
