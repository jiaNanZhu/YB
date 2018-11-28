//
//  ZJNSliderView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNSliderView : UIView
@property (nonatomic ,strong)UISlider *slider;
@property (nonatomic ,copy)void (^sliderViewBlock)(CGFloat value);
@end

NS_ASSUME_NONNULL_END
