//
//  YBMySetAccountViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySetAccountViewController.h"
#import "YBMySetChangePasswordViewController.h"
#import "YBMySetBindingPhoneViewController.h"
#import "YBMySetMailboxViewController.h"
@interface YBMySetAccountViewController ()

@end

@implementation YBMySetAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
}
#pragma mark - UI
-(void)makeUI{
    UIView *backView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(280));
    [self.view addSubview:backView];
    
    NSArray *arr = @[@"修改登录密码",@"修改绑定手机号",@"修改绑定邮箱"];
    
    for (int i = 0; i < arr.count; i++) {
        if (i > 0) {
            UIView *xianView = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:0 borderColor:nil borderWidth:0];
            xianView.frame = CGRectMake(AdFloat(30), i * AdFloat(90), d_Device_width-AdFloat(60), AdFloat(2));
            [backView addSubview:xianView];
        }
        UIButton *btn = [F_UI SL_UI_Btn:nil Color:nil Font:0 bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:1];
        btn.frame = CGRectMake(0, i*AdFloat(92), d_Device_width, AdFloat(90));
        btn.tag = i + 180;
        [backView addSubview:btn];
        
        UILabel *titleLab = [F_UI SL_UI_Label:arr[i] color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
        titleLab.frame = CGRectMake(AdFloat(30), 0, AdFloat(300), AdFloat(90));
        [btn addSubview:titleLab];
        
        UIImageView *img = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"返回-4 copy 6"] cornerRadius:0];
        img.frame = CGRectMake(d_Device_width-AdFloat(42), AdFloat(34), AdFloat(12), AdFloat(24));
        [btn addSubview:img];
        
        if (i == 1) {
            UILabel *phoneLab = [F_UI SL_UI_Label:self.user.mobile color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
            phoneLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(440), AdFloat(90));
            [btn addSubview:phoneLab];
        }
    }
}
#pragma mark - 修改登录密码/修改绑定手机号/修改绑定邮箱
-(void)btn:(UIButton *)sender{
    if (sender.tag == 180) {
        DBLog(@"------ 修改登录密码 ------");
        YBMySetChangePasswordViewController *vc = [[YBMySetChangePasswordViewController alloc] init];
        vc.title = @"修改密码";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 181){
        DBLog(@"------ 修改绑定手机号 ------");
        YBMySetBindingPhoneViewController *vc = [[YBMySetBindingPhoneViewController alloc] init];
        vc.title = @"修改绑定手机号";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DBLog(@"------ 修改绑定邮箱 ------");
        YBMySetMailboxViewController *vc = [[YBMySetMailboxViewController alloc] init];
        vc.title = @"修改绑定邮箱";
        [self.navigationController pushViewController:vc animated:YES];
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
