//
//  AppDelegate+RCPush.h
//  YBMercenary
//
//  Created by 朱佳男 on 2018/11/23.
//  Copyright © 2018 xfkeji_yongbing. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (RCPush)
-(void)configRCPushWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions;
@end

NS_ASSUME_NONNULL_END
