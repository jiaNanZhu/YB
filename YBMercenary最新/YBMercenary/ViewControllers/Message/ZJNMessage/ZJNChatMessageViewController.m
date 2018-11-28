//
//  ZJNChatMessageViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNChatMessageViewController.h"
#import "YBMessageConversationViewController.h"
@interface ZJNChatMessageViewController ()

@end

@implementation ZJNChatMessageViewController
-(id)init{
    self = [super init];
    if (self) {
        //设置需要显示哪些类型的会话
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.conversationListTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    self.conversationListTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    YBMessageConversationViewController *_conversationVC = [[YBMessageConversationViewController alloc] init];
    _conversationVC.conversationType = ConversationType_PRIVATE;
    _conversationVC.targetId = model.targetId;
    _conversationVC.title = model.conversationTitle;
//    _conversationVC.displayUserNameInCell=NO;
    _conversationVC.unReadMessage = 0;//未读消息
    _conversationVC.enableNewComingMessageIcon = YES; //开启消息提醒
    _conversationVC.enableUnreadMessageIcon = YES;
    _conversationVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_conversationVC animated:YES];
    UITabBarItem *item = self.tabBarController.tabBar.items[2];
    NSInteger unreadCount = [item.badgeValue integerValue];
    NSInteger unreadC = unreadCount - model.unreadMessageCount;
    if (unreadC>0) {
        item.badgeValue = [NSString stringWithFormat:@"%ld",unreadC];
    }else{
        item.badgeValue = nil;
    }
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
