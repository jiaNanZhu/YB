//
//  CityCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "CityCell.h"

@interface CityCell ()

@end

@implementation CityCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    if (cell == nil) {
        cell = [[CityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CityCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    _nameLabel = [F_UI SL_UI_Label:@"北京" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(Width(15));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(Width(15));
        make.right.equalTo(self.contentView).offset(-Width(15));
        make.height.mas_equalTo(Width(1));
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
