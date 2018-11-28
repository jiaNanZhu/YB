//
//  ErrandHeaderCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ErrandHeaderCellDelegate<NSObject>
-(void)errandHeaderCellTextFieldEndChanged:(NSString *)text index:(NSInteger)index;

@end
@interface ErrandHeaderCell : UITableViewCell
@property (nonatomic ,weak)id<ErrandHeaderCellDelegate>delegate;
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
