//
//  ZJNTaskCoexecutorTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTaskCoexecutorTableViewCell.h"

@implementation ZJNTaskCoexecutorTableViewCell
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNTaskCoexecutorTableViewCell";
    ZJNTaskCoexecutorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNTaskCoexecutorTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.headImageV];
        [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(20));
            make.size.mas_equalTo(CGSizeMake(AdFloat(80), AdFloat(80)));
            make.bottom.equalTo(self.contentView).offset(-AdFloat(20));
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageV.mas_right).offset(AdFloat(24));
            make.centerY.equalTo(self.headImageV);
        }];
        
        [self.contentView addSubview:self.chatButton];
        [self.chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.centerY.equalTo(self.headImageV);
            make.size.mas_equalTo(CGSizeMake(AdFloat(110), AdFloat(60)));
        }];
    }
    return self;
}
-(UIImageView *)headImageV{
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        _headImageV.layer.cornerRadius = AdFloat(40);
        _headImageV.layer.masksToBounds = YES;
    }
    return _headImageV;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = SetFont(AdFloat(28));
        _nameLabel.textColor = [UIColor hex:@"444444"];
    }
    return _nameLabel;
}

-(UIButton *)chatButton{
    if (!_chatButton) {
        _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatButton setTitle:@"私信" forState:UIControlStateNormal];
        [_chatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chatButton.layer.cornerRadius = 4;
        _chatButton.layer.masksToBounds = YES;
        _chatButton.titleLabel.font = SetFont(AdFloat(26));
        _chatButton.backgroundColor = [UIColor hex:@"8bbd4b"];
    }
    return _chatButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
