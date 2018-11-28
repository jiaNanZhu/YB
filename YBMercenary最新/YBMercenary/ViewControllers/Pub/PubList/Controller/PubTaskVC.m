//
//  PubTaskVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/12.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PubTaskVC.h"
#import "HomeTaskDetailCell.h"
#import "TaskChoseView.h"
#import "SignUpVC.h"
#import "PubTypeListVC.h"
@interface PubTaskVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *taskChoseBtn;
@property (nonatomic, strong) UIImageView *taskImage;

@property (nonatomic, strong) UIButton *typeChoseBtn;
@property (nonatomic, strong) UIImageView *typeImage;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TaskChoseView *choseView;

@end

@implementation PubTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"酒馆列表";
    [self creatSubView];
}

- (void)creatSubView{
    UIView *topView1 = [[UIView alloc]init];
    topView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView1];
    [topView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.height.mas_equalTo(Width(50));
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    _taskChoseBtn = [F_UI creatBtnWithTager:self title:@"任务列表" font:17 image:nil backImage:nil color:nil textColor:[UIColor hex:Blue_Color] cornerRadius:0 action:@selector(choseTask:)];
    [self.view addSubview:_taskChoseBtn];
    [_taskChoseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView1).offset(-Width(2));
        make.centerY.equalTo(topView1).offset(-Width(1));
    }];
    
    _taskImage = [[UIImageView alloc]init];
    _taskImage.image = [UIImage imageNamed:@"下"];
    [self.view addSubview:_taskImage];
    [_taskImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskChoseBtn.mas_right).offset(Width(4));
        make.centerY.equalTo(_taskChoseBtn);
        make.width.mas_equalTo(Width(12));
        make.height.mas_equalTo(Width(6));
    }];
    
    UIView *topView2 = [[UIView alloc]init];
    topView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView2];
    [topView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.height.mas_equalTo(Width(50));
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    _typeChoseBtn = [F_UI creatBtnWithTager:self title:@"酒馆" font:17 image:nil backImage:nil color:nil textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(choseType:)];
    [self.view addSubview:_typeChoseBtn];
    [_typeChoseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView2);
        make.centerX.equalTo(topView2).offset(-Width(2));
    }];
    
    _typeImage = [[UIImageView alloc]init];
    _typeImage.image = [UIImage imageNamed:@"下"];
    [self.view addSubview:_typeImage];
    [_typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_typeChoseBtn.mas_right).offset(Width(4));
        make.centerY.equalTo(_typeChoseBtn);
        make.width.mas_equalTo(Width(12));
        make.height.mas_equalTo(Width(6));
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor hex:Back_Color];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView1.mas_bottom).offset(Width(10));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    _choseView = [[TaskChoseView alloc]init];
    _choseView.selectIndex=self.selectIndex;
    _choseView.hidden = YES;
    _choseView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    KWeakSelf(self);
    _choseView.choseFinish = ^{
        weakself.choseView.hidden = YES;
        
//        PubTypeListVC *vc = [[PubTypeListVC alloc]init];
//        [weakself.navigationController pushViewController:vc animated:YES];
        
    };
    [self.view addSubview:_choseView];
    [_choseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView1.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTaskDetailCell *cell = [HomeTaskDetailCell creatTableViewCellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SignUpVC *vc = [[SignUpVC alloc]init];
    NSString *type = @"";
    switch (self.selectIndex) {
        case 0:{
            type = @"跑腿";
        }
            break;
        case 1:{
            type = @"生活";
        }
            break;
        case 2:{
            type = @"个人定制";
        }
            break;
        case 3:{
            type = @"工作";
        }
            break;
        case 4:{
            type = @"健康";
        }
            break;
        default:
            type = @"其他";
            break;
    }
    vc.type = self.selectIndex;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)choseTask:(UIButton *)sender{
//    [DWBToast showCenterWithText:@"选择任务排序标准"];
    self.choseView.hidden = NO;
    self.choseView.type = @"mark";
    self.choseView.typeArr = @[@"佣金",@"时间",@"距离"];
    self.choseView.selectIndex = 0;
}


- (void)choseType:(UIButton *)sender{
//    [DWBToast showCenterWithText:@"选择类型"];
    self.choseView.hidden = NO;
    self.choseView.type = @"type";
    self.choseView.typeArr = @[@"跑腿",@"生活",@"个人定制",@"工作",@"健康",@"其他"];
    self.choseView.selectIndex = self.selectIndex;
}

@end
