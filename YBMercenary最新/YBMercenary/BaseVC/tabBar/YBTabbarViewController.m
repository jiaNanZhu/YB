//
//  YBTabbarViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBTabbarViewController.h"
#import "YBNavigationViewController.h"
#import "YBTabBar.h"
#import "YBHomeViewController.h"
#import "YBPubViewController.h"
//#import "YBMessageViewController.h"
#import "ZJNMessageViewController.h"
#import "YBMyViewController.h"
#import "ZJNChoseTaskTypeView.h"
#import "ChoseTaskTypeView.h"
#import "YBLoginViewController.h"
#import <RongCloudIM/RongIMKit/RCIM.h>
@interface YBTabbarViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) YBHomeViewController *homeVC;
@property (nonatomic, strong) YBPubViewController *pubVC;
@property (nonatomic, strong) ZJNMessageViewController *messageVC;
@property (nonatomic, strong) YBMyViewController *MyVC;

@end

@implementation YBTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置接收消息代理
//    [RCIM sharedRCIM].receiveMessageDelegate = self;
    // Do any additional setup after loading the view.
    [self InitMiddleView];
    [self InitView];
    
    self.delegate = self;
    //去掉黑线
//    self.tabBar.backgroundColor = [UIColor redColor];
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    //添加阴影
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -2);
    self.tabBar.layer.shadowOpacity = 0.3;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    int unread = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(1),@(6),@(9)]];
    UITabBarItem *item = self.tabBar.items[2];
    item.badgeValue = [NSString stringWithFormat:@"%d",unread];
}
- (void)InitMiddleView
{
    YBTabBar *tabBar = [[YBTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    [tabBar setDidMiddBtn:^{
        NSLog(@"------ 点击发布 ------");
        if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
            YBLoginViewController *viewc = [[YBLoginViewController alloc]init];
            YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:viewc];
            [self presentViewController:nav animated:YES completion:nil];
        }else{
            ZJNChoseTaskTypeView *view = [[ZJNChoseTaskTypeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [[UIApplication sharedApplication].delegate.window addSubview:view];
//            ChoseTaskTypeView *view = [[ChoseTaskTypeView alloc]init];
//            [view show];
        }
        
    }];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"%@",[YBUser boolLogin]);
    if (viewController == self.viewControllers[2]||viewController == self.viewControllers[3]) {
        if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
            YBLoginViewController *viewc = [[YBLoginViewController alloc]init];
            YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:viewc];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

- (void)InitView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"首页", @"酒馆", @"消息", @"我的"];
    NSArray *images = @[@"tabbar_home", @"tabbar_pub", @"tabbar_message", @"tabbar_My"];
    NSArray *selectedImages = @[@"tabbar_home_selected", @"tabbar_pub_selected", @"tabbar_message_selected", @"tabbar_my_selected"];
    YBHomeViewController * homeVc = [[YBHomeViewController alloc] init];
    self.homeVC = homeVc;
    YBPubViewController * pubVc = [[YBPubViewController alloc] init];
    self.pubVC = pubVc;
    ZJNMessageViewController * messageVc = [[ZJNMessageViewController alloc] init];
    self.messageVC = messageVc;
    YBMyViewController * myVc = [[YBMyViewController alloc] init];
    self.MyVC = myVc;
    NSArray *viewControllers = @[homeVc, pubVc, messageVc, myVc];
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *childVc = viewControllers[i];
        [self setVC:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)setVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    //设置选中未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor] } forState:UIControlStateNormal]; [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRed:66/255.0 green:162/255.0 blue:248/255.0 alpha:1] } forState:UIControlStateSelected];
    
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    YBNavigationViewController *nav = [[YBNavigationViewController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
}

//- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
//    NSLog(@"收到了新的消息");
//    NSInteger unreadCount = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
//
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        UITabBarItem *item = self.tabBar.items[2];
//        item.badgeValue = [NSString stringWithFormat:@"%ld",unreadCount];
//    });
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
