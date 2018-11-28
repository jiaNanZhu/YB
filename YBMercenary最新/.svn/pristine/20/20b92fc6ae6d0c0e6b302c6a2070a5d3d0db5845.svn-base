//
//  TaskChoseCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/13.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskChoseCell.h"

@interface TaskChoseCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *markView;
@end

@implementation TaskChoseCell


+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    TaskChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskChoseCell"];
    if (cell == nil) {
        cell = [[TaskChoseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskChoseCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)initSubViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _titleLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    _markView = [[UIImageView alloc]init];
    _markView.image = [UIImage imageNamed:@"选中标签"];
    _markView.hidden = YES;
    [self.contentView addSubview:_markView];
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-Width(20));
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(Width(22));
        make.height.mas_equalTo(Width(14));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(Width(1));
    }];
}

- (void)setChose:(BOOL)chose{
    _chose = chose;
    if (_chose) {
        self.titleLabel.textColor = [UIColor hex:Blue_Color];
        if ([self.type isEqualToString:@"mark"]) {
            self.markView.hidden = NO;
        }else{
            self.markView.hidden = YES;
        }
    }else{
        self.titleLabel.textColor = [UIColor hex:@"444444"];
        self.markView.hidden = YES;
    }
    self.titleLabel.text = self.title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
