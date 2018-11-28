//
//  ZJNChangeMoneyView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNChangeMoneyView : UIView
@property (nonatomic ,strong)UITextField *priceTextField;
@property (nonatomic ,copy)void (^changeMoneyBlock)(NSString *money);
@end

NS_ASSUME_NONNULL_END
