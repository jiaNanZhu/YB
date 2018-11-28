//
//  ZJNMyIssueTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyIssueTableViewCell.h"

@implementation ZJNMyIssueTableViewCell
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellid = @"ZJNMyIssueTableViewCell";
    ZJNMyIssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNMyIssueTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.width.mas_greaterThanOrEqualTo(AdFloat(100));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.top.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.priceLabel.mas_left).offset(-AdFloat(30));
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(AdFloat(20));
        }];
        
        UILabel *signLabel;
        for (int i = 0; i <3; i ++) {
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor hex:@"f5513c"];
            label.font = [UIFont fontWithName:@"PingFang SC" size:AdFloat(24)];
            label.layer.borderColor = [UIColor hex:@"f5513c"].CGColor;
            label.layer.borderWidth = 1;
            label.tag = 10+i;
            [self.contentView addSubview:label];
            if (i == 0) {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).offset(AdFloat(30));
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(AdFloat(20));
                    make.height.mas_equalTo(AdFloat(40));
                }];
                signLabel = label;
            }else{
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(signLabel.mas_right).offset(AdFloat(20));
                    make.top.equalTo(signLabel);
                    make.height.mas_equalTo(AdFloat(40));
                }];
                signLabel = label;
            }
        }
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
            make.top.equalTo(self.contentView).offset(AdFloat(200));
        }];
        
        [self.contentView addSubview:self.shareLabel];
        [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.contentLabel.mas_bottom).offset(AdFloat(20));
            make.height.mas_equalTo(AdFloat(40));
        }];
        
        UIImageView *shareImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"分享量 copy"]];
        [self.contentView addSubview:shareImg];
        [shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel);
            make.right.equalTo(self.shareLabel.mas_left).offset(-AdFloat(8));
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [self.contentView addSubview:self.lookLabel];
        [self.lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareLabel.mas_left).offset(-AdFloat(60));
            make.height.equalTo(self.shareLabel);
            make.top.equalTo(self.shareLabel);
        }];
        
        UIImageView *lookImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"眼睛 copy"]];
        [self.contentView addSubview:lookImg];
        [lookImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lookLabel);
            make.right.equalTo(self.lookLabel.mas_left).offset(-AdFloat(8));
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [self.contentView addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(AdFloat(18));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
//            make.size.mas_equalTo(CGSizeMake(AdFloat(96), AdFloat(52)));
//            make.height.mas_equalTo(AdFloat(52));
            make.bottom.equalTo(self.contentView).offset(-AdFloat(30));
        }];
        
        [self.contentView addSubview:self.middleBtn];
        [self.middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightBtn);
            make.right.equalTo(self.rightBtn.mas_left).offset(-AdFloat(16));
            make.bottom.equalTo(self.rightBtn);
        }];
        
        [self.contentView addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightBtn);
            make.right.equalTo(self.middleBtn.mas_left).offset(-AdFloat(16));
//            make.size.mas_equalTo(CGSizeMake(AdFloat(160), AdFloat(52)));
            make.bottom.equalTo(self.rightBtn);
        }];
        
        [self.contentView addSubview:self.auditBtn];
        [self.auditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.lineView.mas_bottom).offset(AdFloat(18));
