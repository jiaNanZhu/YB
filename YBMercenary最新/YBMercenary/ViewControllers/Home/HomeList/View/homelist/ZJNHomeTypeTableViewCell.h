//
//  ZJNHomeTypeTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNHomeTypeTableViewCell : UITableViewCell
+(ZJNHomeTypeTableViewCell *)creatTableViewCellForTableView:(UITableView *)tableView;
@property (nonatomic ,copy)void(^refreshListBlock)(void);
@end
