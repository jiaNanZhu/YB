//
//  YBMyAcceptViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyAcceptViewController.h"
#import "YBMyCollectRWTableViewCell.h"
#import "YBMyIssueModel.h"
#import "ZJNSignUpViewController.h"
#import "ZJNWhileTaskViewController.h"
#import "ZJNTaskAuditViewController.h"
#import "ZJNTaskDoneViewController.h"
@interface YBMyAcceptViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *xianImg;
//    int typeBool;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * headView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation YBMyAcceptViewController
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
    [self requestUserCenter_MyTask_publish_lis];
}
#pragma mark - 布局
-(void)makeUI{
    _headView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    _headView.frame = CGRectMake(0, 0, d_Device_width, AdFloat(100));
    [self.view addSubview:_headView];
    
    xianImg = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"xianIMG"] cornerRadius:0];
    xianImg.frame = CGRectMake(0, AdFloat(95), d_Device_width/5, AdFloat(5));
    [_headView addSubview:xianImg];
    
    NSArray *titleArr = @[@"全部",@"已报名",@"任务中",@"审核中",@"已完成"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [F_UI SL_UI_Btn:titleArr[i] Color:[UIColor hex:@"666666"] Font:AdFloat(30) bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:0];
        btn.frame = CGRectMake(i*(d_Device_width/titleArr.count), 0, d_Device_width/titleArr.count, AdFloat(122));
        btn.tag = i+260;
        [_headView addSubview:btn];
        if (self.type == i) {
            xianImg.frame = CGRectMake(i*(d_Device_width/5), AdFloat(95), d_Device_width/5, AdFloat(5));
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
        }
    }
    [self.view addSubview:self.tableView];
}
#pragma mark - 选择
-(void)btn:(UIButton *)sender{
    for (int i = 0; i < 5; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:(260+i)];
        if (btn.tag == sender.tag) {
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                xianImg.frame = CGRectMake(i*(d_Device_width/5), AdFloat(95), d_Device_width/5, AdFloat(5));
            }];
            self.type = i;
            [self.tableView reloadData];
        }else{
            [btn setUserInteractionEnabled:YES];
            [btn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
        }
    }
    
    [self requestUserCenter_MyTask_publish_lis];
}
-(UITableView *)tableView
{
    if (_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headView.maxY+AdFloat(16), kScreenWidth, kScreenHeight-KNavHeight-AdFloat(108))];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[YBMyCollectRWTableViewCell class] forCellReuseIdentifier:@"YBMyCollectRWTableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        
    }
    return _tableView;
}
#pragma mark - 分组cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(220);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyCollectRWTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil){
        cell = [[YBMyCollectRWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMyCollectRWTableViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configurationwithmodel:self.dataArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model = self.dataArr[indexPath.row];
    if ([model.task_status isEqualToString:@"1"]) {
        //已报名
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"2"]){
        //任务中
        ZJNWhileTaskViewController *vc = [[ZJNWhileTaskViewController alloc]initWithTaskType:MyAcceptTask];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"3"]){
        //审核中
        ZJNTaskAuditViewController *vc = [[ZJNTaskAuditViewController alloc]initWithTaskType:MyAcceptTaskAudit];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //6 已完成
        ZJNTaskDoneViewController *vc = [[ZJNTaskDoneViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark request
-(void)requestUserCenter_MyTask_publish_lis
{
    NSInteger task_status=self.type;
    if (self.type ==4) {
        task_status = 6;
    }
    NSDictionary *parameters =@{@"token":USERTOKEN,@"pageNum":@(1),@"pageSize":@(10),@"task_status":@(task_status)};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_MyTask_receive_list parameters:parameters success:^(id data) {
        
        [self.dataArr removeAllObjects];
        
        if ([data[@"code"]integerValue] ==0) {
            for (NSDictionary *dict in data[@"data"]) {
                YBMyIssueModel *model=[YBMyIssueModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
        }else if ([data[@"code"]integerValue] ==1){
            //暂无任务
            [DWBToast showCenterWithText:data[@"msg"]];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}


@end
