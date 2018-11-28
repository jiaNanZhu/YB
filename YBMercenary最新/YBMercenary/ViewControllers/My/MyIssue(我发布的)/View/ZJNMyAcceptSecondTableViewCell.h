//
//  ZJNMyAcceptSecondTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
NS_ASSUME_NONNULL_BEGIN
@class ZJNMyAcceptSecondTableViewCell;
@protocol ZJNMyAcceptSecondCellDelegate <NSObject>

-(void)ZJNMyAcceptSecondCellBottomBtnClickWithCell:(ZJNMyAcceptSecondTableViewCell *)cell;

@end
@interface ZJNMyAcceptSecondTableViewCell : UITableViewCell
@property(nonatomic ,strong)UILabel *titleLabel;//任务标题
@property(nonatomic ,strong)UILabel *priceLabel;//佣金
@property(nonatomic ,strong)UILabel *contentLabel;//任务详情
@property(nonatomic ,strong)UIImageView *doneImageV;//已完成
@property(nonatomic ,strong)YBMyIssueModel *model;
@property(nonatomic ,weak)id <ZJNMyAcceptSecondCellDelegate> delegate;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
