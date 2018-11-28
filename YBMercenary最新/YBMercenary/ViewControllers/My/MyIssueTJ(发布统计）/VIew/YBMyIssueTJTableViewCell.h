//
//  YBMyIssueTJTableViewCell.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBMyIssueTJTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLab;//名称
@property (nonatomic, strong) UILabel *numLab;//金额

-(void)networkDataCell:(NSDictionary *)dic;
@end
