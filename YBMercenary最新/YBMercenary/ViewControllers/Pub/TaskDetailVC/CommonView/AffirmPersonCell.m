//
//  AffirmPersonCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "AffirmPersonCell.h"

@interface AffirmPersonCell ()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *messageBtn;


@end

@implementation AffirmPersonCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    AffirmPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AffirmPersonCell"];
    if (cell == nil) {
        cell = [[AffirmPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AffirmPersonCell"];
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
        make.height.mas_equalTo(Width(50));
    }];
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    _iconImage.layer.cornerRadius = Width(20);
    _iconImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Width(15));
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(Width(40));
    }];
    
    _nameLabel = [F_UI SL_UI_Label:@"张三" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:15 numberOfLines:1];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.mas_right).offset(Width(15));
        make.centerY.equalTo(_iconImage);
    }];
    
    _messageBtn = [F_UI creatBtnWithTager:self title:@"私信" font:14 image:nil backImage:nil color:[UIColor hex:Green_Color] textColor:[UIColor whiteColor] cornerRadius:5 action:@selector(messageAction)];
    [self.contentView addSubview:_messageBtn];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.centerY.equalTo(backView);
        make.width.mas_equalTo(Width(60));
    }];
}

- (void)messageAction{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
