//
//  YBMYSeniorityIDCardViewController.m
//  YBMercenary
//
//  Created by JW on 2018/7/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMYSeniorityIDCardViewController.h"

@interface YBMYSeniorityIDCardViewController ()

{
    UITextField *textField;
    NSArray *titleArr;
}

@end

@implementation YBMYSeniorityIDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArr = @[@"请输身份证号"];
    [self nav];
    [self makeUI];
}
#pragma mark - NAV
-(void)nav{
    UIButton *rightBtn = [F_UI SL_UI_Btn:@"保存" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(rightBtn) cornerRadius:0];
    rightBtn.frame = CGRectMake(0, 0, AdFloat(80), AdFloat(30));
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}
#pragma mark - 保存
-(void)rightBtn{
    DBLog(@"------ 保存 ------");
    
    if (textField.text.length<=0 || textField.text.length>18) {
         [DWBToast showCenterWithText:@"最多可输入18个字符"];
    }
    else{
        
        if ([self.delegate respondsToSelector:@selector(saveidcardnum:)]) {
            [self.delegate saveidcardnum:textField.text];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
-(void)makeUI{
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(90));
    [self.view addSubview:backdropView];
    
    textField = [F_UI SL_UI_Field:titleArr[0] font:AdFloat(30) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField.frame = CGRectMake(AdFloat(30), 0, d_Device_width-AdFloat(60), AdFloat(90));
    textField.delegate = self;

//    textField.keyboardType=UIKeyboardTypeNumberPad;
    [backdropView addSubview:textField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
