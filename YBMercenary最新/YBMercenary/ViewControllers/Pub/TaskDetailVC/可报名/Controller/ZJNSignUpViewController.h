//
//  ZJNSignUpViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/19.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"

@interface ZJNSignUpViewController : BaseViewController
@property (nonatomic, copy)void(^reloadTaskList)(void);
@property (nonatomic, assign) NSInteger taskId;
@property (nonatomic, assign) NSInteger type;
@end
