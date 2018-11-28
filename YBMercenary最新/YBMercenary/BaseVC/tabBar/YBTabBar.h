//
//  YBTabBar.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBTabBar : UITabBar
@property (nonatomic,copy) void(^didMiddBtn)(void);
@end
