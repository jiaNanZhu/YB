//
//  YBMySetChangePasswordViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/5/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySetChangePasswordViewController.h"

@interface YBMySetChangePasswordViewController ()
{
    UITextField *textField_1;
    UITextField *textField_2;
    UITextField *textField_3;
    
    UIButton *CAPTCHABtn;
    UIButton *ciphertextBtn;
}
@end

@implementation YBMySetChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
}
#pragma mark - UI
-(void)makeUI{
    UIView *passwordView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    passwordView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(308));
    [self.view addSubview:passwordView];
    
    for (int i = 0; i < 2; i++) {
        UIView *xianView = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:0 borderColor:nil borderWidth:0];
        xianView.frame = CGRectMake(AdFloat(60), AdFloat(100)+i*AdFloat(100), d_Device_width-AdFloat(120), AdFloat(2));
        [passwordView addSubview:xianView];
    }
    UIImageView *phoneIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"login_phone"] cornerRadius:0];
    phoneIMG.frame = CGRectMake(AdFloat(60), AdFloat(24), AdFloat(30), AdFloat(50));
    [passwordView addSubview:phoneIMG];
    
    UIImageView *passIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"login_MM"] cornerRadius:0];
    passIMG.frame = CGRectMake(AdFloat(60), AdFloat(126), AdFloat(34), AdFloat(43));
    [passwordView addSubview:passIMG];
    
    UIImageView *passIMG_1 = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"login_MM"] cornerRadius:0];
    passIMG_1.frame = CGRectMake(AdFloat(60), AdFloat(226), AdFloat(34), AdFloat(43));
    [passwordView addSubview:passIMG_1];
    
    textField_1 = [F_UI SL_UI_Field:@"请输入手机号" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeNumberPad];
    textField_1.frame = CGRectMake(phoneIMG.maxX+AdFloat(20), 0, AdFloat(500), AdFloat(99));
    [passwordView addSubview:textField_1];
    
    textField_2 = [F_UI SL_UI_Field:@"请输入验证码" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeNumberPad];
    textField_2.frame = CGRectMake(phoneIMG.maxX+AdFloat(20), AdFloat(100), AdFloat(400), AdFloat(99));
    [passwordView addSubview:textField_2];
    
    CAPTCHABtn = [F_UI SL_UI_Btn:@"获取验证码" Color:[UIColor hex:@"666666"] Font:AdFloat(28) bgimage:nil selecteImage:nil target:self action:@selector(CAPTCHABtn) cornerRadius:0];
    CAPTCHABtn.frame = CGRectMake(d_Device_width-AdFloat(205), AdFloat(100), AdFloat(150), AdFloat(99));
    [passwordView addSubview:CAPTCHABtn];
    
    textField_3 = [F_UI SL_UI_Field:@"请输入6~20位密码" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:YES keyBoardStyle:UIKeyboardTypeASCIICapable];
    textField_3.frame = CGRectMake(phoneIMG.maxX+AdFloat(20), AdFloat(200), AdFloat(400), AdFloat(99));
    [passwordView addSubview:textField_3];
    
    ciphertextBtn = [F_UI SL_UI_Btn:nil Color:nil Font:0 bgimage:nil selecteImage:nil target:self action:@selector(ciphertextBtn:) cornerRadius:0];
    [ciphertextBtn setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
    ciphertextBtn.selected = YES;
    ciphertextBtn.frame = CGRectMake(d_Device_width-AdFloat(104), AdFloat(236), AdFloat(44), AdFloat(28));
    [passwordView addSubview:ciphertextBtn];
    
    UIButton *affirmBtn = [F_UI SL_UI_Btn:@"提交" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(affirmBtn) cornerRadius:AdFloat(45)];
    affirmBtn.frame = CGRectMake(AdFloat(60),passwordView.maxY+AdFloat(100), d_Device_width-AdFloat(120), AdFloat(90));
    [affirmBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
    [self.view addSubview:affirmBtn];
}
#pragma mark - 密文
-(void)ciphertextBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        textField_3.secureTextEntry = YES;
        [ciphertextBtn setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
    }else{
        [ciphertextBtn setImage:[UIImage imageNamed:@"眼睛-2 copy 2"] forState:UIControlStateNormal];
        textField_3.secureTextEntry = NO;
    }
}
#pragma mark - 发送验证码
-(void)CAPTCHABtn{
    
    if (textField_1.text.length<=0) {
        [DWBToast showCenterWithText:@"请输入手机号"];
    }else if (![Utile isPhone:textField_1.text]){
        [DWBToast showCenterWithText:@"请输入有效手机号"];
    }
    else{
        
        //设置60秒倒计时
        __block UIButton *button = CAPTCHABtn;
        __block NSInteger time = 59; //倒计时时间
        //全局并行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(time <= 0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置按钮的样式
                    [button setTitle:@"重新发送" forState:UIControlStateNormal];
                    button.userInteractionEnabled = YES;
                });
            }else{
                int seconds = time % 60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置按钮显示读秒效果
                    [button setTitle:[NSString stringWithFormat:@"%.2dS", seconds] forState:UIControlStateNormal];
                    button.userInteractionEnabled = NO;
                });
                time--;
            }
        });
        dispatch_resume(_timer);

        [self getCode];
    }
    
}
-(void)getCode{
    NSDictionary *signDict=@{@"mobile":textField_1.text};
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:signDict];
    [parameters setObject:[SignTool signStr:signDict] forKey:@"signature"];
    [[YBRequestManager sharedYBManager] postWithUrlString:sendsms parameters:parameters success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            [DWBToast showCenterWithText:@"验证码已发送至您手机"];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        DBLog(@"连接服务器失败");
        [DWBToast showCenterWithText:@"连接服务器失败"];
    }];
}

#pragma mark - 提交
-(void)affirmBtn{
    
    if (textField_1.text.length<=0) {
        
        
        [DWBToast showCenterWithText:@"请输入手机号"];
    }
    else if(textField_2.text.length<=0)
    {
        
       
            [DWBToast showCenterWithText:@"请输入验证码"];
        
    }
    else if (textField_3.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入密码"];
    }
    
    else{
        
    [self request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  重置密码
-(void)request
{
    
    NSDictionary *signDict=@{@"mobile":textField_1.text,@"code":textField_2.text,@"pwd":textField_3.text};
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:signDict];
    
    [parameters setObject:[SignTool signStr:signDict] forKey:@"signature"];
    
    [[YBRequestManager sharedYBManager]postWithUrlString:Resetpwd parameters:parameters success:^(id data) {
        
        if ([data[@"code"] integerValue] ==0) {
            
            NSString*token=data[@"data"][@"token"];
            
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:APPUserTokenKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
