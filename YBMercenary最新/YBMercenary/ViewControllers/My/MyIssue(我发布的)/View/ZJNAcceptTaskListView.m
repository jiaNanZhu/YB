//
//  ZJNAcceptTaskListView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNAcceptTaskListView.h"
#import "SignUpVC.h"
#import "ZJNMyAcceptTaskTableViewCell.h"
#import "ZJNMyAcceptSecondTableViewCell.h"
#import "ZJNMyIssueBackOrderCell.h"
#import "ZJNMyIssueWTGCell.h"
#import "YBMyIssueModel.h"
#import "ZJNSignUpViewController.h"
#import "ZJNWhileTaskViewController.h"
#import "ZJNTaskAuditViewController.h"
#import "ZJNTaskDoneViewController.h"
#import "ZJNTaskWaitEvaluteViewController.h"
#import "ZJNAlertView.h"
@interface ZJNAcceptTaskListView()<UITableViewDelegate,UITableViewDataSource,ZJNMyAcceptSecondCellDelegate,ZJNAlertViewDelegate>{
    NSInteger pageNum;
}
@property(nonatomic ,strong)NSMutableArray *dataArr;
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)ZJNAlertView *alertView;
@end
@implementation ZJNAcceptTaskListView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        pageNum = 0;
        self.dataArr = [NSMutableArray array];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(frame.size.height);
        }];
    }
    return self;
}
-(ZJNAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[ZJNAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _alertView.delegate = self;
    }
    return _alertView;
}
-(void)getDataFromService{
    pageNum += 1;
    NSDictionary *dic;
    if (self.taskStatus == 0) {
        dic = @{@"token":USERTOKEN,@"pageNum":@(pageNum)};
    }else{
        dic = @{@"token":USERTOKEN,@"pageNum":@(pageNum),@"task_status":@(self.taskStatus)};
    }
    [[YBRequestManager sharedYBManager] postWithUrlString:UserCenter_MyTask_receive_list parameters:dic success:^(id data) {
        if (self.taskStatus == 2) {
            NSLog(@"%@",data);
        }
        if (pageNum == 1) {
            [self.dataArr removeAllObjects];
        }
        if ([data[@"code"] integerValue] == 0) {
            for (NSDictionary *dict in data[@"data"]) {
                YBMyIssueModel *model=[YBMyIssueModel yy_modelWithDictionary:dict];
                
                [self.dataArr addObject:model];
            }
        }else{
            pageNum -= 1;
            
//            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        pageNum -= 1;
        [DWBToast showCenterWithText:ErrorInfo];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = AdFloat(300);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            pageNum = 0;
            [self getDataFromService];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getDataFromService];
        }];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model = self.dataArr[indexPath.section];
    if ([model.task_status isEqualToString:@"2"]) {
        if (model.refuse_cause.length>0) {
            return UITableViewAutomaticDimension;
        }
        return AdFloat(300);
    }else if ([model.task_status isEqualToString:@"3"]&&[model.is_yanqi isEqualToString:@"1"]){
        return UITableViewAutomaticDimension;
    }else if ([model.settle_status isEqualToString:@"2"]){
        return AdFloat(300);
    }
    return AdFloat(220);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model = self.dataArr[indexPath.section];
    if ([model.task_status isEqualToString:@"2"]) {
        if (model.refuse_cause.length>0) {
            //未通过
            ZJNMyIssueWTGCell *cell = [ZJNMyIssueWTGCell creatTableViewCellWithTableView:tableView];
            cell.shareImg.hidden = YES;
            cell.shareLabel.hidden = YES;
            cell.lookImg.hidden = YES;
            cell.lookLabel.hidden = YES;
            cell.model = model;
            return cell;
        }else{
            //任务中
            ZJNMyAcceptSecondTableViewCell *cell = [ZJNMyAcceptSecondTableViewCell creatTableViewCellWithTableView:tableView];
            cell.model = model;
            cell.delegate = self;
            return cell;
        }
    }else if ([model.task_status isEqualToString:@"3"]&&[model.is_yanqi isEqualToString:@"1"]){
        //延期处理
        ZJNMyIssueBackOrderCell *cell = [ZJNMyIssueBackOrderCell creatTableViewCellWithTableView:tableView];
        cell.shareImg.hidden = YES;
        cell.shareLabel.hidden = YES;
        cell.lookImg.hidden = YES;
        cell.lookLabel.hidden = YES;
        cell.model = model;
        return cell;
    }else if ([model.settle_status isEqualToString:@"2"]){
        //退款中
        ZJNMyAcceptSecondTableViewCell *cell = [ZJNMyAcceptSecondTableViewCell creatTableViewCellWithTableView:tableView];
        cell.model = model;
        cell.delegate = self;
        return cell;
    }else{
        ZJNMyAcceptTaskTableViewCell *cell = [ZJNMyAcceptTaskTableViewCell creatTableViewCellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model = self.dataArr[indexPath.section];
    if ([model.task_status isEqualToString:@"1"]) {
        //已报名
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"2"]){
        //任务中
        ZJNWhileTaskViewController *vc = [[ZJNWhileTaskViewController alloc]initWithTaskType:MyAcceptTask];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        vc.whileTaskRefreshBlock = ^{
            pageNum = 0;
            [self getDataFromService];
        };
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"3"]){
        //审核中
        ZJNTaskAuditViewController *vc = [[ZJNTaskAuditViewController alloc]initWithTaskType:MyAcceptTaskAudit];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else{
        //6 已完成
        ZJNTaskDoneViewController *vc = [[ZJNTaskDoneViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark-ZJNMyAcceptSecondCellDelegate
-(void)ZJNMyAcceptSecondCellBottomBtnClickWithCell:(ZJNMyAcceptSecondTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model = self.dataArr[indexPath.section];
    self.alertView.alertType = ZJNBackMoneyAlert;
    self.alertView.model = model;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}
#pragma mark-ZJNAlertViewDelegate
-(void)zjnAlertViewOkButtonClickWithBackMoneyDic:(NSDictionary *)dic{
    [[YBRequestManager sharedYBManager] postWithUrlString:TuiKuan parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            [DWBToast showCenterWithText:@"退款申请已提交"];
            pageNum = 0;
            [self getDataFromService];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:@"连接服务器失败"];
    }];
}

-(void)setTaskStatus:(NSInteger)taskStatus{
    _taskStatus = taskStatus;
    [self getDataFromService];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
