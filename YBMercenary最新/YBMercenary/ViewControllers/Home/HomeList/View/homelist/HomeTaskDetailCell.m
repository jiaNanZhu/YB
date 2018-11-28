//
//  HomeTaskDetailCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "HomeTaskDetailCell.h"
#import "TaskMarkView.h"

@interface HomeTaskDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TaskMarkView *markView;

@end

@implementation HomeTaskDetailCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    HomeTaskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTaskDetailCell"];
    if (cell == nil) {
        cell = [[HomeTaskDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTaskDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
    _titleLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1 ];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(AdFloat(30));
        make.right.equalTo(self.contentView).offset(-AdFloat(200));
    }];
    
    _priceLabel = [F_UI SL_UI_Label:@"¥" color:[UIColor hex:Yellow_Color] textAlignment:NSTextAlignmentRight textFont:16 numberOfLines:1 ];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-Width(15));
        make.centerY.equalTo(_titleLabel);
        make.width.mas_equalTo(AdFloat(160));
    }];
    
    _contentLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1 ];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(AdFloat(20));
        make.right.equalTo(self.contentView).offset(-AdFloat(30));
        
    }];
    
    _markView = [[TaskMarkView alloc]init];
    [self.contentView addSubview:_markView];
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-AdFloat(30));
        make.left.equalTo(self.contentView).offset(AdFloat(30));
        make.right.equalTo(self.contentView).offset(-AdFloat(30));
        make.top.equalTo(_contentLabel.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(20)).priority(999);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-AdFloat(30));
        make.left.equalTo(self.contentView).offset(AdFloat(30));
        make.height.mas_equalTo(AdFloat(2));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    self.titleLabel.text = data[@"task_name"];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",data[@"pay_amount"]];
    self.contentLabel.text = data[@"task_description"];
    NSString *taskTag = data[@"task_tag"];
    if (taskTag == nil || taskTag.length==0) {
        self.markView.markArr = nil;
    }else{
        self.markView.markArr = [taskTag componentsSeparatedByString:@"|"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
