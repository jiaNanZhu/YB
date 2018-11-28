//
//  UIButton+Category.m
//  DSSManito
//
//  Created by Sunny on 2018/1/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

- (instancetype)initBackgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor fontSize:(CGFloat)font title:(NSString *)title {
    if ([super init]) {
        self.backgroundColor = backgroundColor;
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return  self;
}

@end
