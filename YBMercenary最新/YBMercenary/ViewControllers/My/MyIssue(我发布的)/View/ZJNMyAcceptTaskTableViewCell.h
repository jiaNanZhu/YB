//
//  ZJNMyAcceptTaskTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
@interface ZJNMyAcceptTaskTableViewCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLabel;//任务标题
@property(nonatomic ,strong)UILabel *priceLabel;//佣金
@property(nonatomic ,strong)UILabel *contentLabel;//任务详情
@property(nonatomic ,strong)UIImageView *doneImageV;//已完成
@property(nonatomic ,strong)YBMyIssueModel *model;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end
