//
//  ZJNMyIssueTJTopButtonView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger{
    MyPublishTjType = 0,
    MyAcceptTjType
}TjType;
@interface ZJNMyIssueTJTopButtonView : UIView
@property (nonatomic ,copy)void (^myIssueTJBlock)(NSInteger stars);
@property (nonatomic ,assign)TjType tjType;
@end
