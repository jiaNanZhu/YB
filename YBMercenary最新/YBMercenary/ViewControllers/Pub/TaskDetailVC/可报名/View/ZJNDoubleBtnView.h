//
//  ZJNDoubleBtnView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/19.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNDoubleBtnView : UIView
@property (nonatomic ,copy)void (^tableViewReloadBlock)(NSString *type);
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)UIButton *leftButton;
@property (nonatomic ,strong)UIButton *rightButton;
@end
