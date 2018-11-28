//
//  SignupCustomTaskCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PhotoListView.h"
@interface SignupCustomTaskCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *requireLabel;

@property (nonatomic, strong) UILabel *detaileLabel;

@property (nonatomic, strong) PhotoListView *photoView;

@end
