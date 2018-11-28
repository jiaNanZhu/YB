//
//  YBMyCollectRTableViewCell.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyCollectUserModel.h"
#import "YBMessagModel.h"
#import "YBMyCollectUserModel.h"
#import <RongCloudIM/RongIMKit/RCIM.h>
#import <RongIMKit/RongIMKit.h>

#import "SearchResultModel.h"
@interface YBMyCollectRTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *picIMG;//头像
@property (nonatomic, strong) UILabel *nameLab;//昵称
@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIView *read_status;

@property(nonatomic, strong) NSString *searchString;


-(void)networkDataCell:(YBMessagModel *)model;


-(void)networkdatawithmodel:(YBMyCollectUserModel *)model;

-(void)networkdatawithmsg:(SearchResultModel *)msg;

@end
