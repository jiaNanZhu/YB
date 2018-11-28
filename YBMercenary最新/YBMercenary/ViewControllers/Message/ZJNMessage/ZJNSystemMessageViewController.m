//
//  ZJNSystemMessageViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSystemMessageViewController.h"
#import "ZJNSystemTableViewCell.h"
#import "UITableView+ShowHind.h"
#import "ZJNSystemMessageModel.h"
@interface ZJNSystemMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)NSInteger pageNum;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation ZJNSystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNum = 0;
    self.dataArr = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self getDataFromService];
    // Do any additional setup after loading the view.
}
-(void)getDataFromService{
    self.pageNum += 1;
    NSDictionary *dic = @{@"token":USERTOKEN,@"page":@(self.pageNum),@"rows":@""};
    [[YBRequestManager sharedYBManager] postWithUrlString:UserCenter_notice_get parameters:dic success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            if (self.pageNum == 1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *arr = data[@"data"];
            for (int i = 0; i <arr.count; i ++) {
                ZJNSystemMessageModel *model = [ZJNSystemMessageModel yy_modelWithDictionary:arr[i]];
                [self.dataArr addObject:model];
            }
            if (arr.count>0) {
                [self.tableView hideHind];
            }else{
                [self.tableView showHind];
            }
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdFloat(140);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    ZJNSystemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNSystemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArr[indexPath.row];
    return cell;
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
