//
//  YBMYSeniorityIDCardViewController.h
//  YBMercenary
//
//  Created by JW on 2018/7/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"
@protocol YBMYSeniorityIDCardViewControllerDelegate<NSObject>

- (void)saveidcardnum:(NSString *)num;

@end

@interface YBMYSeniorityIDCardViewController : BaseViewController

@property (nonatomic, weak) id<YBMYSeniorityIDCardViewControllerDelegate> delegate;
@end
