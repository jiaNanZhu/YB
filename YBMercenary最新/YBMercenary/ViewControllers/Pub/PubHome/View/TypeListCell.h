//
//  TypeListCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeListCell : UITableViewCell

@property (nonatomic, strong) UIView *leftView;

//@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UILabel *titleLabel;

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
