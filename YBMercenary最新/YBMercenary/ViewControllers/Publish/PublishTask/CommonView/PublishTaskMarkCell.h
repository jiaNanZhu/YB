//
//  PublishTaskMarkCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskMarkView.h"
@interface PublishTaskMarkCell : UITableViewCell
@property (nonatomic, copy)void (^publishTaskAddMarkBlock)(NSString *mark);
@property (nonatomic, copy)void (^publishTaskDeleteMarkBlock)(NSString *mark);

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) TaskMarkView *markView;
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
