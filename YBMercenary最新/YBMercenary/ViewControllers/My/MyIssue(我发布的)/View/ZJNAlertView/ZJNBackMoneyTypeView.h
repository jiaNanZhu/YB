//
//  ZJNBackMoneyTypeView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ZJNBackMoneyTypeViewDelegate <NSObject>

-(void)zjnBackMoneyTypeViewTypeButtonClick:(NSInteger)type;
-(void)zjnBackMoneyTypeViewDismiss;
@end
@interface ZJNBackMoneyTypeView : UIView
@property (nonatomic ,copy)void (^okBtnBlock)(NSDictionary *dic);
@property (nonatomic ,weak)id<ZJNBackMoneyTypeViewDelegate>delegate;
@property (nonatomic ,strong)YBMyIssueModel *model;
@end

NS_ASSUME_NONNULL_END
