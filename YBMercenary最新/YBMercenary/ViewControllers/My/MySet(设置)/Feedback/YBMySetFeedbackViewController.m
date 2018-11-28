//
//  YBMySetFeedbackViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySetFeedbackViewController.h"
@interface YBMySetFeedbackViewController ()

{
    UITextField *textField_1;
    UITextField *textField_2;
    UITextField *textField_3;
    UITextField *textField_4;
    
    NSArray * _nameArray;
    
    UILabel *lab_text;
}
@end

@implementation YBMySetFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
}

-(void)makeUI{
    //1
    UIView *backView_1 = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backView_1.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(184));
    [self.view addSubview:backView_1];
    
    UIView *xianView_1 = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:0 borderColor:nil borderWidth:0];
    xianView_1.frame = CGRectMake(AdFloat(30), AdFloat(91), d_Device_width-AdFloat(60), AdFloat(2));
    [backView_1 addSubview:xianView_1];
    
    UILabel *lab_1 = [F_UI SL_UI_Label:@"请选择反馈类型" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_1.frame = CGRectMake(AdFloat(30), 0, AdFloat(250), AdFloat(91));
   
    [backView_1 addSubview:lab_1];
   
    lab_text = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_text.frame = CGRectMake(d_Device_width-AdFloat(42)-AdFloat(150)-10, 0, AdFloat(150), AdFloat(91));
    lab_text.textAlignment=NSTextAlignmentRight;
    [backView_1 addSubview:lab_text];
    
    
    UIView *view =[UIView new];
    view.frame=CGRectMake(0, 0, kScreenWidth, AdFloat(91));
    [backView_1 addSubview:view];
    
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    re.numberOfTapsRequired = 1;
    [view addGestureRecognizer:re];
    

    
    
    UILabel *lab_2 = [F_UI SL_UI_Label:@"问题反馈" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_2.frame = CGRectMake(AdFloat(30), AdFloat(94), AdFloat(250), AdFloat(91));
    [backView_1 addSubview:lab_2];
    
    UIImageView *img = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"返回-4 copy 6"] cornerRadius:0];
    img.frame = CGRectMake(d_Device_width-AdFloat(42), AdFloat(33), AdFloat(12), AdFloat(24));
    [backView_1 addSubview:img];
    
    textField_1 = [F_UI SL_UI_Field:@"请填写您的问题" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_1.frame = CGRectMake(AdFloat(280), AdFloat(93), AdFloat(500), AdFloat(91));
    [backView_1 addSubview:textField_1];
    
    //2
    UIView *backView_2 = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backView_2.frame = CGRectMake(0,backView_1.maxY+AdFloat(16), d_Device_width, AdFloat(184));
    [self.view addSubview:backView_2];
    
    UIView *xianView_2 = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:0 borderColor:nil borderWidth:0];
    xianView_2.frame = CGRectMake(AdFloat(30), AdFloat(91), d_Device_width-AdFloat(60), AdFloat(2));
    [backView_2 addSubview:xianView_2];
    
    UILabel *lab_3 = [F_UI SL_UI_Label:@"姓名" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_3.frame = CGRectMake(AdFloat(30), 0, AdFloat(250), AdFloat(91));
    [backView_2 addSubview:lab_3];
    
    UILabel *lab_4 = [F_UI SL_UI_Label:@"手机号/邮箱/QQ" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab_4.frame = CGRectMake(AdFloat(30), AdFloat(94), AdFloat(250), AdFloat(91));
    [backView_2 addSubview:lab_4];
    
    textField_2 = [F_UI SL_UI_Field:@"请输入您的姓名" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_2.frame = CGRectMake(AdFloat(280), 0, AdFloat(500), AdFloat(91));
    [backView_2 addSubview:textField_2];
    
    textField_3 = [F_UI SL_UI_Field:@"请输入手机号/邮箱/QQ" font:AdFloat(28) textAlignment:NSTextAlignmentLeft borderStyle:UITextBorderStyleNone clearOnBeginEditing:YES secure:NO keyBoardStyle:UIKeyboardTypeDefault];
    textField_3.frame = CGRectMake(AdFloat(280), AdFloat(93), AdFloat(500), AdFloat(91));
    [backView_2 addSubview:textField_3];
    
    
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeSystem];
    submit.backgroundColor=[UIColor hex:@"0386FF"];
    submit.frame=CGRectMake(AdFloat(15*2), backView_2.maxY+AdFloat(45*2), kScreenWidth-AdFloat(30*2), 45);
    submit.clipsToBounds=YES;
    submit.layer.cornerRadius=45/2.f;
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 选择反馈类型
-(void)doTapChange:(UITapGestureRecognizer *)sender
{
    [BRStringPickerView showStringPickerWithTitle:@"反馈类型" dataSource:@[@"产品体验", @"产品功能", @"任务发布", @"任务类型", @"保证金", @"其他"] defaultSelValue:@"产品体验" resultBlock:^(id selectValue) {
        
        lab_text.text=selectValue;
    }];
}
-(void)submitclick
{
    if (lab_text.text.length<=0) {
        [DWBToast showCenterWithText:@"请选择反馈类型"];
    }
    else if (textField_1.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请填写您的问题"];
    }
    else if (textField_2.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入您的姓名"];
    }
    else if (textField_3.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入手机号/邮箱/QQ"];
    }
    else{
       [self requestuserInfo];
    }
//
}
#pragma mark request
#pragma mark 问题反馈提交
-(void)requestuserInfo
{
    NSDictionary *parameters =@{@"token":USERTOKEN,@"type":lab_text.text,@"content":textField_1.text,@"name":textField_2.text,@"contact":textField_3.text};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_getinfo parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
           
            [DWBToast showCenterWithText:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}
@end
