//
//  YBRegisterViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/4/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBRegisterViewController.h"
#import "YBUserAgreementViewController.h"
//个人认证
#import "ZJNIndividualCertificationViewController.h"
//企业认证
#import "ZJNCompanyCertificationViewController.h"
#import "ZJNPerfectInfoViewController.h"
@interface YBRegisterViewController ()
{
    UIImageView *xianImg;
    
    UITextField *textField_1;
    UITextField *textField_2;
    UITextField *textField_3;
    
    UIButton *CAPTCHABtn;
    UIButton *ciphertextBtn;
    BOOL  ispersonal;
}
@property(nonatomic,strong)UIView * headView;
@end

@implementation YBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self nav];
    [self makeUI];
}
-(void)nav{
    self.navigationItem.title = @"注册";
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
#pragma mark - UI
-(void)makeUI{
    ispersonal=YES;
//    UIImageView *logoIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"佣兵天下APP图标 Copy 3"] cornerRadius:0];
//    logoIMG.frame = CGRectMake(AdFloat(294), AdFloat(70), AdFloat(164), AdFloat(164));
//    [self.view addSubview:logoIMG];
    
    _headView = [F_UI SL_UI_View:[UIColor clearColor] cornerRadius:0 borderColor:nil borderWidth:0];
    _headView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(100));
    [self.view addSubview:_headView];
    
//    xianImg = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"xianIMG"] cornerRadius:0];
//    xianImg.frame = CGRectMake(AdFloat(148), AdFloat(95), AdFloat(180), AdFloat(5));
//    [_headView addSubview:xianImg];
    
//    NSArray *titleArr = @[@"个人",@"企业"];
//    for (int i = 0; i < titleArr.count; i++) {
//        UIButton *btn = [F_UI SL_UI_Btn:titleArr[i] Color:[UIColor hex:@"666666"] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:0];
//        btn.frame = CGRectMake(AdFloat(148)+i*AdFloat(274), 0, AdFloat(180), AdFloat(100));
//        btn.tag = i+380;
//        [_headView addSubview:btn];
//
//        if (i == 0) {
//            [btn setUserInteractionEnabled:NO];
//            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
//        }
//    }
    
    UIView *registerView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    registerView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(308));
    [self.view addSubview:registerView];
    
    
    for (int i = 0; i < 2; i++) {
        UIView *xianView = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:0 borderColor:nil borderWidth:0];
        xianView.frame = CGRectMake(AdFloat(60), AdFloat(100)+i*AdFloat(100), d_Device_width-AdFloat(120), AdFloat(2));
        [registerView addSubview:xianView];
    }
    UIImageView *phoneIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"login_phone"] cornerRadius:0];
    phoneIMG.frame = CGRectMake(AdFloat(60), AdFloat(24), AdFloat(30), AdFloat(50));
    [registerView addSubview:phoneIMG];
    
    UIImageView *passIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"login_MM"] cornerRadius:0];
    passIMG.frame = CGRectMake(AdFloat(60), AdFloat(126), AdFloat(34), AdFloat(43));
    [registerView addSubview:passIMG];
    
    UIImageView *passIMG_1 = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"login_MM"] cornerRadius:0];
    passIMG_1.frame = CGRectMake(AdFloat(60), AdFloat(226), AdFloat(34), AdFloat(43));
    [registerView addSubview:passIMG_1];
    
    textField_1 = [F_UI SL_UI_Field:@"请输入手机号" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeNumberPad];
    textField_1.frame = CGRectMake(phoneIMG.maxX+AdFloat(20), 0, AdFloat(500), AdFloat(99));
    [registerView addSubview:textField_1];
    
    textField_2 = [F_UI SL_UI_Field:@"请输入验证码" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeNumberPad];
    textField_2.frame = CGRectMake(phoneIMG.maxX+AdFloat(20), AdFloat(100), AdFloat(400), AdFloat(99));
    [registerView addSubview:textField_2];
    
    CAPTCHABtn = [F_UI SL_UI_Btn:@"发送验证码" Color:[UIColor hex:@"666666"] Font:AdFloat(28) bgimage:nil selecteImage:nil target:self action:@selector(CAPTCHABtn) cornerRadius:0];
    CAPTCHABtn.frame = CGRectMake(d_Device_width-AdFloat(205), AdFloat(100), AdFloat(150), AdFloat(99));
    [registerView addSubview:CAPTCHABtn];
    
    textField_3 = [F_UI SL_UI_Field:@"请设置登录密码" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:YES keyBoardStyle:UIKeyboardTypeASCIICapable];
    textField_3.frame = CGRectMake(phoneIMG.maxX+AdFloat(20), AdFloat(200), AdFloat(400), AdFloat(99));
    [registerView addSubview:textField_3];
    
    ciphertextBtn = [F_UI SL_UI_Btn:nil Color:nil Font:0 bgimage:nil selecteImage:nil target:self action:@selector(ciphertextBtn:) cornerRadius:0];
    [ciphertextBtn setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
    ciphertextBtn.selected = YES;
    ciphertextBtn.frame = CGRectMake(d_Device_width-AdFloat(104), AdFloat(236), AdFloat(44), AdFloat(28));
    [registerView addSubview:ciphertextBtn];
    

    
    UIButton *registerBtn = [F_UI SL_UI_Btn:@"完成" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(registerBtn) cornerRadius:AdFloat(45)];
    registerBtn.frame = CGRectMake(AdFloat(60),registerView.maxY+AdFloat(100), d_Device_width-AdFloat(120), AdFloat(90));
//    [registerBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
    [registerBtn setBackgroundImage:SetImage(@"nav") forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    
    UIButton *selectedBtn = [F_UI SL_UI_Btn:nil Color:nil Font:0 bgimage:nil selecteImage:nil target:self action:@selector(selectedBtn:) cornerRadius:0];
    [selectedBtn setImage:[UIImage imageNamed:@"选择-3 copy"] forState:UIControlStateNormal];
    selectedBtn.selected = YES;
    selectedBtn.frame = CGRectMake(AdFloat(174), registerBtn.maxY+AdFloat(20), AdFloat(26), AdFloat(26));
    [self.view addSubview:selectedBtn];
    
    UILabel *lab_1 = [F_UI SL_UI_Label:@"已阅读并同意" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(26) numberOfLines:1];
    lab_1.frame = CGRectMake(selectedBtn.maxX+AdFloat(12), registerBtn.maxY+AdFloat(20), AdFloat(180), AdFloat(26));
    [self.view addSubview:lab_1];
    
    UIButton *userAgreementBtn = [F_UI SL_UI_Btn:@"《用户服务协议》" Color:[UIColor hex:@"0386FF"] Font:AdFloat(26) bgimage:nil selecteImage:nil target:self action:@selector(userAgreementBtn) cornerRadius:0];
    userAgreementBtn.frame = CGRectMake(lab_1.maxX-AdFloat(6), registerBtn.maxY+AdFloat(20), AdFloat(216), AdFloat(26));
    [self.view addSubview:userAgreementBtn];

}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textField_1 resignFirstResponder];
    [textField_2 resignFirstResponder];
    [textField_3 resignFirstResponder];

}
#pragma mark - 选择
-(void)btn:(UIButton *)sender{
    
    if (sender.tag-380 == 0) {
        ispersonal=YES;
    }
    else{
        ispersonal=NO;
    }
//    sender.tag-380==0?ispersonal=YES:ispersonal=NO;
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:(380+i)];
        if (btn.tag == sender.tag) {
            
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                xianImg.frame = CGRectMake(AdFloat(148)+i*i*AdFloat(274), AdFloat(95), AdFloat(180), AdFloat(5));
            }];
            
        }else{
            
            
            [btn setUserInteractionEnabled:YES];
            [btn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
            
        }
    }
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

