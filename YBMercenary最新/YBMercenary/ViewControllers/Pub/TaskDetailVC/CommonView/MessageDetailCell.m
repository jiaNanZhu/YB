//
//  MessageDetailCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/13.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "MessageDetailCell.h"
#import "DateTool.h"
@interface MessageDetailCell ()

@property (nonatomic, strong) UIImageView *iconImage;//头像
@property (nonatomic, strong) UILabel *nameLabel;//名称
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel *contentLabel;//内容

@end

@implementation MessageDetailCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageDetailCell"];
    if (cell == nil) {
        cell = [[MessageDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)initSubViews{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.layer.cornerRadius = Width(21);
    _iconImage.layer.borderWidth = 1;
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Width(15));
        make.top.equalTo(backView).offset(Width(15));
        make.width.height.mas_equalTo(Width(42));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"豆豆";
    _nameLabel.textColor = [UIColor hex:@"444444"];
    _nameLabel.font = [UIFont systemFontOfSize:AdFloat(28)];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage).offset(Width(1));
        make.left.equalTo(_iconImage.mas_right).offset(Width(12));
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"";
    _timeLabel.textColor = [UIColor hex:@"999999"];
    _timeLabel.font = [UIFont systemFontOfSize:AdFloat(24)];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(Width(5));
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.text = @"";
    _contentLabel.textColor = [UIColor hex:@"444444"];
    _contentLabel.font = [UIFont systemFontOfSize:AdFloat(28)];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(Width(12));
        make.left.equalTo(_nameLabel);
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(16));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(Width(1));
    }];
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,self.dic[@"leavemsg_user_headimg"]]] placeholderImage:[UIImage imageNamed:@"Group1"]];
    self.nameLabel.text = dic[@"leavemsg_user_name"];
    self.timeLabel.text = [DateTool timeStampToString:[dic[@"create_time"] integerValue]];
    self.contentLabel.text = dic[@"leavemsg_content"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
