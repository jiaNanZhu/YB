//
//  ZJNSearchNavView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/1.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNSearchNavView : UIView

@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,copy)NSString *searchText;
@property (nonatomic ,copy)void(^searchNavViewBlock)(NSString *searchText);
@property (nonatomic ,copy)void(^hideResultViewBlock)(void);
@end
