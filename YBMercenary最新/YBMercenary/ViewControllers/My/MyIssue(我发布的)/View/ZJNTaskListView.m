//
//  ZJNTaskListView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTaskListView.h"
#import "SignUpVC.h"
#import "ZJNEvaluateView.h"
#import "ZJNMyIssueViewController.h"
#import "ZJNMyIssueWTGCell.h"
#import "ZJNMyIssueBackOrderCell.h"
#import "ZJNMyIssueTableViewCell.h"
#import "UITableView+ShowHind.h"
#import "YBMyIssueModel.h"
#import "ZJNSignUpViewController.h"
#import "ZJNWhileTaskViewController.h"
#import "ZJNTaskAuditViewController.h"
#import "ZJNTaskWaitEvaluteViewController.h"
#import "ZJNMyDetailMoneyTableViewCell.h"
#import "ZJNAlertView.h"
@interface ZJNTaskListView()<UITableViewDelegate,UITableViewDataSource,ZJNMyIssueTableViewCellDelegate,ZJNAlertViewDelegate,DetailMoneyDelagete>{
    NSInteger pageNum;
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView  *tableView;
@property(nonatomic,strong)ZJNAlertView *alertView;
@end
@implementation ZJNTaskListView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
-(void)getDataFromService{
    pageNum += 1;
    NSDictionary *dic;
    if (self.taskStatus == 0) {
        dic = @{@"token":USERTOKEN,@"pageNum":@(pageNum)};
    }else{
        dic = @{@"token":USERTOKEN,@"pageNum":@(pageNum),@"task_status":@(self.taskStatus)};
    }
    
    [[YBRequestManager sharedYBManager] postWithUrlString:UserCenter_MyTask_publish_lis parameters:dic success:^(id data) {
        if ([data[@"code"] integerValue] == 0) {
            if (pageNum == 1) {
                [self.dataArr removeAllObjects];
            }
            for (NSDictionary *dict in data[@"data"]) {
                YBMyIssueModel *model=[YBMyIssueModel yy_modelWithDictionary:dict];
                
                [self.dataArr addObject:model];
            }
            if (self.dataArr.count>0) {
                [self.tableView hideHind];
            }else{
                [self.tableView showHind];
            }
            [self.tableView reloadData];
        }else{
            pageNum -= 1;
            [DWBToast showCenterWithText:data[@"msg"]];
        }
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
-(ZJNAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[ZJNAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _alertView.delegate = self;
    }
    return _alertView;
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
    if (section == self.dataArr.count-1) {
        return KAddBottomBarHeight;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model = self.dataArr[indexPath.section];
    if ([model.task_status isEqualToString:@"2"]) {
        if (model.refuse_cause.length>0) {
            return UITableViewAutomaticDimension;
        }else{
            return AdFloat(200);
        }
    }else if ([model.task_status isEqualToString:@"3"]){
        if ([model.is_yanqi isEqualToString:@"1"]||[model.settle_status isEqualToString:@"2"]) {
            return UITableViewAutomaticDimension;
        }else{
            return AdFloat(300);
        }
    }else if ([model.task_status isEqualToString:@"7"]){
        //已评价
        return AdFloat(200);
    }else if ([model.task_status isEqualToString:@"5"]){
        return UITableViewAutomaticDimension;
    }else{
        return AdFloat(300);
    }
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
            ZJNMyIssueWTGCell *cell = [ZJNMyIssueWTGCell creatTableViewCellWithTableView:tableView];
            cell.model = model;
            return cell;
        }
    }else if ([model.task_status isEqualToString:@"3"]){
        if ([model.is_yanqi isEqualToString:@"1"]) {
            ZJNMyIssueBackOrderCell *cell = [ZJNMyIssueBackOrderCell creatTableViewCellWithTableView:tableView];
            cell.model = model;
            return cell;
        }else if ([model.settle_status isEqualToString:@"2"]){
            ZJNMyDetailMoneyTableViewCell *cell = [ZJNMyDetailMoneyTableViewCell creatTableViewCellWithTableView:tableView];
            cell.delegate = self;
            cell.model = model;
            return cell;
        }
    }else if ([model.task_status isEqualToString:@"5"]){
        ZJNMyIssueWTGCell *cell = [ZJNMyIssueWTGCell creatTableViewCellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    ZJNMyIssueTableViewCell *cell = [ZJNMyIssueTableViewCell creatTableViewCellWithTableView:tableView];
    cell.model = model;
    cell.delegate = self;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    if ([model.task_status isEqualToString:@"1"]) {
        //未决定
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.reloadTaskList = ^{
            pageNum = 0;
            [self getDataFromService];
        };
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"2"]){
        //任务中
        ZJNWhileTaskViewController *vc = [[ZJNWhileTaskViewController alloc]initWithTaskType:MyPublishTask];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"3"]){
        //审核中
        ZJNTaskAuditViewController *vc = [[ZJNTaskAuditViewController alloc]initWithTaskType:MyPublishTaskAudit];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"4"]){
        //已下架
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"5"]){
        //未通过后台审核的
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"6"]){
        //待评价
        ZJNTaskWaitEvaluteViewController *vc = [[ZJNTaskWaitEvaluteViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if ([model.task_status isEqualToString:@"7"]){
        //已评价
        NSLog(@"%@",model.task_status);
        ZJNTaskWaitEvaluteViewController *vc = [[ZJNTaskWaitEvaluteViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else{
        //后台审核中
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [model.task_type intValue];
        vc.taskId = [model.id integerValue];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}
-(void)setTaskStatus:(NSInteger)taskStatus{
    _taskStatus = taskStatus;
    [self getDataFromService];
}

#pragma mark-
//修改价格
-(void)myIssueTableViewCellChangeMoneyButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    DBLog(@"修改价格");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    
    self.alertView.alertType = ZJNChangeMoneyAlert;
    self.alertView.model = model;
    __weak typeof(self)weakSelf = self;
    self.alertView.changeMoneyViewBlock = ^(NSString * _Nonnull money) {
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id,@"pay_amount":money};
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)weakSelf.viewController;
        [viewC getDataFromServiceWithPara:dic urlStr:Editprice successfulToast:@"任务金额修改成功"];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}
//未通过
-(void)myIssueTableViewCellWTGButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    
    __weak typeof(self)weakSelf = self;
    self.alertView.wtgViewInfoBlock = ^(NSString * _Nonnull info) {
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id,@"type":@(2),@"refuse_cause":info};
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)weakSelf.viewController;
        [viewC getDataFromServiceWithPara:dic urlStr:UserCenter_shenhe successfulToast:@"任务审核完成"];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.alertView.alertType = ZJNWTGAlert;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}
//撤销
-(void)myIssueTableViewCellXiaJiaButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"是否撤销该任务" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        YBMyIssueModel *model= self.dataArr[indexPath.section];
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)self.viewController;
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id};
        NSString *url = UserCenter_xiajia;
        [viewC getDataFromServiceWithPara:dic urlStr:url successfulToast:@"任务撤销成功"];
        [self.tableView.mj_header beginRefreshing];
    }];
    [alertC addAction:cancelA];
    [alertC addAction:okA];
    [self.viewController presentViewController:alertC animated:YES completion:nil];
}
//邀请
-(void)myIssueTableViewCellInviteButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)self.viewController;
    viewC.shareUrl = [NSString stringWithFormat:@"http://yb.dashuibei.com/register/detail.html?id=%@",model.id];;
    viewC.shareTitle = model.task_name;
    viewC.shareDesion = model.task_description;
    [viewC showShareView];
}
//确认审核
-(void)myIssueTableViewCellAuditButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *attrTitleStr = [[NSMutableAttributedString alloc]initWithString:@"确认审核"];
    [attrTitleStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdFloat(32)],NSForegroundColorAttributeName:[UIColor hex:@"444444"]} range:NSMakeRange(0, attrTitleStr.length)];
    [alertC setValue:attrTitleStr forKey:@"_attributedTitle"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        YBMyIssueModel *model= self.dataArr[indexPath.section];
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)self.viewController;
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id,@"type":@(1)};
        
        [viewC getDataFromServiceWithPara:dic urlStr:UserCenter_shenhe successfulToast:@"任务审核完成"];
        [self.tableView.mj_header beginRefreshing];
    }];
    [okAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    [alertC addAction:okAction];
    [alertC addAction:cancelAction];
    [self.viewController presentViewController:alertC animated:YES completion:nil];
}
//上架
-(void)myIssueTableViewCellShangJiaButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)self.viewController;
    NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id};
    NSString *url = UserCenter_shangjia;
    [viewC getDataFromServiceWithPara:dic urlStr:url successfulToast:@"任务重新上架成功"];
    [self.tableView.mj_header beginRefreshing];
}
//评价
-(void)myIssueTableViewCellEvaluateButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    ZJNEvaluateView *view = [[ZJNEvaluateView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.evaluteStarBlock = ^(NSInteger stars) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        YBMyIssueModel *model= self.dataArr[indexPath.section];
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id,@"star":@(stars)};
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)self.viewController;
        [viewC getDataFromServiceWithPara:dic urlStr:Pingjia successfulToast:@"评价任务成功"];
        [self.tableView.mj_header beginRefreshing];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
