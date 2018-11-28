//
//  YBUserAgreementViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/4/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBUserAgreementViewController.h"

@interface YBUserAgreementViewController ()

@end

@implementation YBUserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self nav];
}
-(void)nav{
    self.navigationItem.title = @"用户服务协议";
    //设置导航背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor hex:@"0386FF"]];
    //设置不透明
    self.navigationController.navigationBar.translucent = NO;
    // 导航栏字体颜色
    NSDictionary * dic=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    self.navigationController.navigationBar.titleTextAttributes=dic;
    
    UIButton *leftBtn = [[UIButton alloc]init];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    
}
#pragma mark - 左
-(void)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
