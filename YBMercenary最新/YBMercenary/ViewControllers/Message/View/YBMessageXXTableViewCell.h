//
//  YBMessageXXTableViewCell.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMessagModel.h"
#import "YBSysMessagModel.h"
@interface YBMessageXXTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLab;//标题
@property (nonatomic, strong) UILabel *contentLab;//内容
@property (nonatomic, strong) UILabel *timeLab;//时间

@property (nonatomic, strong) UIView *read_status;

-(void)networkDataCell:(NSDictionary *)dic type:(int)type;

-(void)networkDataCellmodel:(id )data type:(int)type;
@end
