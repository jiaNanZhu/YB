//
//  SignUpVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/13.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "SignUpVC.h"
#import "LeaveMessageCell.h"
#import "MessageDetailCell.h"
#import "WaitChoseListCell.h"
#import "TaskInfoCell.h"
#import "SignupPaotuiTaskCell.h"
#import "SignupLifeTaskCell.h"
#import "SignupCustomTaskCell.h"
#import "SignupWorkTaskCell.h"
#import "SignUpHealthTaskCell.h"
#import "SignupOtherTaskCell.h"
#import "TaskDetailModel.h"
#import "DateTool.h"
#import "YBLoginViewController.h"
#import "YBNavigationViewController.h"
@interface SignUpVC ()

//底部视图
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *collectBtn;//收藏
@property (nonatomic, strong) UIButton *complainBtn;//投诉
@property (nonatomic, strong) UIButton *stateBtn;//报名...
@property (nonatomic, strong) TaskDetailModel *detailModel;
@property (nonatomic, strong) NSArray *messageArr;
@end

@implementation SignUpVC

- (UIView *)footView{
    if (_footView == nil) {
        _footView = [[UIView alloc]init];
        [_footView addSubview:self.collectBtn];
        [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(_footView);
            make.width.mas_equalTo(kScreenWidth/4);
        }];
        [_footView addSubview:self.complainBtn];
        [_complainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_footView);
            make.centerX.equalTo(_footView).offset(-kScreenWidth/8);
            make.width.mas_equalTo(kScreenWidth/4);
        }];
        [_footView addSubview:self.stateBtn];
        [_stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_footView);
            make.width.mas_equalTo(kScreenWidth/2);
        }];
        [self.navigationController.view addSubview:_footView];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor hex:Back_Color];
        [_footView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_footView);
            make.height.mas_equalTo(Width(1));
        }];
        
        NSLog(@"---------%f",self.tabBarController.tabBar.height);
        _footView.backgroundColor = [UIColor whiteColor];
        [_footView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.navigationController.view);
            make.height.mas_equalTo(self.tabBarController.tabBar.height);
        }];
    }
    return _footView;
}

- (UIButton *)collectBtn{
    if (_collectBtn == nil) {
        _collectBtn = [F_UI creatBtnWithTager:self title:@"收藏" font:15 image:[UIImage imageNamed:@"collect_no"] backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(collectMethod:)];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_yes"] forState:UIControlStateSelected];
        [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
        [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, Width(8))];
        [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, Width(8), 0, 0)];
    }
    return _collectBtn;
}

- (UIButton *)complainBtn{
    if (_complainBtn == nil) {
        _complainBtn = [F_UI creatBtnWithTager:self title:@"投诉" font:15 image:[UIImage imageNamed:@"投诉"] backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(complainMethod:)];
        [_complainBtn setImageEdgeInsets:UIEdgeInsetsMake(Width(2), 0, 0, Width(8))];
        [_complainBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, Width(8), 0, 0)];
    }
    return _complainBtn;
}

