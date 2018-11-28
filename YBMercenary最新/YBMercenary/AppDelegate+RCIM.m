//
//  AppDelegate+RCIM.m
//  YBMercenary
//
//  Created by 朱佳男 on 2018/11/23.
//  Copyright © 2018 xfkeji_yongbing. All rights reserved.
//

#import "AppDelegate+RCIM.h"
#import "YBTabbarViewController.h"
#import "YBLoginViewController.h"
#import "YBTabbarViewController.h"
#define RONGCLOUD_IM_APPKEY @"n19jmcy5n8269"

@implementation AppDelegate (RCIM)

-(void)setupIMconfiguration
{
    //IM
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    // 注册自定义测试消息
    [[RCIM sharedRCIM] registerMessageType:[RCTextMessage class]];
    
    //设置会话列表头像和会话页面头像
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = NO;
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    //  设置头像为圆形
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    //   设置优先使用WebView打开URL
    //  [RCIM sharedRCIM].embeddedWebViewPreferred = YES;
    
    //设置Log级别，开发阶段打印详细log
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Error;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCKitDispatchMessageNotification object:nil];
    //如果用户已登陆，直接登录融云
    if ([YBUser boolLogin].length>0) {
        [self loginRCloud];
    }
}
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    NSNumber *left = [notification.userInfo objectForKey:@"left"];
    if (0 == left.integerValue) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(1),@(6),@(9)]];

        dispatch_async(dispatch_get_main_queue(),^{
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadMsgCount;
            YBTabbarViewController *tabbarVC = (YBTabbarViewController *)self.window.rootViewController;
            UITabBarItem *item = tabbarVC.tabBar.items[2];
            item.badgeValue = [NSString stringWithFormat:@"%d",unreadMsgCount];
        });
    }
}
- (void)applicationWillResignActive:(UIApplication *)application{
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(1),@(6),@(9)]];
        application.applicationIconBadgeNumber = unreadMsgCount;
    }
}
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    NSLog(@"appdelegate收到新的消息了%@---%@",message.content,message.extra);
    if (message.conversationType == 6) {
        RCTextMessage*textMsg = (RCTextMessage *)message.content;
        NSLog(@"新消息==%@附加消息==%@",textMsg.content,textMsg.extra);
        if ([message.targetId isEqualToString:@"1"]) {
            //任务

        }else if ([message.targetId isEqualToString:@"2"]){
            //系统消息

        }else if ([message.targetId isEqualToString:@"3"]){
            //酒馆消息

        }
    }
}
#pragma mark request
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    RCUserInfo *user = [RCUserInfo new];
    if (userId == nil || [userId length] == 0) {
        user.userId = userId;
        user.portraitUri = @"";
        user.name = @"";
        completion(user);
        return;
    }
    NSDictionary *parameters =@{@"token":USERTOKEN,@"uid":userId};
    [[YBRequestManager sharedYBManager]postWithUrlString:User_GetInfo parameters:parameters success:^(id data) {
        if ([data[@"code"]integerValue] ==0) {
            YBUser *user =[YBUser yy_modelWithDictionary:data[@"data"]];
            NSLog(@"name__________%@",user.name);
            RCUserInfo *_currentUserInfo =[[RCUserInfo alloc] initWithUserId:user.id name:user.name portrait:[NSString stringWithFormat:@"%@%@",HOST,user.head_img]];
            
            completion(_currentUserInfo);
        }
    } failure:^(NSError *error) {
        
    }];
    return;
}
#pragma mark 登陆融云服务器
-(void)loginRCloud
{
    [[RCIM sharedRCIM] connectWithToken:USERRCTOKEN success:^(NSString *userId) {
        NSLog(@"%@",userId);
        //        [self requestuserInfo];
    } error:^(RCConnectErrorCode status) {
        NSLog(@"%ld",(long)status);
    } tokenIncorrect:^{
        
    }];
}
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        //退出登录
        [YBUser setBoolLogin:@""];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPUserTokenKey];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPUserRCTokenKey];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:PREFECTINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[RCIMClient sharedRCIMClient] logout];
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[[self getCurrentVC] navigationController] popToRootViewControllerAnimated:YES];
            YBTabbarViewController *tabbarC = (YBTabbarViewController *)self.window.rootViewController;
            tabbarC.selectedIndex = 0;
            
            YBLoginViewController *loginvc =[[YBLoginViewController alloc]init];
            UINavigationController *nav =  [[UINavigationController alloc]initWithRootViewController:loginvc];
            [[self getCurrentVC] presentViewController:nav animated:YES completion:nil];
        }];
        [alertC addAction:cancelAction];
        [[self getCurrentVC] presentViewController:alertC animated:YES completion:nil];
    }
}
// 获取当前屏幕显示的viewcontroller
-(UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

// 获取根视图
-(UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController])
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    
    if ([rootVC isKindOfClass:[UITabBarController class]])
    {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    else
    {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
