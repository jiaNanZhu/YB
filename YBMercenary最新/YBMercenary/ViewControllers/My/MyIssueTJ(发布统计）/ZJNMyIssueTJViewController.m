//
//  ZJNMyIssueTJViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyIssueTJViewController.h"
#import "ZJNMyIssueTJTopButtonView.h"
#import "ZJNTaskDoneViewController.h"
@interface ZJNMyIssueTJViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)ZJNMyIssueTJTopButtonView *topBtnView;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,assign)NSInteger stars;
@property (nonatomic ,assign)NSInteger pageNum;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@end

@implementation ZJNMyIssueTJViewController
-(id)initWithTaskTyType:(ZJNTaskTjType)type{
    self = [super init];
    if (self) {
        self.taskTjType = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _stars = 1;
    _pageNum = 0;
    _dataArr = [NSMutableArray array];
    [self.view addSubview:self.topBtnView];
    [self.topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBtnView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self getDataFromService];
    // Do any additional setup after loading the view.
}
-(void)getDataFromService{
    self.pageNum += 1;
    NSDictionary *dic = @{@"token":USERTOKEN,@"pageNum":@(self.pageNum),@"star":@(_stars)};
    NSString *urlStr;
    if (self.taskTjType == 0) {
        urlStr = UserCenter_MyTask_publish_sum_list;
    }else{
        urlStr = receiveSumList;
    }
    [[YBRequestManager sharedYBManager] postWithUrlString:urlStr parameters:dic success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            if (self.pageNum == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:data[@"data"]];
        }else{
            self.pageNum -= 1;
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        self.pageNum -= 1;
        [DWBToast showCenterWithText:ErrorInfo];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(ZJNMyIssueTJTopButtonView *)topBtnView{
    if (!_topBtnView) {
        _topBtnView = [[ZJNMyIssueTJTopButtonView alloc]init];
        _topBtnView.tjType = MyPublishTjType;
        __weak typeof(self) weakSelf = self;
        _topBtnView.myIssueTJBlock = ^(NSInteger stars) {
            weakSelf.pageNum = 0;
            weakSelf.stars = stars;
            [weakSelf getDataFromService];
        };
    }
    return _topBtnView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageNum = 0;
            [self getDataFromService];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getDataFromService];
        }];
    }
    return _tableView;
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.textLabel.font = SetFont(AdFloat(30));
        cell.textLabel.textColor = [UIColor hex:@"444444"];
        cell.detailTextLabel.font = SetFont(AdFloat(32));
        cell.detailTextLabel.textColor = [UIColor hex:@"444444"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.textLabel.text = dic[@"task_name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"pay_amount"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    ZJNTaskDoneViewController *viewC = [[ZJNTaskDoneViewController alloc]init];
    viewC.type = [dic[@"task_type"] integerValue];
    viewC.taskId = [dic[@"id"] integerValue];
    viewC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewC animated:YES];
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
