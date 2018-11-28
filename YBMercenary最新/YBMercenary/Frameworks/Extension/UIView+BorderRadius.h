//
//  UIView+BorderRadius.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BorderRadius)

- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color radius:(CGFloat)radius;

- (UIViewController *)viewController;

- (UIViewController *)getCurrentVC;

@end
