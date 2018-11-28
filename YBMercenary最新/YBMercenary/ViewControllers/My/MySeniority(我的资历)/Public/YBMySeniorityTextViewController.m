//
//  YBMySeniorityTextViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/29.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMySeniorityTextViewController.h"

@interface YBMySeniorityTextViewController ()<UITextViewDelegate>
{
    NSArray *titleArr;
    UITextView *_contentTextView;
    UILabel *_placeHolderLabel;
}
@end

@implementation YBMySeniorityTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArr = @[@"请输入特长",@"请输入您的自我介绍"];
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
    
    if (_contentTextView.text.length<=0) {
        [DWBToast showCenterWithText:@"内容不能为空"];
    }
   else if (_contentTextView.text.length>=25) {
       [DWBToast showCenterWithText:@"最多可输入25个字符"];
    }
   else{
       [self requestUserCenter_set_zili];
       
   }
    
}
#pragma mark - UI
-(void)makeUI{
    
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(386));
    [self.view addSubview:backdropView];
    
    _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, d_Device_width, 386)];
    _contentTextView.backgroundColor = [UIColor whiteColor];
    _contentTextView.delegate = self;
    _contentTextView.returnKeyType = UIReturnKeyDone;
    _contentTextView.font = [UIFont systemFontOfSize:16];
    [backdropView addSubview:_contentTextView];
    
    _placeHolderLabel = [[UILabel alloc]init];
    _placeHolderLabel.frame = CGRectMake(5, 8, d_Device_width-20, 20);
    _placeHolderLabel.text = titleArr[_type-1];
    _placeHolderLabel.enabled = NO;
    _placeHolderLabel.backgroundColor = [UIColor clearColor];
    _placeHolderLabel.font = [UIFont systemFontOfSize:16];
    [_contentTextView addSubview:_placeHolderLabel];
}
#pragma mark -- UITextFieldDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([_contentTextView isFirstResponder])
    {
        [_contentTextView resignFirstResponder];
    }
}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeHolderLabel.text = titleArr[_type-1];
    }else{
        _placeHolderLabel.text = @"";
    }
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
        parameters=@{@"token":USERTOKEN,@"speciality":_contentTextView.text};
        
    }
    else{
        parameters =@{@"token":USERTOKEN,@"introduce":_contentTextView.text};
        
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
