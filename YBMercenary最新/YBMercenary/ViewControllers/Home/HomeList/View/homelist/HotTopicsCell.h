//
//  HotTopicsCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubTypeListModel.h"
@interface HotTopicsCell : UITableViewCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

-(void)configurationcellwithmodel:(PubTypeListModel *)model;
@end