#pragma mark - 完成/下一步
-(void)registerBtn{
    
    if (textField_1.text.length<=0) {
        
        
        [DWBToast showCenterWithText:@"请输入手机号"];
    }
    else if(textField_2.text.length<=0)
    {
        
        [DWBToast showCenterWithText:@"请输入验证码"];
        
    }
    else if(textField_3.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入登录密码"];
        
    }
    else{
        [self request];
    }
    
}
#pragma mark - 选中
-(void)selectedBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        DBLog(@"1");
        [sender setImage:[UIImage imageNamed:@"选择-3 copy"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"register_bool"] forState:UIControlStateNormal];
        DBLog(@"2");
    }
}
#pragma mark - 用户服务协议
-(void)userAgreementBtn{
    
    YBUserAgreementViewController *vc = [[YBUserAgreementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark  注册
-(void)request
{
    NSDictionary *signDict=nil;
    NSString *url=nil;
    
    if (ispersonal) {
        //个人
        url=Loginbycode;
        signDict  =@{@"mobile":textField_1.text,@"code":textField_2.text,@"pwd":textField_3.text,@"user_type":@(0)};
    }
    else{
        //企业
        url=Login;
      signDict=@{@"mobile":textField_1.text,@"code":textField_2.text,@"pwd":textField_3.text,@"user_type":@(1)};
        
    }
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:signDict];
    
    [parameters setObject:[SignTool signStr:signDict] forKey:@"signature"];
    
    [[YBRequestManager sharedYBManager]postWithUrlString:Regist parameters:parameters success:^(id data) {
        
        if ([data[@"code"] integerValue] ==0) {
            
            NSString*token=data[@"data"][@"token"];
            
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:APPUserTokenKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showAlertController];
//            [self leftBtn];
            
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)showAlertController{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:@"去完善信息" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZJNPerfectInfoViewController *viewC = [[ZJNPerfectInfoViewController alloc]init];
        [self.navigationController pushViewController:viewC animated:NO];
    }];
    [okAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    [actionSheetController addAction:okAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
    
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
