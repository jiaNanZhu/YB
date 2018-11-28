//
//  PublishTaskNameGoal.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishTaskGoal : UITableViewCell
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, copy)void (^publishTaskGoalBlock)(NSString *goal);
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
