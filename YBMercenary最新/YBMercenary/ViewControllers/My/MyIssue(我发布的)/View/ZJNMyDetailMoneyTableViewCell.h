//
//  ZJNMyDetailMoneyTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
@class ZJNMyDetailMoneyTableViewCell;
NS_ASSUME_NONNULL_BEGIN
@protocol DetailMoneyDelagete <NSObject>

//未通过
-(void)myDetailMoneyTableViewCellWTGButtonClickWithCell:(ZJNMyDetailMoneyTableViewCell *)cell;
//确认审核
-(void)myDetailMoneyTableViewCellAuditButtonClickWithCell:(ZJNMyDetailMoneyTableViewCell *)cell;
//延期处理
-(void)myDetailMoneyTableViewCellBackOrderButtonClickWithCell:(ZJNMyDetailMoneyTableViewCell *)cell;

@end
@interface ZJNMyDetailMoneyTableViewCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLabel;//任务标题
@property(nonatomic ,strong)UILabel *priceLabel;//佣金
@property(nonatomic ,strong)UILabel *contentLabel;//任务详情
@property(nonatomic ,strong)UIView  *lineView;//分割线
@property(nonatomic ,strong)UILabel *lookLabel;//浏览
@property(nonatomic ,strong)UILabel *shareLabel;//分享
@property(nonatomic ,strong)UIButton *leftBtn;//未通过
@property(nonatomic ,strong)UIButton *middleBtn;//确认审核
@property(nonatomic ,strong)UIButton *rightBtn;//延期处理
@property(nonatomic ,strong)UILabel *zfMoneyLabel;//支付平台手续费
@property(nonatomic ,strong)UILabel *ptMoneyLabel;//佣兵平台手续费
@property(nonatomic ,strong)UILabel *jsMoneyLabel;//接受者佣金
@property(nonatomic ,strong)UILabel *fbMoneyLabel;//发布者佣金
@property(nonatomic ,strong)YBMyIssueModel *model;
@property(nonatomic ,weak)id <DetailMoneyDelagete>delegate;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
