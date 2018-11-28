//
//  OtherRequireCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherRequireCell : UITableViewCell
@property (nonatomic, strong) UITextField *textField;
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
