//
//  AppDelegate+RCIM.h
//  YBMercenary
//
//  Created by 朱佳男 on 2018/11/23.
//  Copyright © 2018 xfkeji_yongbing. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import <RongCloudIM/RongIMKit/RCIM.h>
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (RCIM)<RCIMConnectionStatusDelegate, RCIMReceiveMessageDelegate,RCIMUserInfoDataSource>
-(void)setupIMconfiguration;
@end

NS_ASSUME_NONNULL_END
