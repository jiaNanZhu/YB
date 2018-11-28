//
//  TypeListCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TypeListCell.h"

@interface TypeListCell ()

@end

@implementation TypeListCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    TypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeListCell"];
    if (cell == nil) {
        cell = [[TypeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TypeListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _leftView = [[UIView alloc]init];
    _leftView.backgroundColor  = [UIColor hex:Blue_Color];
    _leftView.hidden = YES;
    [self.contentView addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(Width(3));
        make.height.mas_equalTo(Width(55));
    }];
    
    UIView *_bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor  = [UIColor hex:Back_Color];
    [self.contentView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(Width(60));
        make.height.mas_equalTo(1);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor hex:@"333333"];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.left.mas_equalTo(_leftView.mas_right);
    }];
}


- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
