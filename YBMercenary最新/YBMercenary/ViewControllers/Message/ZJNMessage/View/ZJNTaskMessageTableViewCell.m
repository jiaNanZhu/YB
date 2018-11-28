//
//  ZJNTaskMessageTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTaskMessageTableViewCell.h"
#import "DateTool.h"
@implementation ZJNTaskMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.size.mas_equalTo(CGSizeMake(AdFloat(80), AdFloat(80)));
        }];
        
        [self.contentView addSubview:self.taskNameLabel];
        [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(AdFloat(20));
            make.top.equalTo(self.headImageView);
            
        }];
        
        [self.contentView addSubview:self.taskTypeLabel];
        [self.taskTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.taskNameLabel);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.bottom.equalTo(self.headImageView);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.centerY.equalTo(self.taskNameLabel);
        }];
    };
    return self;
}
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = AdFloat(40);
        _headImageView.image = SetImage(@"头像");
    }
    return _headImageView;
}
-(UILabel *)taskNameLabel{
    if (!_taskNameLabel) {
        _taskNameLabel = [[UILabel alloc]init];
        _taskNameLabel.textColor = [UIColor hex:@"444444"];
        _taskNameLabel.font = SetFont(AdFloat(32));
        _taskNameLabel.text = @"任务名称";
    }
    return _taskNameLabel;
}
-(UILabel *)taskTypeLabel{
    if (!_taskTypeLabel) {
        _taskTypeLabel = [[UILabel alloc]init];
        _taskTypeLabel.textColor = [UIColor hex:@"666666"];
        _taskTypeLabel.font = SetFont(AdFloat(26));
        _taskTypeLabel.text = @"任务聊天内容";
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
-(void)setModel:(ZJNTaskMessageModel *)model{
    self.taskNameLabel.text = model.name;
    self.taskTypeLabel.text = model.content;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.user_head_img]] placeholderImage:SetImage(@"Group1")];
    self.timeLabel.text = [DateTool zjnTimeStampToString:[model.push_time integerValue]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
