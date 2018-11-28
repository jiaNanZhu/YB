//
//  PublishTaskNameCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishTaskNameCell : UITableViewCell
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, copy)void (^publishNameBlock)(NSString *name);
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
