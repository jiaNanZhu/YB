//
//  UIFont+FitSize.m
//  Ranch
//
//  Created by 龙青磊 on 2018/3/3.
//  Copyright © 2018年 xfkeji_Ranch. All rights reserved.
//

#import "UIFont+FitSize.h"

@implementation UIFont (FitSize)

+ (UIFont *)fontSize:(NSInteger)size{
    if (IS_IPHONE5) {
        return [UIFont systemFontOfSize:size - 1];
    }else if (IS_IPhone6){
        return [UIFont systemFontOfSize:size];
    }else{
        return [UIFont systemFontOfSize:size + 1];
    }
}

@end
