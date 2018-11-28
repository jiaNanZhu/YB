//
//  ZJNSecondInfoTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/24.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSecondInfoTableViewCell.h"
#import "DateTool.h"
#import "UserInfoVC.h"
@interface ZJNSecondInfoTableViewCell()
@property (nonatomic ,strong)UIImageView *headImageView;
@property (nonatomic ,strong)UIButton    *coverBtn;
@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *timeTag;
@property (nonatomic ,strong)UILabel *statusLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@end
@implementation ZJNSecondInfoTableViewCell
+(instancetype)creatTableViewCellWithTable:(UITableView *)tableView{
    static NSString *cellid = @"ZJNSecondInfoTableViewCell";
    ZJNSecondInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNSecondInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(100), AdFloat(100)));
            make.bottom.equalTo(self.contentView).offset(-AdFloat(30));
        }];
        [self.contentView addSubview:self.coverBtn];
        [self.coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(100), AdFloat(100)));
            make.bottom.equalTo(self.contentView).offset(-AdFloat(30));
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(AdFloat(24));
           make.height.mas_greaterThanOrEqualTo(AdFloat(40)); make.bottom.equalTo(self.headImageView.mas_centerY).offset(-4);
            
        }];
        
        [self.contentView addSubview:self.timeTag];
        [self.timeTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
           make.height.mas_greaterThanOrEqualTo(AdFloat(40)); make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
            
        }];
        
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(AdFloat(40));
            make.centerY.equalTo(self.nameLabel);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(AdFloat(40));
            make.centerY.equalTo(self.timeTag);
            make.right.equalTo(self.statusLabel);
            
        }];
    }
    
    return self;
}
//头像
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.layer.cornerRadius = AdFloat(50);
        _headImageView.layer.masksToBounds = YES;
        
    }
    return _headImageView;
}
-(UIButton *)coverBtn{
    if (!_coverBtn) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverBtn;
}
//名字
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor hex:@"444444"];
        _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(32)];
    }
    return _nameLabel;
}
//时间标签
-(UILabel *)timeTag{
    if (!_timeTag) {
        _timeTag = [[UILabel alloc]init];
        _timeTag.text = @"发单时间";
        _timeTag.textColor = [UIColor hex:@"999999"];
        _timeTag.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(26)];
    }
    return _timeTag;
}
//任务状态
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.textColor = [UIColor hex:@"444444"];
        _statusLabel.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(28)];
    }
    return _statusLabel;
}
//任务发布时间
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor hex:@"999999"];
        _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(26)];
    }
    return _timeLabel;
}
-(void)setModel:(TaskDetailModel *)model{
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,self.model.head_img]] placeholderImage:SetImage(@"Group1")];
    self.nameLabel.text = self.model.name;
    if ([self.model.task_status isEqualToString:@"2"]) {
        self.statusLabel.text = @"任务状态：任务中";
    }else if ([self.model.task_status isEqualToString:@"3"]){
        self.statusLabel.text = @"任务状态：审核中";
    }else if ([self.model.task_status isEqualToString:@"6"]){
        self.statusLabel.text = @"任务状态：待评价";
    }else{
        self.statusLabel.text = @"任务状态：";
    }
    
    self.timeLabel.text = [DateTool timeStampToString:[self.model.publish_time integerValue]];
}

-(void)coverBtnClick{
    UserInfoVC *vc = [[UserInfoVC alloc]init];
    vc.user_id = self.model.publisher_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
