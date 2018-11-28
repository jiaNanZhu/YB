//
//  ZJNCustomBackView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
#import "ZJNServiceChargeView.h"
#import "ZJNCutOffView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZJNCustomBackView : UIView
@property (nonatomic ,strong)ZJNServiceChargeView *firstChargeView;
@property (nonatomic ,strong)ZJNServiceChargeView *secondChargeView;
@property (nonatomic ,strong)ZJNCutOffView *firstCutOffView;
@property (nonatomic ,strong)ZJNCutOffView *secondCutOffView;
@property (nonatomic ,strong)YBMyIssueModel *model;
@end

NS_ASSUME_NONNULL_END
