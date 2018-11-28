//
//  ZJNTaskAuditViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"
typedef enum :NSInteger{
    MyPublishTaskAudit = 0,
    MyAcceptTaskAudit
}TaskAuditType;
@interface ZJNTaskAuditViewController : BaseViewController
@property (nonatomic, assign) NSInteger taskId;
@property (nonatomic, assign) NSInteger type;
-(id)initWithTaskType:(TaskAuditType)taskType;
@end
