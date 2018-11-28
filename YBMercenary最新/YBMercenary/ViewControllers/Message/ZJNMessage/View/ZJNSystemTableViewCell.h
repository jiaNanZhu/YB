//
//  ZJNSystemTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJNSystemMessageModel.h"
#import "ZJNJiuGuanModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZJNSystemTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *taskNameLabel;
@property (nonatomic ,strong)UILabel *taskTypeLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)ZJNSystemMessageModel *model;
@property (nonatomic ,strong)ZJNJiuGuanModel *secondModel;
@end

NS_ASSUME_NONNULL_END
