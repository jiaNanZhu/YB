//
//  ChoseCityListVC.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseTableVC.h"

@interface ChoseCityListVC : BaseTableVC
@property (nonatomic ,copy)void(^choseCityListBlock)(NSString *city);
@end
