//
//  YBMyValueTXViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMyValueTXViewController.h"

@interface YBMyValueTXViewController ()
{
    UITextField *textField;
}
@end

@implementation YBMyValueTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
}
#pragma mark - UI
-(void)makeUI{
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(182));
    [self.view addSubview:backdropView];
    
    UIView *xianView = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:0 borderColor:nil borderWidth:0];
    xianView.frame = CGRectMake(AdFloat(30), AdFloat(90), d_Device_width-AdFloat(60), AdFloat(2));
    [backdropView addSubview:xianView];
    
    UILabel *titleLab = [F_UI SL_UI_Label:@"提现至" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    titleLab.frame = CGRectMake(AdFloat(30), 0, AdFloat(100), AdFloat(90));
    [backdropView addSubview:titleLab];
    
    UIImageView *img = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"返回-4 copy 6"] cornerRadius:0];
    img.frame = CGRectMake(d_Device_width-AdFloat(42), AdFloat(34), AdFloat(12), AdFloat(24));
    [backdropView addSubview:img];
    
    UIButton *btn = [F_UI SL_UI_Btn:nil Color:nil Font:0 bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:0];
    btn.frame = CGRectMake(0, 0, d_Device_width, AdFloat(90));
    [backdropView addSubview:btn];
    
    UILabel *titleLab_1 = [F_UI SL_UI_Label:@"¥" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(30) numberOfLines:1];
    titleLab_1.frame = CGRectMake(AdFloat(30), AdFloat(92), AdFloat(30), AdFloat(90));
    [backdropView addSubview:titleLab_1];
    
    textField = [F_UI SL_UI_Field:@"请输入提现金额" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeNumberPad];
    textField.frame = CGRectMake(titleLab_1.maxX+AdFloat(6), AdFloat(92), AdFloat(300), AdFloat(90));
    [backdropView addSubview:textField];
    
    UIButton *withdrawBtn = [F_UI SL_UI_Btn:@"提现" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(withdrawBtn) cornerRadius:AdFloat(45)];
    withdrawBtn.frame = CGRectMake(AdFloat(60), backdropView.maxY+AdFloat(100), d_Device_width-AdFloat(120), AdFloat(90));
    [withdrawBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
    [self.view addSubview:withdrawBtn];
}
#pragma mark - 提现至
-(void)btn:(UIButton *)sender{
    
}
#pragma mark - 提现
-(void)withdrawBtn{
    
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textField resignFirstResponder];
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
