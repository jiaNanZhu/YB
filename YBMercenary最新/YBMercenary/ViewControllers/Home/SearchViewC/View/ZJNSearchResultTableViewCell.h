//
//  ZJNSearchResultTableViewCell.h
//  YBMercenary
//
//  Created by 朱佳男 on 2018/11/28.
//  Copyright © 2018 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNSearchResultTableViewCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *data;

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
