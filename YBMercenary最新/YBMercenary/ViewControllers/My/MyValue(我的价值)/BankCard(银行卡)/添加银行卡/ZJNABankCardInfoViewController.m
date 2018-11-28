//
//  ZJNABankCardInfoViewController.m
//  YBMercenary
//
//  Created by JW on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNABankCardInfoViewController.h"
#import "YBUserAgreementViewController.h"
#import "SpecialAlertView.h"
@interface ZJNABankCardInfoViewController ()
{
    UITextField *textField_1;
    UITextField *textField_2;
    UITextField *textField_3;
    UITextField *textField_4;
    
    NSArray * _nameArray;
    
    UILabel *lab_text;
}
@end

@implementation ZJNABankCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor hex:@"F2F2F2"];
    self.title=@"填写银行卡信息";
    
    [self makeUI];
}
-(void)makeUI
{
    
    
    UIView *backView_1 = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backView_1.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(184));
    [self.view addSubview:backView_1];
    
    
    
    UIView *view =[UIView new];
    view.frame=CGRectMake(0, 0, kScreenWidth, AdFloat(91));
    [backView_1 addSubview:view];
    
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    re.numberOfTapsRequired = 1;
    [view addGestureRecognizer:re];
    
    
    UILabel *lab_3 = [F_UI SL_UI_Label:@"卡类型" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_3.frame = CGRectMake(AdFloat(30), 0, AdFloat(250), AdFloat(91));
    [backView_1 addSubview:lab_3];
    
    UILabel *lab_4 = [F_UI SL_UI_Label:@"手机号" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_4.frame = CGRectMake(AdFloat(30), AdFloat(94), AdFloat(250), AdFloat(91));
    [backView_1 addSubview:lab_4];
    textField_2 = [F_UI SL_UI_Field:@"请选择银行卡类型" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_2.frame = CGRectMake(AdFloat(150), 0, AdFloat(500), AdFloat(91));
    textField_2.userInteractionEnabled=NO;
    [backView_1 addSubview:textField_2];
    
    
    UIImageView *img = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"返回-4 copy 6"] cornerRadius:0];
    img.frame = CGRectMake(d_Device_width-AdFloat(42), AdFloat(33), AdFloat(12), AdFloat(24));
    [backView_1 addSubview:img];
    
    textField_3 = [F_UI SL_UI_Field:@"请输入银行预留手机号" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_3.frame = CGRectMake(AdFloat(150), AdFloat(93), AdFloat(500), AdFloat(91));
    
    
    UIButton *tipbtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    tipbtn.tintColor=[UIColor orangeColor];
    tipbtn.frame = CGRectMake(d_Device_width-AdFloat(42)-AdFloat(15), AdFloat(94+33), AdFloat(24), AdFloat(24));
    
    [tipbtn addTarget:self action:@selector(clicktip) forControlEvents:UIControlEventTouchUpInside];
    [backView_1 addSubview:tipbtn];
    
    
    textField_3.keyboardType=UIKeyboardTypeASCIICapableNumberPad;
    [backView_1 addSubview:textField_3];
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeSystem];
    submit.backgroundColor=[UIColor hex:@"0386FF"];
    submit.frame=CGRectMake(AdFloat(15*2), backView_1.maxY+AdFloat(45*2), kScreenWidth-AdFloat(30*2), 45);
    submit.clipsToBounds=YES;
    submit.layer.cornerRadius=45/2.f;
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setTitle:@"完成" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    
    
    UIButton *selectedBtn = [F_UI SL_UI_Btn:nil Color:nil Font:0 bgimage:nil selecteImage:nil target:self action:@selector(selectedBtn:) cornerRadius:0];
    [selectedBtn setImage:[UIImage imageNamed:@"选择-3 copy"] forState:UIControlStateNormal];
    selectedBtn.selected = YES;
    selectedBtn.frame = CGRectMake(AdFloat(15*2), backView_1.maxY+AdFloat(20), AdFloat(26), AdFloat(26));
    [self.view addSubview:selectedBtn];
    
    UILabel *lab_1 = [F_UI SL_UI_Label:@"已阅读并同意" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(26) numberOfLines:1];
    lab_1.frame = CGRectMake(selectedBtn.maxX+AdFloat(12), backView_1.maxY+AdFloat(20), AdFloat(170), AdFloat(26));
    [self.view addSubview:lab_1];
    
    UIButton *userAgreementBtn = [F_UI SL_UI_Btn:@"《用户协议》" Color:[UIColor hex:@"0386FF"] Font:AdFloat(26) bgimage:nil selecteImage:nil target:self action:@selector(userAgreementBtn) cornerRadius:0];
    userAgreementBtn.frame = CGRectMake(lab_1.maxX-AdFloat(26), backView_1.maxY+AdFloat(20), AdFloat(216), AdFloat(26));
    [self.view addSubview:userAgreementBtn];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)clicktip
{
    [self.view endEditing:YES];
    SpecialAlertView *special = [[SpecialAlertView alloc]initWithTitleImage:@"chsiHeadericon" messageTitle:@"手机号说明" messageString:@"银行预留的手机号是办理银行卡是所填写的手机号码,没有预留,手机号忘记或者已停用,请联系银行客服更新处理." sureBtnTitle:@"我知道了" sureBtnColor:[UIColor hex:Blue_Color]];
    [special withSureClick:^(NSString *string) {
    
    }];
}

-(void)doTapChange:(UITapGestureRecognizer *)sender
{
    
    
    [self.view endEditing:YES];
    [BRStringPickerView showStringPickerWithTitle:@"请选择卡类型" dataSource:@[@[@"工商银行", @"农业银行", @"邮政银行", @"建设银行", @"招商银行", @"中国银行"],@[@"储蓄卡",@"信用卡"]] defaultSelValue:@"工商银行" resultBlock:^(id selectValue) {
        
        textField_2.text=[NSString stringWithFormat:@"%@-%@",selectValue[0],selectValue[1]];
    }];
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
-(void)submitclick
{
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