//            make.height.mas_equalTo(AdFloat(52));
            make.width.mas_equalTo(AdFloat(160));
            make.bottom.equalTo(self.contentView).offset(-AdFloat(30));
        }];
        
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SetFont(AdFloat(28));
        _titleLabel.textColor = [UIColor hex:@"444444"];
    }
    return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = SetFont(AdFloat(38));
        _priceLabel.textColor = [UIColor hex:@"ffc90e"];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = SetFont(AdFloat(28));
        _contentLabel.textColor = [UIColor hex:@"666666"];
    }
    return _contentLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor hex:@"f5f5f5"];
    }
    return _lineView;
}
-(UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel = [[UILabel alloc]init];
        _lookLabel.font = SetFont(AdFloat(23));
        _lookLabel.textColor = [UIColor hex:@"666666"];
    }
    return _lookLabel;
}
-(UILabel *)shareLabel{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.font = SetFont(AdFloat(23));
        _shareLabel.textColor = [UIColor hex:@"666666"];
    }
    return _shareLabel;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _leftBtn.layer.borderWidth = 0.5;
        _leftBtn.titleLabel.font = SetFont(AdFloat(28));
        [_leftBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.hidden = YES;
    }
    return _leftBtn;
}
-(UIButton *)middleBtn{
    if (!_middleBtn) {
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _middleBtn.layer.borderWidth = 0.5;
        _middleBtn.titleLabel.font = SetFont(AdFloat(28));
        [_middleBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        _middleBtn.hidden = YES;
        [_middleBtn addTarget:self action:@selector(middleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _rightBtn.layer.borderWidth = 0.5;
        _rightBtn.titleLabel.font = SetFont(AdFloat(28));
        [_rightBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        _rightBtn.hidden = YES;
        [self.rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(UIButton *)auditBtn{
    if (!_auditBtn) {
        _auditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _auditBtn.layer.borderColor = [UIColor hex:@"999999"].CGColor;
        _auditBtn.layer.borderWidth = 0.5;
        _auditBtn.titleLabel.font = SetFont(AdFloat(28));
        [_auditBtn setTitleColor:[UIColor hex:@"999999"] forState:UIControlStateNormal];
        [_auditBtn setTitle:@"  确认通过  " forState:UIControlStateNormal];
        _auditBtn.hidden = YES;
        [self.auditBtn addTarget:self action:@selector(auditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _auditBtn;
}

-(void)setModel:(YBMyIssueModel *)model{
    _model = model;
    self.titleLabel.text = self.model.task_name;
    self.contentLabel.text = self.model.task_description;
    self.lookLabel.text = [NSString stringWithFormat:@"%@",self.model.view_num];
    self.shareLabel.text = [NSString stringWithFormat:@"%@",self.model.share_num];
    if(self.model.task_tag !=nil && self.model.task_tag.length !=0 && ![self.model.task_tag isEqual:@""]&& self.model.task_tag != NULL && ![self.model.task_tag isEqualToString:@""]){
        NSArray *tagArray = [self.model.task_tag componentsSeparatedByString:@"|"];
        for (int i = 0; i <3; i ++) {
            UILabel *label = (UILabel *)[self.contentView viewWithTag:10+i];
            if (i <tagArray.count) {
                NSString *tagStr = [NSString stringWithFormat:@" %@ ",tagArray[i]];
                label.text = tagStr;
            }else{
                label.text = nil;
            }
        }
    }

    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.model.pay_amount];
    NSInteger taskStatus = [self.model.task_status integerValue];
    if (taskStatus == 0) {
        //已发布 未审核 所有按钮都隐藏
    }else if (taskStatus == 1){
        //未决定 修改 撤销 邀请
        [_leftBtn setTitle:@"  修改价格  " forState:UIControlStateNormal];
        [_middleBtn setTitle:@"  撤销  " forState:UIControlStateNormal];
        [_rightBtn setTitle:@"  邀请  " forState:UIControlStateNormal];
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        self.middleBtn.hidden = NO;
        self.auditBtn.hidden = YES;
    }else if (taskStatus == 2 || taskStatus == 7){
        //任务中 所有按钮都隐藏
        self.leftBtn.hidden = YES;
        self.middleBtn.hidden = YES;
        self.auditBtn.hidden = YES;
        self.rightBtn.hidden = YES;
    }else if (taskStatus == 3){
        //审核中 确认审核
        [_leftBtn setTitle:@"  未通过  " forState:UIControlStateNormal];
        [_middleBtn setTitle:@"  确认审核  " forState:UIControlStateNormal];
        [_rightBtn setTitle:@"  延期处理  " forState:UIControlStateNormal];
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        self.middleBtn.hidden = NO;
        self.auditBtn.hidden = YES;
    }else if (taskStatus == 4){
        //已下架 上架
        [self.rightBtn setTitle:@"  上架  " forState:UIControlStateNormal];
        self.leftBtn.hidden = YES;
        self.middleBtn.hidden = YES;
        self.auditBtn.hidden = YES;
        self.rightBtn.hidden = NO;
    }else if (taskStatus == 6){
        //待评价 评价
        [self.rightBtn setTitle:@"  评价  " forState:UIControlStateNormal];
        self.leftBtn.hidden = YES;
        self.middleBtn.hidden = YES;
        self.auditBtn.hidden = YES;
        self.rightBtn.hidden = NO;
    }else if (taskStatus == 5){
        //后台审核未通过
        self.leftBtn.hidden = YES;
        self.middleBtn.hidden = YES;
        [self.auditBtn setTitle:@" 审核未通过 " forState:UIControlStateNormal];
        self.auditBtn.hidden = NO;
        self.rightBtn.hidden = YES;
    }
}
#pragma mark-撤销按钮点击实现方法

-(void)leftBtnClick{
    NSString *text = self.leftBtn.titleLabel.text;
    if ([text isEqualToString:@"  修改价格  "]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellChangeMoneyButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellChangeMoneyButtonClickWithCell:self];
        }
    }else if ([text isEqualToString:@"  未通过  "]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellWTGButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellWTGButtonClickWithCell:self];
        }
    }
    
}

-(void)middleButtonClick{
    NSString *text = self.middleBtn.titleLabel.text;
    if ([text isEqualToString:@"  撤销  "]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellXiaJiaButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellXiaJiaButtonClickWithCell:self];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellAuditButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellAuditButtonClickWithCell:self];
        }
    }
    
}

#pragma mark-
-(void)rightButtonClick{
    //评价、邀请、上架
    NSString *text = self.rightBtn.titleLabel.text;
    if ([text isEqualToString:@"  评价  "]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellEvaluateButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellEvaluateButtonClickWithCell:self];
        }
    }else if ([text isEqualToString:@"  邀请  "]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellInviteButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellInviteButtonClickWithCell:self];
        }
    }else if ([text isEqualToString:@"  上架  "]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellShangJiaButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellShangJiaButtonClickWithCell:self];
        }
    }else if ([text isEqualToString:@"  延期处理  "]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellBackOrderButtonClickWithCell:)]) {
            [self.delegate myIssueTableViewCellBackOrderButtonClickWithCell:self];
        }
    }
}
#pragma mark-确认审核
-(void)auditBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(myIssueTableViewCellAuditButtonClickWithCell:)]) {
        [self.delegate myIssueTableViewCellAuditButtonClickWithCell:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
