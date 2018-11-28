//
//  YBMyAchievementWCTableViewCell.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/29.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBMyAchievementWCTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLab;//名称
@property (nonatomic, strong) UILabel *introLab;//简介
@property (nonatomic, strong) UILabel *timeLab;//时间
@property (nonatomic, strong) UIImageView *picIMG;//图标
@property (nonatomic, strong) UIView *scheduleView;//进度条背景
@property (nonatomic, strong) UIView *scheduleView1;//进度
@property (nonatomic, strong) UILabel *countLab;//完成数
-(void)networkDataCell:(NSDictionary *)dic row:(int)row section:(int)section;
@end
