//
//  ZJNADDBankCardViewController.m
//  YBMercenary
//
//  Created by JW on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNADDBankCardViewController.h"
#import "ZJNABankCardInfoViewController.h"
@interface ZJNADDBankCardViewController ()
{
    UITextField *textField_1;
    UITextField *textField_2;
    UITextField *textField_3;
    UITextField *textField_4;
    
    NSArray * _nameArray;
    
    UILabel *lab_text;
}
@end

@implementation ZJNADDBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hex:@"F2F2F2"];
    self.title=@"添加银行卡";
    
    [self makeUI];
    
}

-(void)makeUI
{
    
    
    
    UILabel *tiplab = [F_UI SL_UI_Label:@"请绑定持卡人本人的银行卡" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(13*2) numberOfLines:1];
    tiplab.frame = CGRectMake(AdFloat(30), AdFloat(10*2), AdFloat(300*2), AdFloat(20*2));
    
    [self.view addSubview:tiplab];
    
    UIView *backView_1 = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backView_1.frame = CGRectMake(0, AdFloat(40*2), d_Device_width, AdFloat(184));
    [self.view addSubview:backView_1];
    UILabel *lab_3 = [F_UI SL_UI_Label:@"持卡人" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_3.frame = CGRectMake(AdFloat(30), 0, AdFloat(250), AdFloat(91));
    [backView_1 addSubview:lab_3];
    
    UILabel *lab_4 = [F_UI SL_UI_Label:@"卡号" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_4.frame = CGRectMake(AdFloat(30), AdFloat(94), AdFloat(250), AdFloat(91));
    [backView_1 addSubview:lab_4];
    textField_2 = [F_UI SL_UI_Field:@"请输入真实姓名" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_2.frame = CGRectMake(AdFloat(150), 0, AdFloat(500), AdFloat(91));
    [backView_1 addSubview:textField_2];
    
    textField_3 = [F_UI SL_UI_Field:@"请输入卡号" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_3.frame = CGRectMake(AdFloat(150), AdFloat(93), AdFloat(500), AdFloat(91));
    
    textField_3.keyboardType=UIKeyboardTypeASCIICapableNumberPad;
    [backView_1 addSubview:textField_3];
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeSystem];
    submit.backgroundColor=[UIColor hex:@"0386FF"];
    submit.frame=CGRectMake(AdFloat(15*2), backView_1.maxY+AdFloat(45*2), kScreenWidth-AdFloat(30*2), 45);
    submit.clipsToBounds=YES;
    submit.layer.cornerRadius=45/2.f;
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setTitle:@"下一步" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}

-(void)submitclick
{
    
    ZJNABankCardInfoViewController *vc =[[ZJNABankCardInfoViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
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
