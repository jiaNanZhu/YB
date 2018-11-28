//
//  ZJNMessageViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMessageViewController.h"
#import "ZJNMessageHeaderView.h"
//任务消息
#import "ZJNTaskMessageViewController.h"
//私聊消息
#import "ZJNChatMessageViewController.h"
//酒馆消息
#import "ZJNTavernMessageViewController.h"
//系统消息
#import "ZJNSystemMessageViewController.h"

@interface ZJNMessageViewController ()<UIScrollViewDelegate,ZJNMessageHeaderViewDelegate>
@property (nonatomic ,strong)UIScrollView *scrollView;
//容器View
@property (nonatomic ,strong)UIView *containerView;
@property (nonatomic ,strong)ZJNMessageHeaderView *headerView;
@end

@implementation ZJNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    int a = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(6)]];
    NSLog(@"%d",a);
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(AdFloat(105));
    }];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    [self.scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.mas_equalTo(4*kScreenWidth);
        make.height.mas_equalTo(self.scrollView);
    }];
    
    //添加子控制器
    //任务消息
    ZJNTaskMessageViewController *taskMessageVC = [[ZJNTaskMessageViewController alloc]init];
    [self addChildViewController:taskMessageVC];
    [self.containerView addSubview:taskMessageVC.view];
    [taskMessageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.containerView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    //私聊消息
    ZJNChatMessageViewController *chatMessageVC = [[ZJNChatMessageViewController alloc]init];
    [self addChildViewController:chatMessageVC];
    [self.containerView addSubview:chatMessageVC.view];
    [chatMessageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.containerView);
        make.left.equalTo(taskMessageVC.view.mas_right);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    //酒馆消息
    ZJNTavernMessageViewController *tavernMessageVC = [[ZJNTavernMessageViewController alloc]init];
    [self addChildViewController:tavernMessageVC];
    [self.containerView addSubview:tavernMessageVC.view];
    [tavernMessageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.containerView);
        make.left.equalTo(chatMessageVC.view.mas_right);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    //系统消息
    ZJNSystemMessageViewController *systemMessageVC = [[ZJNSystemMessageViewController alloc]init];
    [self addChildViewController:systemMessageVC];
    [self.containerView addSubview:systemMessageVC.view];
    [systemMessageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.containerView);
        make.left.equalTo(tavernMessageVC.view.mas_right);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:6 targetId:@"43"];
    int unRead = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(1),@(6),@(9)]];
    UITabBarItem *item = self.tabBarController.tabBar.items[2];
    item.badgeValue = [NSString stringWithFormat:@"%d",unRead];
}
-(ZJNMessageHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ZJNMessageHeaderView alloc]init];
        _headerView.delegate = self;
    }
    return _headerView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}
-(UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        
        _containerView.backgroundColor = [UIColor redColor];
    }
    return _containerView;
}

#pragma mark-ZJNMessageHeaderViewDelegate
-(void)zjnMessageHeaderViewBtnClickWithTag:(NSInteger)tag{
    if (tag == 0) {
        [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:6 targetId:@"43"];
    }else if (tag == 2){
        [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:6 targetId:@"43"];
    }else if (tag == 3) {
        [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:6 targetId:@"43"];
    }
    
    int unRead = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(1),@(6),@(9)]];
    UITabBarItem *item = self.tabBarController.tabBar.items[2];
    item.badgeValue = [NSString stringWithFormat:@"%d",unRead];
    self.scrollView.contentOffset = CGPointMake(tag*kScreenWidth, 0);
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
