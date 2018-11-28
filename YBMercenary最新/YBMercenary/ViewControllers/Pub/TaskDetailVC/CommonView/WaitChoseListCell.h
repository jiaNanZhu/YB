//
//  WaitChoseListCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface WaitChoseListCell : BaseTableViewCell
@property (nonatomic ,copy)void (^updateTableViewHeightBlock)(void);
@property (nonatomic ,assign)NSInteger taskId;
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
