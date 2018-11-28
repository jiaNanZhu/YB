//
//  ZJNTopBtnSelectedView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNTopBtnSelectedView : UIView
@property (nonatomic ,copy)NSArray *sourceArr;
@property (nonatomic ,copy)void (^refreshSelectedBlock)(NSInteger index);
@end
