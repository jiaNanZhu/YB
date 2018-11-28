//
//  PostsCommentCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostsCommentModel.h"

@interface PostsCommentCell : UITableViewCell

@property (nonatomic, strong) PostsCommentModel *model;


@property(nonatomic,copy) void (^commentMethod)(NSString * liuyanId);
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
