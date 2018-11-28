//
//  ZJNAllBackView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJNServiceChargeView.h"
#import "ZJNCutOffView.h"
#import "YBMyIssueModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZJNAllBackView : UIView
@property (nonatomic ,strong)ZJNServiceChargeView *chargeView;
@property (nonatomic ,strong)ZJNCutOffView *cutOffView;
@property (nonatomic ,strong)YBMyIssueModel *model;
@end

NS_ASSUME_NONNULL_END
