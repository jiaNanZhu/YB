//
//  ZJNFirstHeadInfoTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/24.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskDetailModel.h"
@interface ZJNFirstHeadInfoTableViewCell : UITableViewCell
@property (nonatomic ,strong)TaskDetailModel *model;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end
