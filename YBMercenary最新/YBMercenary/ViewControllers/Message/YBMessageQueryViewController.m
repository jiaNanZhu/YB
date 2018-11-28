//
//  YBMessageQueryViewController.m
//  YBMercenary
//
//  Created by JW on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMessageQueryViewController.h"
#import "YBMessageSearchViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <RongCloudIM/RongIMKit/RCIM.h>
@interface YBMessageQueryViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation YBMessageQueryViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView  alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
                _tableView.delegate=self;
                _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        
        self.tableView.contentInset=UIEdgeInsetsMake(-35+10, 0, 0, 0);
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
        [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"信息查询";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    
    
    self.dataArr =[[NSMutableArray alloc]initWithArray:@[@{@"text":@"清空聊天记录"},@{@"text":@"获取全部聊天记录"}]];
    
    
}
#pragma mark - TableView DataSource


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellAccessoryNone;
    if (indexPath.section==0) {
        cell.textLabel.text=@"查找聊天记录";
    }
    else{
        cell.textLabel.text=self.dataArr[indexPath.row][@"text"];
    }
    
        return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YBMessageSearchViewController *vc =[[YBMessageSearchViewController alloc]init];
        vc.targetId=self.targetId;
        vc.model=self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        if (indexPath.row == 0) {
           
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"是否确认所有聊天记录?"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:@"取消", nil];
            
            
           
            alert.tag = 11111;
            [alert show];
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"聊天信息以获取,是否去查看?"
                                                           delegate:self
                                                  cancelButtonTitle:@"去查看"
                                                  otherButtonTitles:@"取消", nil];
            alert.tag = 22222;
            [alert show];
            
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==11111) {
        if (buttonIndex == 0) {
            
            [[RCIMClient sharedRCIMClient]clearRemoteHistoryMessages:ConversationType_PRIVATE targetId:self.targetId recordTime:0 success:^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                [DWBToast showCenterWithText:@"清除聊天记录成功！"];
                    
                });
                
            } error:^(RCErrorCode status) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                [DWBToast showCenterWithText:@"清除聊天记录失败！"];
                
               });
            }];
        
        
        }
            
            
            
            
        
    }
    else{
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
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
