//
//  ZJNSystemTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSystemTableViewCell.h"
#import "DateTool.h"
@implementation ZJNSystemTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.taskNameLabel];
        [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            
        }];
        
        [self.contentView addSubview:self.taskTypeLabel];
        [self.taskTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.taskNameLabel);
            make.bottom.equalTo(self.contentView).offset(-AdFloat(20));
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.centerY.equalTo(self.taskNameLabel);
        }];
    };
    return self;
}
-(UILabel *)taskNameLabel{
    if (!_taskNameLabel) {
        _taskNameLabel = [[UILabel alloc]init];
        _taskNameLabel.textColor = [UIColor hex:@"444444"];
        _taskNameLabel.font = SetFont(AdFloat(32));
        _taskNameLabel.text = @"系统消息";
    }
    return _taskNameLabel;
}
-(UILabel *)taskTypeLabel{
    if (!_taskTypeLabel) {
        _taskTypeLabel = [[UILabel alloc]init];
        _taskTypeLabel.textColor = [UIColor hex:@"666666"];
        _taskTypeLabel.font = SetFont(AdFloat(26));
        _taskTypeLabel.text = @"佣兵天下APP新版本上线覆盖面更广";
    }
    return _taskTypeLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor hex:@"666666"];
        _timeLabel.font = SetFont(AdFloat(26));
        _timeLabel.text = @"昨天";
    }
    return _timeLabel;
}
-(void)setModel:(ZJNSystemMessageModel *)model{
    self.taskNameLabel.text = @"系统消息";
    self.taskTypeLabel.text = model.content;
    self.timeLabel.text = [DateTool zjnTimeStampToString:[model.time integerValue]];
}

-(void)setSecondModel:(ZJNJiuGuanModel *)secondModel{
    self.taskNameLabel.text = @"酒馆消息";
    self.taskTypeLabel.text = secondModel.content;
    self.timeLabel.text = [DateTool zjnTimeStampToString:[secondModel.push_time integerValue]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
