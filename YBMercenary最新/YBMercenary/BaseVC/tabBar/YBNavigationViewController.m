//
//  YBNavigationViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBNavigationViewController.h"

@interface YBNavigationViewController ()<UINavigationBarDelegate,UINavigationControllerDelegate>

@end

@implementation YBNavigationViewController
+(void)load{
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置不透明
    bar.translucent = NO;
    //设置导航背景颜色
    [bar setBarTintColor:[UIColor hex:@"0386FF"]];
    // 导航栏字体颜色
    NSDictionary * dic=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    bar.titleTextAttributes=dic;
    bar.tintColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.title = @"";
}
- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        //设置返回按钮
        UIBarButtonItem *popToPreButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popToBack)];
        viewController.navigationItem.leftBarButtonItem = popToPreButton;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}
#pragma mark --------navigation delegate
//该方法可以解决popRootViewController时tabbar的bug
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews)
    {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBar removeFromSuperview];
        }
    }

}
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
