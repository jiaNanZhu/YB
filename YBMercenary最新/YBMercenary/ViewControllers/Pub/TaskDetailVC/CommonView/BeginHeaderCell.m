//
//  BeginHeaderCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BeginHeaderCell.h"
#import "TaskMarkView.h"

@interface BeginHeaderCell ()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *taskNameLabel;
@property (nonatomic, strong) UILabel *choseStateLabel;
@property (nonatomic, strong) TaskMarkView *markView;
@end

@implementation BeginHeaderCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    BeginHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeginHeaderCell"];
    if (cell == nil) {
        cell = [[BeginHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BeginHeaderCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}

- (void)initSubViews{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(8));
    }];
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    _iconImage.layer.cornerRadius = Width(25);
    _iconImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView).offset(Width(15));
        make.width.height.mas_equalTo(Width(50));
    }];
    
    _nameLabel = [F_UI SL_UI_Label:@"张三" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.mas_right).offset(Width(12));
        make.top.equalTo(_iconImage).offset(Width(5));
    }];
    
    _dateLabel = [F_UI SL_UI_Label:@"2017-11-01" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.bottom.equalTo(_iconImage).offset(-Width(5));
    }];
    
    _priceLabel = [F_UI SL_UI_Label:@"¥1000.00" color:[UIColor hex:Yellow_Color] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-Width(15));
        make.centerY.equalTo(_iconImage);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(Width(15));
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(Width(1));
    }];
    
    _taskNameLabel = [F_UI SL_UI_Label:@"任务名称" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_taskNameLabel];
    [_taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(15));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    _choseStateLabel = [F_UI SL_UI_Label:@"已筛选接单人" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_choseStateLabel];
    [_choseStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(15));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
    }];
    
    _markView = [[TaskMarkView alloc]init];
    [self.contentView addSubview:_markView];
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(12));
        make.left.equalTo(_taskNameLabel);
        make.right.equalTo(backView).offset(-Width(15));
        make.top.equalTo(_taskNameLabel.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(20)).priority(999);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
