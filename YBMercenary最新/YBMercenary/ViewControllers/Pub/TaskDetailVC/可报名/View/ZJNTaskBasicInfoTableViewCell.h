//
//  ZJNTaskBasicInfoTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/24.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNTaskBasicInfoTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *taskNameLabel;
@property (nonatomic ,strong)UILabel *priceLabel;
@property (nonatomic ,copy)NSArray *tagArray;
+(instancetype)creatTableViewWithTableView:(UITableView *)tableView;
@end
