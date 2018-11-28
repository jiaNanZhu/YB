//
//  ZJNTaskCoexecutorTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNTaskCoexecutorTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImageV;
@property (nonatomic ,strong)UILabel     *nameLabel;
@property (nonatomic ,strong)UIButton    *chatButton;
+(instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end
