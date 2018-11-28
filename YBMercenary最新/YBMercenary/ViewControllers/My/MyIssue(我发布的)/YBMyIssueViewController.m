//
//  YBMyIssueViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyIssueViewController.h"
#import "ZJNMyIssueTableViewCell.h"
#import "SignUpVC.h"
#import "YBMyIssueModel.h"
#import "ZJNSignUpViewController.h"
#import "ZJNWhileTaskViewController.h"
#import "ZJNTaskAuditViewController.h"
#import "ZJNTaskWaitEvaluteViewController.h"
@interface YBMyIssueViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *xianImg;
//    int _typeS;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * headView;

@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,assign)NSInteger pageNum;
@end

@implementation YBMyIssueViewController
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
    
    
    [self headerRefresh];
}
#pragma mark - 布局
-(void)makeUI{
    _headView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    _headView.frame = CGRectMake(0, 0, d_Device_width, AdFloat(100));
    [self.view addSubview:_headView];
    
    xianImg = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"xianIMG"] cornerRadius:0];
    xianImg.frame = CGRectMake(0, AdFloat(95), d_Device_width/6, AdFloat(5));
    [_headView addSubview:xianImg];
    
    NSArray *titleArr = @[@"全部",@"未决定",@"任务中",@"审核中",@"待评价",@"已下架"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [F_UI SL_UI_Btn:titleArr[i] Color:[UIColor hex:@"666666"] Font:AdFloat(30) bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:0];
        btn.frame = CGRectMake(i*(d_Device_width/titleArr.count), 0, d_Device_width/titleArr.count, AdFloat(122));
        btn.tag = i+260;
        [_headView addSubview:btn];
        
        
        if (_typeS == i) {
            
            xianImg.frame = CGRectMake(i*(d_Device_width/6), AdFloat(95), d_Device_width/6, AdFloat(5));
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
        }

    }
    [self.view addSubview:self.tableView];
}
#pragma mark - 选择
-(void)btn:(UIButton *)sender{
    for (int i = 0; i < 6; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:(260+i)];
        if (btn.tag == sender.tag) {
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                xianImg.frame = CGRectMake(i*(d_Device_width/6), AdFloat(95), d_Device_width/6, AdFloat(5));
            }];
            _typeS = i;
            [self.tableView reloadData];
        }else{
            [btn setUserInteractionEnabled:YES];
            [btn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
        }
    }
    
    [self headerRefresh];
}
-(UITableView *)tableView
{
    if (_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headView.maxY+AdFloat(16), d_Device_width, d_Device_height-iPhone_X_bool_Nav_height-AdFloat(108))];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
        
    }
    return _tableView;
}
#pragma mark - 分组cell数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(300);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJNMyIssueTableViewCell *cell = [ZJNMyIssueTableViewCell creatTableViewCellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.section];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    if ([model.task_status isEqualToString:@"1"]) {
        //未决定
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"2"]){
        //任务中
        ZJNWhileTaskViewController *vc = [[ZJNWhileTaskViewController alloc]initWithTaskType:MyPublishTask];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"3"]){
        //审核中
        ZJNTaskAuditViewController *vc = [[ZJNTaskAuditViewController alloc]initWithTaskType:MyPublishTaskAudit];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"4"]){
        //已下架
    }else if ([model.task_status isEqualToString:@"6"]){
        //待评价
        ZJNTaskWaitEvaluteViewController *vc = [[ZJNTaskWaitEvaluteViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 修改
-(void)clickAttention:(int)tag{
    DBLog(@"未决定---修改---%d行",11000-tag);
}
#pragma mark - 撤销
-(void)clickAttention_1:(int)tag{
    DBLog(@"未决定---撤销---%d行",12000-tag);
    
    YBMyIssueModel *model=  self.dataArr[14000-tag];
    [self requesttaskoperationwith:model.id];
}
#pragma mark - 邀请
-(void)clickAttention_2:(int)tag{
    DBLog(@"未决定---邀请---%d行",13000-tag);
}
#pragma mark - 确认审核、评价、上架
-(void)clickAttention_3:(int)tag type:(int)type{
    YBMyIssueModel *model=  self.dataArr[14000-tag];
    if (_typeS == 0) {
        if (type == 1) {
            DBLog(@"全部---确认审核---%d行",14000-tag);
        }else if (type == 2){
            DBLog(@"全部---评价---%d行",14000-tag);
        }else if (type == 3){
            DBLog(@"全部---上架---%d行",14000-tag);
        }
    }else if (_typeS == 3) {
        DBLog(@"审核中---确认审核---%d行",14000-tag);
    }else if (_typeS == 4){
        DBLog(@"待评价---评价---%d行",14000-tag);
    }else if (_typeS == 5){
        DBLog(@"已下架---上架---%d行",14000-tag);
        
        [self requesttaskoperationwith:model.id];
    }
}

-(void)headerRefresh
{
 
    self.pageNum=1;
    [self requestUserCenter_MyTask_publish_lis];
}
-(void)footRefresh
{
    self.pageNum++;
    
    [self requestUserCenter_MyTask_publish_lis];
}
#pragma mark request
#pragma mark 我发布的任务列表
-(void)requestUserCenter_MyTask_publish_lis
{

    
    
    NSInteger task_status=_typeS;
    
    
    if (_typeS ==4) {
        task_status = 6;
    }
    if (_typeS == 5) {
        task_status = 4;
    }
    
    NSDictionary *parameters =@{@"token":USERTOKEN,@"pageNum":@(self.pageNum),@"pageSize":@(10),@"task_status":@(task_status)};
    
        [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_MyTask_publish_lis parameters:parameters success:^(id data) {
            
            if ([data[@"code"]integerValue] ==0) {
                
                if (self.pageNum ==1) {
                    [self.dataArr removeAllObjects];
                }
                for (NSDictionary *dict in data[@"data"]) {
                    YBMyIssueModel *model=[YBMyIssueModel yy_modelWithDictionary:dict];
                    
                    [self.dataArr addObject:model];
                }
                
            }
            else if ([data[@"code"]integerValue] ==1)
            {
                
                //暂无任务
                [DWBToast showCenterWithText:data[@"msg"]];
            }
            else{
               [DWBToast showCenterWithText:data[@"msg"]];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
}

#pragma mark request
#pragma mark
-(void)requesttaskoperationwith:(NSString *)taskid
{
    
    
    
    NSString *url =nil;
    
    if (_typeS == 5) {
        url=UserCenter_shangjia;
    }
    else if (_typeS == 1)
    {
        url=UserCenter_xiajia;
    }
    
    NSDictionary *parameters =@{@"token":USERTOKEN,@"id":taskid};
    
    [[YBRequestManager sharedYBManager]postWithUrlString:url parameters:parameters success:^(id data) {
        
        
        [self.dataArr removeAllObjects];
        if ([data[@"code"]integerValue] ==0) {
            
            
            for (NSDictionary *dict in data[@"data"]) {
                YBMyIssueModel *model=[YBMyIssueModel yy_modelWithDictionary:dict];
                
                [self.dataArr addObject:model];
            }
            
            
            
        }
        else if ([data[@"code"]integerValue] ==1)
        {
            
            //暂无任务
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

@end
