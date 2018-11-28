//
//  PublishOtherTaskVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishOtherTaskVC.h"

#import "PublishTaskNameCell.h"
#import "PublishTaskGoal.h"
#import "PublishTaskRequireCell.h"
#import "PublishTaskMarkCell.h"
#import "PublishTaskDetailCell.h"
#import "LifeFiltrateReceiverCell.h"

@interface PublishOtherTaskVC ()<PublishTaskRequireCellDelegate,UIScrollViewDelegate>
{
    NSString *nameStr;
    NSString *goalStr;
    NSArray  *requireArr;
    NSString *moneyStr;
    NSString *timeStr;
    NSString *detailStr;
    NSMutableArray *markArr;
}
@property (nonatomic, assign) NSInteger lineCount;

@end

@implementation PublishOtherTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _lineCount = 1;
    [self configNav];
    [self configTableView];
    [self initStr];
}
-(void)initStr{
    nameStr = @"";
    goalStr = @"";
    requireArr = @[];
    timeStr = @"";
    markArr = [NSMutableArray array];
}

- (void)configNav{
    self.navigationItem.title = @"发布任务";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)configTableView{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor hex:Back_Color];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, Width(10), 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PublishTaskNameCell *cell = [PublishTaskNameCell creatTableViewCellWithTableView:tableView];
        cell.publishNameBlock = ^(NSString *name) {
            nameStr = name;
        };
        return cell;
    }else if(indexPath.row == 1){
        PublishTaskGoal *cell = [PublishTaskGoal creatTableViewCellWithTableView:tableView];
        cell.publishTaskGoalBlock = ^(NSString *goal) {
            goalStr = goal;
        };
        return cell;
    }else if(indexPath.row == 2){
        PublishTaskRequireCell *cell= [PublishTaskRequireCell creatTableViewCellWithTableView:tableView];
        cell.linecount = self.lineCount;
        cell.delegate = self;
        cell.publishTaskRequireBlock = ^(NSArray *require) {
            requireArr = require;
        };
        return cell;
    }else if (indexPath.row == 3){
        LifeFiltrateReceiverCell *cell = [LifeFiltrateReceiverCell creatTableViewCellWithTableView:tableView];
        cell.moneyFieldBlock = ^(NSString *money) {
            moneyStr = money;
        };
        cell.timeFieldBlock = ^(NSString *time) {
            timeStr = time;
        };
        return cell;
    }else if (indexPath.row == 4){
        PublishTaskMarkCell *cell = [PublishTaskMarkCell creatTableViewCellWithTableView:tableView];
        cell.publishTaskAddMarkBlock = ^(NSString *mark) {
            [markArr addObject:mark];
        };
        cell.publishTaskDeleteMarkBlock = ^(NSString *mark) {
            [markArr removeObject:mark];
        };
        return cell;
    }else{
        PublishTaskDetailCell *cell = [PublishTaskDetailCell creatTableViewCellWithTableView:tableView];
        cell.detailBlock = ^(NSString *detail) {
            detailStr = detail;
        };
        return cell;
    }
}

#pragma mark 点击导航右侧按钮
- (void)publishAction{
    
    if (nameStr.length == 0) {
        [DWBToast showCenterWithText:@"请输入任务名称"];
        return;
    }
    if (goalStr.length == 0) {
        [DWBToast showCenterWithText:@"请输入任务目的"];
        return;
    }
    if (requireArr.count == 0) {
        [DWBToast showCenterWithText:@"请输入任务要求"];
        return;
    }
    if (moneyStr.length == 0) {
        [DWBToast showCenterWithText:@"请输入任务佣金"];
        return;
    }
    if (nameStr.length == 0) {
        [DWBToast showCenterWithText:@"请输入任务名称"];
        return;
    }
    if (timeStr.length == 0) {
        [DWBToast showCenterWithText:@"请输入任务有效期"];
        return;
    }
    if (markArr.count == 0) {
        [DWBToast showCenterWithText:@"请输入任务标签"];
        return;
    }
    if (detailStr.length == 0) {
        [DWBToast showCenterWithText:@"请输入任务详情"];
        return;
    }
    CGFloat payAmount = 100*[moneyStr floatValue];
    NSDictionary *dic = @{@"token":USERTOKEN,@"task_type":@(self.task_type),@"task_name":nameStr,@"task_tag":[markArr componentsJoinedByString:@"|"],@"pay_amount":[NSString stringWithFormat:@"%.f",payAmount],@"validity_time":timeStr,@"task_description":detailStr,@"task_purpose":goalStr,@"task_request":[requireArr componentsJoinedByString:@","],@"task_city":[[NSUserDefaults standardUserDefaults] objectForKey:@"locationCity"]};
    [[YBRequestManager sharedYBManager] postWithUrlString:Home_Task_addtask parameters:dic success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            [DWBToast showCenterWithText:@"发布成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:ErrorInfo];
    }];
    
}

- (void)reloadeViewWithLineCount:(NSInteger)count{
    _lineCount = count;
    [self.tableView reloadData];
}

- (void)cancleAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


@end
