//
//  YBMySetMailboxViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/5/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySetMailboxViewController.h"

@interface YBMySetMailboxViewController ()
{
    UITextField *textField;
}
@end

@implementation YBMySetMailboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
}
-(void)makeUI{
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(90));
    [self.view addSubview:backdropView];
    
    textField = [F_UI SL_UI_Field:@"请输入邮箱" font:AdFloat(30) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField.frame = CGRectMake(AdFloat(30), 0, d_Device_width-AdFloat(60), AdFloat(90));
    [backdropView addSubview:textField];
    
    UIButton *affirmBtn = [F_UI SL_UI_Btn:@"提交" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(affirmBtn) cornerRadius:AdFloat(45)];
    affirmBtn.frame = CGRectMake(AdFloat(60),backdropView.maxY+AdFloat(100), d_Device_width-AdFloat(120), AdFloat(90));
    [affirmBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
    [self.view addSubview:affirmBtn];
    
}
-(void)affirmBtn{
    
    if (textField.text.length<=0) {
        [DWBToast showCenterWithText:@"请输入邮箱"];
    }
    else{
        NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
        BOOL valid = [pre evaluateWithObject:textField.text];
        if (valid) {
            [self requestUserCenter_setinfowithmail:textField.text];
        }else{
            [DWBToast showCenterWithText:@"请输入有效邮箱"];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark request
#pragma mark 基本信息设置
-(void)requestUserCenter_setinfowithmail:(NSString *)mail
{
    
    NSDictionary *parameters=@{@"token":USERTOKEN,@"mail":mail};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_setinfo parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            [DWBToast showCenterWithText:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end
