//
//  AppDelegate.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "AppDelegate.h"
#import "YBTabbarViewController.h"

#import "AppDelegate+UMShare.h"
#import "AppDelegate+RCIM.h"
#import "AppDelegate+RCPush.h"
#import "YBLoginViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()
@property (nonatomic, strong) YBTabbarViewController *tabbar;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //U-Share 平台设置
    [self configUShare];
    
    //设置百度地图
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"Nvn1ANloNeUqKerSKGDtWfZgSvUqDM0X"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //即时通讯配置
    [self setupIMconfiguration];
    
    //推送处理
    [self configRCPushWithApplication:application LaunchOptions:launchOptions];
    
    self.tabbar = [[YBTabbarViewController alloc] init];
    //设置根视图
    self.window.rootViewController = self.tabbar;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
