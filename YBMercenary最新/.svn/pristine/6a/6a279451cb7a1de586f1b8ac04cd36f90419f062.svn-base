//
//  TaskBeginVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskBeginVC.h"
#import "LeaveMessageCell.h"
#import "MessageDetailCell.h"
#import "AffirmPersonCell.h"
#import "BeginHeaderCell.h"


#import "SignupPaotuiTaskCell.h"
#import "SignupLifeTaskCell.h"
#import "SignupCustomTaskCell.h"
#import "SignupWorkTaskCell.h"
#import "SignUpHealthTaskCell.h"
#import "SignupOtherTaskCell.h"

@interface TaskBeginVC ()

//底部视图
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *collectBtn;//收藏
@property (nonatomic, strong) UIButton *complainBtn;//投诉
@property (nonatomic, strong) UIButton *stateBtn;//报名...

@end

@implementation TaskBeginVC


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
        
        _footView.backgroundColor = [UIColor orangeColor];
        [_footView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.navigationController.view);
            make.height.mas_equalTo(Width(49));
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
        _stateBtn = [F_UI creatBtnWithTager:self title:@"提交任务" font:15 image:nil backImage:[UIImage imageNamed:@"背景"] color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:0 action:@selector(stateMethod:)];
    }
    return _stateBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"已开始的任务详情";
    self.tableView.contentInset = UIEdgeInsetsMake(Width(10), 0, Width(49), 0);
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BeginHeaderCell *cell = [BeginHeaderCell creatTableViewCellWithTableView:tableView];
        return cell;
    }else if (indexPath.row == 1) {
        if ([self.type isEqualToString:@"跑腿"]) {
            //跑腿
            SignupPaotuiTaskCell *cell = [SignupPaotuiTaskCell creatTableViewCellWithTableView:tableView];
            return cell;
        }else if ([self.type isEqualToString:@"生活"]){
            //生活
            SignupLifeTaskCell *cell = [SignupLifeTaskCell creatTableViewCellWithTableView:tableView];
            return cell;
        }else if ([self.type isEqualToString:@"个人定制"]){
            //个人定制
            SignupCustomTaskCell *cell = [SignupCustomTaskCell creatTableViewCellWithTableView:tableView];
            return cell;
        }else if ([self.type isEqualToString:@"工作"]){
            //工作
            SignupWorkTaskCell *cell = [SignupWorkTaskCell creatTableViewCellWithTableView:tableView];
            return cell;
        }else if ([self.type isEqualToString:@"健康"]){
            //健康
            SignUpHealthTaskCell *cell = [SignUpHealthTaskCell creatTableViewCellWithTableView:tableView];
            return cell;
        }else{
            //其他
            SignupOtherTaskCell *cell = [SignupOtherTaskCell creatTableViewCellWithTableView:tableView];
            return cell;
        }
    }else if (indexPath.row == 2) {
        AffirmPersonCell *cell = [AffirmPersonCell creatTableViewCellWithTableView:tableView];
        return cell;
    }
//    else if (indexPath.row == 3) {
//        LeaveMessageCell *cell = [LeaveMessageCell creatTableViewCellWithTableView:tableView];
//        return cell;
//    }
    else{
        MessageDetailCell *cell = [MessageDetailCell creatTableViewCellWithTableView:tableView];
        return cell;
    }
}


#pragma mark  底部按钮方法
- (void)collectMethod:(UIButton *)sender{
    sender.selected = !sender.selected;
    [DWBToast showCenterWithText:@"收藏"];
}

- (void)complainMethod:(UIButton *)sender{
    [DWBToast showCenterWithText:@"投诉"];
}

- (void)stateMethod:(UIButton *)sender{
    [DWBToast showCenterWithText:@"根据订单状态处理"];
}

@end
