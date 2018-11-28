//
//  ZJNMyIssueWTGCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZJNMyIssueWTGCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLabel;//任务标题
@property(nonatomic ,strong)UILabel *priceLabel;//佣金
@property(nonatomic ,strong)UILabel *contentLabel;//任务详情
@property(nonatomic ,strong)UIView  *lineView;//分割线
@property(nonatomic ,strong)UILabel *lookLabel;//浏览
@property(nonatomic ,strong)UILabel *shareLabel;//分享
@property(nonatomic ,strong)UILabel *stateLabel;//右下角未通过
@property(nonatomic ,strong)UILabel *infoLabel;//未通过原因
@property(nonatomic ,strong)UIImageView *shareImg;
@property(nonatomic ,strong)UIImageView *lookImg;
@property(nonatomic ,strong)YBMyIssueModel *model;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