//延期处理
-(void)myIssueTableViewCellBackOrderButtonClickWithCell:(ZJNMyIssueTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    self.alertView.alertType = ZJNBackOrderAlert;
    __weak typeof(self)weakSelf = self;
    self.alertView.backOrderViewBlock = ^(NSDictionary * _Nonnull dic) {
        NSString *yanqi_days = dic[@"day"];
        NSString *yanqi_reason = dic[@"info"];
        NSDictionary *para = @{@"token":USERTOKEN,@"id":model.id,@"yanqi_days":yanqi_days,@"yanqi_reason":yanqi_reason};
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)weakSelf.viewController;
        [viewC getDataFromServiceWithPara:para urlStr:YanQi successfulToast:@"任务延期成功"];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}

//未通过
-(void)myDetailMoneyTableViewCellWTGButtonClickWithCell:(ZJNMyDetailMoneyTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    
    __weak typeof(self)weakSelf = self;
    self.alertView.wtgViewInfoBlock = ^(NSString * _Nonnull info) {
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id,@"type":@(2),@"refuse_cause":info};
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)weakSelf.viewController;
        [viewC getDataFromServiceWithPara:dic urlStr:UserCenter_shenhe successfulToast:@"任务审核完成"];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.alertView.alertType = ZJNWTGAlert;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}
