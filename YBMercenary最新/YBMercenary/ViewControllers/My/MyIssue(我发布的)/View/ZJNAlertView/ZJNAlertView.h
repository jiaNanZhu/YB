//
//  ZJNAlertView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMyIssueModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger ,ZJNAlertType){
    ZJNChangeMoneyAlert = 0,//修改价格
    ZJNWTGAlert,//未通过
    ZJNBackOrderAlert,//延期处理
    ZJNBackMoneyAlert//退款
};
@protocol ZJNAlertViewDelegate <NSObject>
//确定按钮点击实现方法
-(void)zjnAlertViewOkButtonClickWithBackMoneyDic:(NSDictionary *)dic;
//未通过原因
-(void)zjnAlertViewWTGViewOkBtnClickWithInfo:(NSString *)info;
@end
@interface ZJNAlertView : UIView
@property (nonatomic ,assign)ZJNAlertType alertType;
@property (nonatomic ,weak)id <ZJNAlertViewDelegate> delegate;
//未通过block
@property (nonatomic ,copy)void (^wtgViewInfoBlock)(NSString *info);
//修改金额
@property (nonatomic ,copy)void (^changeMoneyViewBlock)(NSString *money);
//延期处理
@property (nonatomic ,copy)void (^backOrderViewBlock)(NSDictionary *dic);

@property (nonatomic ,strong)YBMyIssueModel *model;
@end

NS_ASSUME_NONNULL_END
