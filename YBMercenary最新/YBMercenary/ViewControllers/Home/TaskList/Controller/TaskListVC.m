//
//  TaskListVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/12.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskListVC.h"
#import "HomeTaskDetailCell.h"
#import "ZJNSignUpViewController.h"
@interface TaskListVC ()
@property (nonatomic ,assign)NSInteger page;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@end

@implementation TaskListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务列表";
    self.page = 0;
    self.dataArr = [NSMutableArray array];
    [self configTableView];
    [self getDataFromService];
}

- (void)configTableView{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor hex:Back_Color];
//    self.tableView.contentInset = UIEdgeInsetsMake(Width(10), 0, 0, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self getDataFromService];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getDataFromService];
    }];
}

-(void)getDataFromService{
    self.page += 1;
    NSArray *keyArr = @[@"pageNum",@"task_type",@"task_type_child"];
    NSArray *valueArr = @[@(self.page),@(self.type),@(self.childType)];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArr forKeys:keyArr];
    [[YBRequestManager sharedYBManager] postWithUrlString:Get_tasklist parameters:dic success:^(id data) {
        DBLog(@"data%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@
             "0"]) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:data[@"data"]];
            [self reloadTableView];
        }else{
            self.page -= 1;
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        self.page -= 1;
        [DWBToast showCenterWithText:ErrorInfo];
        DBLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTaskDetailCell *cell = [HomeTaskDetailCell creatTableViewCellWithTableView:tableView];
    cell.data = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
    vc.reloadTaskList = ^{
        self.page = 0;
        [self getDataFromService];
    };
    vc.type = self.type;
    vc.taskId = [dic[@"id"] integerValue];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