//确认审核
-(void)myDetailMoneyTableViewCellAuditButtonClickWithCell:(ZJNMyDetailMoneyTableViewCell *)cell{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *attrTitleStr = [[NSMutableAttributedString alloc]initWithString:@"确认审核"];
    [attrTitleStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdFloat(32)],NSForegroundColorAttributeName:[UIColor hex:@"444444"]} range:NSMakeRange(0, attrTitleStr.length)];
    [alertC setValue:attrTitleStr forKey:@"_attributedTitle"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        YBMyIssueModel *model= self.dataArr[indexPath.section];
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)self.viewController;
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":model.id,@"type":@(1)};
        
        [viewC getDataFromServiceWithPara:dic urlStr:UserCenter_shenhe successfulToast:@"任务审核完成"];
        [self.tableView.mj_header beginRefreshing];
    }];
    [okAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    [alertC addAction:okAction];
    [alertC addAction:cancelAction];
    [self.viewController presentViewController:alertC animated:YES completion:nil];
}
//延期处理
-(void)myDetailMoneyTableViewCellBackOrderButtonClickWithCell:(ZJNMyDetailMoneyTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YBMyIssueModel *model= self.dataArr[indexPath.section];
    self.alertView.alertType = ZJNBackOrderAlert;
    __weak typeof(self)weakSelf = self;
    self.alertView.backOrderViewBlock = ^(NSDictionary * _Nonnull dic) {
        NSString *yanqi_days = dic[@"day"];
        NSString *yanqi_reason = dic[@"info"];
        NSDictionary *para = @{@"token":USERTOKEN,@"id":model.id,@"yanqi_days":yanqi_days,@"yanqi_reason":yanqi_reason};
        ZJNMyIssueViewController *viewC = (ZJNMyIssueViewController *)weakSelf.viewController;
        [viewC getDataFromServiceWithPara:para urlStr:YanQi successfulToast:@"任务延期成功"];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}
//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
