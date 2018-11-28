//
//  LifeFiltrateReceiverCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeFiltrateReceiverCell : UITableViewCell
@property (nonatomic, strong) UITextField *moneyField;

@property (nonatomic, strong) UITextField *dateField;

@property (nonatomic, copy)void(^moneyFieldBlock)(NSString *money);

@property (nonatomic, copy)void(^timeFieldBlock)(NSString *time);
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
