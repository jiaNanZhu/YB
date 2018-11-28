//
//  YBMySetImportViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySetImportViewController.h"

@interface YBMySetImportViewController ()<UITextFieldDelegate>
{
    UITextField *textField;
    NSArray *titleArr;
}
@end

@implementation YBMySetImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArr = @[@"请输入昵称",@"请输入姓名",@"请输入年龄，例如18"];
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
    
    
    if (self.type == 1) {
        if (textField.text.length <=0) {
           [DWBToast showCenterWithText:@"请输入昵称"];
        }
        else if (textField.text.length>=6)
        {
            [DWBToast showCenterWithText:@"不得超过6位字符"];
        }
        else{
            [self requestUserCenter_setinfo];
        }
    }
    else if (self.type == 2) {
        if (textField.text.length <=0) {
            [DWBToast showCenterWithText:@"请输入姓名"];
        }
        else if (textField.text.length>=6)
        {
            [DWBToast showCenterWithText:@"不得超过6位字符"];
        }
        else{
            [self requestUserCenter_setinfo];
        }
    }
    else{
       [self requestUserCenter_setinfo];
    }
    
}
-(void)makeUI{
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(90));
    [self.view addSubview:backdropView];
    
    textField = [F_UI SL_UI_Field:titleArr[_type-1] font:AdFloat(30) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField.frame = CGRectMake(AdFloat(30), 0, d_Device_width-AdFloat(60), AdFloat(90));
    if (_type == 3) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    textField.delegate = self;
    [backdropView addSubview:textField];
    
    UILabel *hintLab = [F_UI SL_UI_Label:nil color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(24) numberOfLines:1];
    hintLab.frame = CGRectMake(AdFloat(30), backdropView.maxY+AdFloat(16), d_Device_width-AdFloat(60), AdFloat(30));
    if (_type == 1) {
        hintLab.text = @"4-6个字符，可由中英文、数字组成";
    }else if (_type == 2){
        hintLab.text = @"为了不影响提现，请填写真实姓名";
    }
    [self.view addSubview:hintLab];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark request
#pragma mark 基本信息设置
-(void)requestUserCenter_setinfo
{
    
    NSDictionary *parameters=nil;
    
    switch (_type) {
        case 1:
        {
            parameters=@{@"token":USERTOKEN,@"nick_name":textField.text};
        }
            break;
        case 2:
        {
            parameters=@{@"token":USERTOKEN,@"name":textField.text};;
        }
            break;
        case 3:
        {
            parameters=@{@"token":USERTOKEN,@"age":textField.text};
        }
            break;
            
        default:
            break;
    }
    
   
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_setinfo parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}
@end
