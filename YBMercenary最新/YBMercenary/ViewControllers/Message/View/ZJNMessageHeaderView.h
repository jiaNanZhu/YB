//
//  ZJNMessageHeaderView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZJNMessageHeaderViewDelegate <NSObject>

-(void)zjnMessageHeaderViewBtnClickWithTag:(NSInteger)tag;

@end
@interface ZJNMessageHeaderView : UIView
@property (nonatomic ,weak)id<ZJNMessageHeaderViewDelegate>delegate;
@property (nonatomic ,assign)int task;
@property (nonatomic ,assign)int chat;
@property (nonatomic ,assign)int tavern;
@property (nonatomic ,assign)int system;
@end

NS_ASSUME_NONNULL_END
