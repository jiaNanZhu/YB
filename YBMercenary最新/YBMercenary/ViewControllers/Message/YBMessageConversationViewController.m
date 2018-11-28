//
//  YBMessageConversationViewController.m
//  YBMercenary
//
//  Created by JW on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMessageConversationViewController.h"
#import "YBMessageQueryViewController.h"
@interface YBMessageConversationViewController ()
{
    UIButton *button ;
}
@end

@implementation YBMessageConversationViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.chatSessionInputBarControl.switchButton removeFromSuperview];
    [self.chatSessionInputBarControl.emojiButton removeFromSuperview];

    [self.chatSessionInputBarControl.additionalButton removeFromSuperview];
    
    [self.chatSessionInputBarControl.pluginBoardView removeFromSuperview];
    [self.chatSessionInputBarControl.emojiBoardView removeFromSuperview];
    
    self.chatSessionInputBarControl.inputTextView.frame =CGRectMake(15, 10, kScreenWidth-15-10-80, self.chatSessionInputBarControl.inputTextView.bounds.size.height);
    
    button =[UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(sendclick) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.chatSessionInputBarControl.inputTextView.text.length<=0) {
        button.backgroundColor=[UIColor lightGrayColor];
    }
    else{
        button.backgroundColor=[UIColor hex:Blue_Color];
    }
    
    [self.chatSessionInputBarControl addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(80);
        make.centerY.equalTo(self.chatSessionInputBarControl.inputTextView.mas_centerY);
        make.height.mas_equalTo(self.chatSessionInputBarControl.inputTextView.height);
        make.right.equalTo(self.chatSessionInputBarControl.mas_right).offset(-5);
        
    }];
    
    
    [self nav];
    
}
#pragma mark - NAV
-(void)nav{
    UIButton *rightBtn = [F_UI SL_UI_Btn:@"..." Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(rightBtn) cornerRadius:0];
    rightBtn.frame = CGRectMake(0, 0, AdFloat(80), AdFloat(30));
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)rightBtn
{
    
    YBMessageQueryViewController *vc =[[YBMessageQueryViewController alloc]init];
    vc.targetId=self.targetId;
    
    vc.model=self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)sendclick
{
    RCTextMessage *msg = [RCTextMessage messageWithContent:self.chatSessionInputBarControl.inputTextView.text];
    [self sendMessage:msg pushContent:@"您有一条新消息"];
    self.chatSessionInputBarControl.inputTextView.text=@"";
    button.enabled=NO;
    button.backgroundColor=[UIColor lightGrayColor];
}

- (void)inputTextView:(UITextView *)inputTextView
shouldChangeTextInRange:(NSRange)range
      replacementText:(NSString *)text
{
    if ((range.location==0 && range.length==1 && [text isEqualToString:@""]) || (range.location==0 && range.length==0 && [text isEqualToString:@""]) || [text isEqualToString:@"\n"]) {
        button.enabled=NO;
        button.backgroundColor=[UIColor lightGrayColor];
        
    }
    else{
        button.enabled=YES;
        button.backgroundColor=[UIColor hex:Blue_Color];
    }
}

//- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent
//{
//    messageContent.senderUserInfo=[[RCUserInfo alloc] initWithUserId:self.model.touserid name:self.model.touser_name portrait:[NSString stringWithFormat:@"%@%@",HOST,self.model.touserhead_img]];
//
//    return  messageContent;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)didSendMessage:(NSInteger)status content:(RCMessageContent *)messageContent
//{
//    if (status == 0) {
//        if ([messageContent isKindOfClass:[RCTextMessage class]]) {

//            RCTextMessage  *content= (RCTextMessage *)messageContent;
            
//            [self UserCenter_message_addcontent:content.content];
//        }
//    }
//}
#pragma mark request
//#pragma mark
//-(void)UserCenter_message_addcontent:(NSString *)content
//{
//    //
//    NSDictionary *parameters =@{@"token":USERTOKEN,@"toUserId":self.targetId,@"objectName":@"TxtMsg",@"content":content};//USERTOKEN
//    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_message_add parameters:parameters success:^(id data) {
//        
//        if ([data[@"code"]integerValue] ==0) {
//            
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}


@end
