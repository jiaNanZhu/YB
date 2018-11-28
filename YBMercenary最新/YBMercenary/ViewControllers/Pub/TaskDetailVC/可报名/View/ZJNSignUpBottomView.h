//
//  ZJNSignUpBottomView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/19.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZJNSignUpBottomViewDelegate<NSObject>
-(void)bottomCollecBtnClick;
-(void)bottomComplainBtnClick;
-(void)bottomStateBtnClick;
@end
@interface ZJNSignUpBottomView : UIView
@property (nonatomic ,weak)id<ZJNSignUpBottomViewDelegate>delegate;
@property (nonatomic ,strong)UIButton *collectBtn;
@property (nonatomic ,strong)UIButton *complainBtn;
@property (nonatomic ,strong)UIButton *stateBtn;
@property (nonatomic ,copy)NSString *type;//任务状态 0 已发布等待管理员审核 1未决定 2任务中 3已完成待发布者审核 4已下架 5 管理员审核未通过，6发布者确认完成，待评价 7已评价
@end
