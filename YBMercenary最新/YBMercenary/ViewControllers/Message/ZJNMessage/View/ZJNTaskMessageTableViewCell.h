//
//  ZJNTaskMessageTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJNTaskMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZJNTaskMessageTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImageView;
@property (nonatomic ,strong)UILabel *taskNameLabel;
@property (nonatomic ,strong)UILabel *taskTypeLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)ZJNTaskMessageModel *model;
@end

NS_ASSUME_NONNULL_END
