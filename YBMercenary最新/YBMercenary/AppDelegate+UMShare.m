//
//  AppDelegate+UMShare.m
//  YBMercenary
//
//  Created by 朱佳男 on 2018/11/23.
//  Copyright © 2018 xfkeji_yongbing. All rights reserved.
//

#import "AppDelegate+UMShare.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
@implementation AppDelegate (UMShare)
-(void)configUShare{
    [UMConfigure initWithAppkey:@"5b75194ea40fa31b6e000241" channel:@"App Store"];
    [self configUSharePlatforms];
}
//配置分享平台
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx0bddad191db67737" appSecret:@"3484f4b0808c7b895dc0c0bfb1841818" redirectURL:nil];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106484844"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3169663256"  appSecret:@"8292350b6a4180157579caa1368c592c" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
@end