- (UIButton *)stateBtn{
    if (_stateBtn == nil) {
        _stateBtn = [F_UI creatBtnWithTager:self title:@"我要报名" font:15 image:nil backImage:[UIImage imageNamed:@"背景"] color:[UIColor whiteColor] textColor:[UIColor whiteColor] cornerRadius:0 action:@selector(stateMethod:)];
        [_stateBtn setTitle:@"已报名" forState:UIControlStateSelected];
    }
    return _stateBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务详情";
    self.tableView.contentInset = UIEdgeInsetsMake(Width(10), 0, Width(49), 0);
    [self getDataFromService];
    [self getMessageFromService];
}
-(void)getDataFromService{
    NSDictionary *dic;
    if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
        dic = @{@"id":@(self.taskId)};
    }else{
        dic = @{@"id":@(self.taskId),@"token":USERTOKEN};
    }
    DBLog(@"%@",dic);
    [[YBRequestManager sharedYBManager] postWithUrlString:Get_taskdetail parameters:dic success:^(id data) {
        DBLog(@"%@",data);
        if ([data[@"code"] integerValue] == 0) {
            self.detailModel = [TaskDetailModel yy_modelWithDictionary:data[@"data"]];
            if ([self.detailModel.collect isEqualToString:@"1"]) {
                self.collectBtn.selected = YES;
            }
            [self reloadTableView];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        DBLog(@"%@",error);
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
-(void)getMessageFromService{
    NSDictionary *dic = @{@"pageNum":@(1),@"id":@(self.taskId)};
    [[YBRequestManager sharedYBManager] postWithUrlString:Get_boardlist parameters:dic success:^(id data) {
        DBLog(@"%@",data);
        self.messageArr = data[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        DBLog(@"%@",error);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.footView.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.footView.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4+self.messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TaskInfoCell *cell = [TaskInfoCell creatTableViewCellWithTableView:tableView];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.head_img] placeholderImage:[UIImage imageNamed:@"Group1"]];
        cell.nameLabel.text = self.detailModel.name;
        cell.timeLabel.text = [DateTool timeStampToString:[self.detailModel.publish_time integerValue]];
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.detailModel.pay_amount];
        cell.taskNameLabel.text = self.detailModel.task_name;
        cell.markView.markArr = [self.detailModel.task_tag componentsSeparatedByString:@"|"];
        return cell;
    }else if (indexPath.row == 1) {
        if (self.type == 1) {
            //跑腿
            SignupPaotuiTaskCell *cell = [SignupPaotuiTaskCell creatTableViewCellWithTableView:tableView];
            cell.nameLabel.text = self.detailModel.itemname;
            cell.countLabel.text = self.detailModel.numbers;
            cell.beginLabel.text = self.detailModel.begin_address;
            cell.endLabel.text = self.detailModel.end_address;
            cell.timeLabel.text = [DateTool timeStampToString:[self.detailModel.delivery_time integerValue]];
            cell.requireLabel.text = self.detailModel.transport;
            return cell;
        }else if (self.type == 2){
            //生活
            SignupLifeTaskCell *cell = [SignupLifeTaskCell creatTableViewCellWithTableView:tableView];
            cell.validityLabel.text = self.detailModel.validity_time;
            cell.purposeLabel.text = self.detailModel.task_purpose;
            cell.requireLabel.text = self.detailModel.task_request;
            cell.detailLabel.text = self.detailModel.task_description;
            return cell;
        }else if (self.type == 3){
            //个人定制
            SignupCustomTaskCell *cell = [SignupCustomTaskCell creatTableViewCellWithTableView:tableView];
            cell.requireLabel.text = self.detailModel.task_request;
            cell.detaileLabel.text = self.detailModel.task_description;
            cell.photoView.imageList = [self.detailModel.task_img componentsSeparatedByString:@"|"];
            return cell;
        }else if (self.type == 4){
            //工作
            SignupWorkTaskCell *cell = [SignupWorkTaskCell creatTableViewCellWithTableView:tableView];
            cell.purposeLabel.text = self.detailModel.task_purpose;
            cell.requireLabel.text = self.detailModel.task_request;
            cell.detailLabel.text = self.detailModel.task_description;
            return cell;
        }else if (self.type == 5){
            //健康
            
            SignUpHealthTaskCell *cell = [SignUpHealthTaskCell creatTableViewCellWithTableView:tableView];
            cell.purposeLabel.text = self.detailModel.task_purpose;
            cell.requireLabel.text = self.detailModel.task_request;
            cell.detailLabel.text = self.detailModel.task_description;
            cell.photoView.imageList = [self.detailModel.task_img componentsSeparatedByString:@"|"];
            
            return cell;
        }else{
            //其他
            SignupOtherTaskCell *cell = [SignupOtherTaskCell creatTableViewCellWithTableView:tableView];
            cell.validityLabel.text = self.detailModel.validity_time;
            cell.purposeLabel.text = self.detailModel.task_purpose;
            cell.requireLabel.text = self.detailModel.task_request;
            cell.detailLabel.text = self.detailModel.task_description;
            return cell;
        }
    }else if (indexPath.row == 2) {
        WaitChoseListCell *cell = [WaitChoseListCell creatTableViewCellWithTableView:tableView];
        cell.updateTableViewHeightBlock = ^{
            [self.tableView updateConstraints];
        };
        cell.taskId = self.taskId;
        return cell;
    }else if(indexPath.row == 3){
        LeaveMessageCell *cell = [LeaveMessageCell creatTableViewCellWithTableView:tableView];
        cell.taskId = self.taskId;
        __weak typeof(self) weakSelf = self;
        cell.refreshMessageList = ^{
            [weakSelf getMessageFromService];
        };
        return cell;
    }else{
        MessageDetailCell *cell = [MessageDetailCell creatTableViewCellWithTableView:tableView];
        cell.dic = self.messageArr[indexPath.row-4];
        return cell;
    }
}

#pragma mark  底部按钮方法
- (void)collectMethod:(UIButton *)sender{
    if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
        [self login];
    }else{
        NSInteger collect;
        if ([self.detailModel.collect isEqualToString:@"1"]) {
            collect = 2;
        }else{
            collect = 1;
        }
        NSDictionary *dic = @{@"token":USERTOKEN,@"task_id":@(self.taskId),@"type":@(collect)};
        DBLog(@"%@",dic);
        [[YBRequestManager sharedYBManager] postWithUrlString:Add_collect parameters:dic success:^(id data) {
            DBLog(@"%@",data);
            if ([data[@"code"] integerValue] == 0) {
                sender.selected = !sender.selected;
                if ([self.detailModel.collect isEqualToString:@"1"]) {
                    [DWBToast showCenterWithText:@"取消收藏成功"];
                    self.detailModel.collect = @"0";
                }else{
                    [DWBToast showCenterWithText:@"收藏成功"];
                    self.detailModel.collect = @"1";
                }
            }else{
                [DWBToast showCenterWithText:data[@"msg"]];
            }
        } failure:^(NSError *error) {
            [DWBToast showCenterWithText:ErrorInfo];
        }];
    }
    
}

- (void)complainMethod:(UIButton *)sender{
    if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
        [self login];
    }else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",hotLine];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}

- (void)stateMethod:(UIButton *)sender{
    if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
        [self login];
    }else{
        NSDictionary *dic = @{@"token":USERTOKEN,@"id":@(self.taskId)};
        [[YBRequestManager sharedYBManager] postWithUrlString:Add_apply parameters:dic success:^(id data) {
            if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
                [DWBToast showCenterWithText:@"报名成功"];
                self.stateBtn.selected = YES;
            }else{
                [DWBToast showCenterWithText:data[@"msg"]];
            }
        } failure:^(NSError *error) {
            [DWBToast showCenterWithText:ErrorInfo];
        }];
    }
}

-(void)login{
    YBLoginViewController *viewc = [[YBLoginViewController alloc]init];
    YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:viewc];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
