//
//  ZJNBankCardViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNBankCardViewController.h"
#import "ZJNBankCardCell.h"
#import "ZJNBankCardtableFootView.h"
#import "ZJNADDBankCardViewController.h"
@interface ZJNBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)ZJNBankCardtableFootView *footView;


@end

@implementation ZJNBankCardViewController
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView  alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        
        _tableView.contentInset=UIEdgeInsetsMake(-35+10, 0, 0, 0);
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=self.footView;
        [_tableView  registerClass:[ZJNBankCardCell class] forCellReuseIdentifier:@"ZJNBankCardCell"];
        
    }
    
    return _tableView;
}
-(ZJNBankCardtableFootView *)footView
{
    if (!_footView) {
        _footView=[[ZJNBankCardtableFootView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, AdFloat(110*2))];
        
        _footView.delegate=self;
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(70*2);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ZJNBankCardCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ZJNBankCardCell" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellAccessoryNone;
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)addcard
{
    ZJNADDBankCardViewController *vc =[[ZJNADDBankCardViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
