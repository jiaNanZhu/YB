//
//  YBMyCollectRWTableViewCell.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
@interface YBMyCollectRWTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLab;//标题
@property (nonatomic, strong) UILabel *numLab;//费用
@property (nonatomic, strong) UILabel *contentLab;//内容
@property (nonatomic, strong) UIImageView *CompletedIMG;//已完成
-(void)networkDataCell:(NSDictionary *)dic row:(int)row type:(int)type;
-(void)configurationwithmodel:(YBMyIssueModel *)model;
@end
