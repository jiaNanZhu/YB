//
//  ZJNWhileTaskViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"
typedef enum :NSInteger{
    MyPublishTask = 0,
    MyAcceptTask
}TaskType;
@interface ZJNWhileTaskViewController : BaseViewController
@property (nonatomic, assign) NSInteger taskId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy)void (^whileTaskRefreshBlock)(void);
-(id)initWithTaskType:(TaskType)type;

@end
