//
//  YBMySeniorityPublicViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/29.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySeniorityPublicViewController.h"

@interface YBMySeniorityPublicViewController ()<UITextFieldDelegate>
{
    UITextField *textField;
    NSArray *titleArr;
}

@end

@implementation YBMySeniorityPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArr = @[@"请输入行业",@"请输入工作年限"];
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
    
    if (textField.text.length<=0) {
       [DWBToast showCenterWithText:titleArr[_type-1]];
    }
    else if (textField.text.length>=10)
    {
        [DWBToast showCenterWithText:@"最多可输入10个字符"];
    }
    else{
       [self requestUserCenter_set_zili];
    }
    
}
-(void)makeUI{
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(90));
    [self.view addSubview:backdropView];
    
    textField = [F_UI SL_UI_Field:titleArr[_type-1] font:AdFloat(30) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField.frame = CGRectMake(AdFloat(30), 0, d_Device_width-AdFloat(60), AdFloat(90));
    textField.delegate = self;
    if (_type ==2) {
        textField.keyboardType=UIKeyboardTypeNumberPad;
    }
    [backdropView addSubview:textField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark request
#pragma mark
-(void)requestUserCenter_set_zili
{
    NSDictionary *parameters;
    if (_type ==1) {
        parameters=@{@"token":USERTOKEN,@"industry":textField.text};
        
    }
    else{
       parameters =@{@"token":USERTOKEN,@"workyear":textField.text};
        
    }
    
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_set_zili parameters:parameters success:^(id data) {
        
        
        //        [self.dataArr removeAllObjects];
        if ([data[@"code"]integerValue] ==0) {
            
           
            [DWBToast showCenterWithText:@"保存成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        else if ([data[@"code"]integerValue] ==1)
        {
            
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
