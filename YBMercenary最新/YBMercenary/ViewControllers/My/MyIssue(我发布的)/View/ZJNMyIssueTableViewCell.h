//
//  ZJNMyIssueTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
@class ZJNMyIssueTableViewCell;
@protocol ZJNMyIssueTableViewCellDelegate<NSObject>
@optional
//修改价格
-(void)myIssueTableViewCellChangeMoneyButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//未通过
-(void)myIssueTableViewCellWTGButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//撤销
-(void)myIssueTableViewCellXiaJiaButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//邀请
-(void)myIssueTableViewCellInviteButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//确认审核
-(void)myIssueTableViewCellAuditButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//上架
-(void)myIssueTableViewCellShangJiaButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//评价
-(void)myIssueTableViewCellEvaluateButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
//延期处理
-(void)myIssueTableViewCellBackOrderButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell;
@end
@interface ZJNMyIssueTableViewCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLabel;//任务标题
@property(nonatomic ,strong)UILabel *priceLabel;//佣金
@property(nonatomic ,strong)UILabel *contentLabel;//任务详情
@property(nonatomic ,strong)UIView  *lineView;//分割线
@property(nonatomic ,strong)UILabel *lookLabel;//浏览
@property(nonatomic ,strong)UILabel *shareLabel;//分享
@property(nonatomic ,strong)UIButton *leftBtn;//修改
@property(nonatomic ,strong)UIButton *middleBtn;//撤销
@property(nonatomic ,strong)UIButton *rightBtn;//评价、邀请、上架
@property(nonatomic ,strong)UIButton *auditBtn;//审核
@property(nonatomic ,weak)id<ZJNMyIssueTableViewCellDelegate>delegate;
@property(nonatomic ,strong)YBMyIssueModel *model;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end
