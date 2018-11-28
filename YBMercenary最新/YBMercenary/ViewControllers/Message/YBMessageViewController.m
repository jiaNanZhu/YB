//
//  YBMessageViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMessageViewController.h"
#import "YBMessageXXTableViewCell.h"
#import "YBMyCollectRTableViewCell.h"
#import "YBMessageConversationViewController.h"
#import "YBMessagModel.h"
#import "YBTaskMsgViewController.h"
#import "YBSysMessagModel.h"
#import "YBTaskMessagModel.h"
@interface YBMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *xianImg;
    int typeBool;
    UILabel *tip;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,assign)NSInteger page;

@end

@implementation YBMessageViewController
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    
    return _dataArr;
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    switch (typeBool) {
//        case 0:
//        {
//            [self UserCenter_notice_get:UserCenter_task_message_get];
//        }
//            break;
//        case 3:
//        {
//            [self UserCenter_notice_get:UserCenter_notice_get];
//        }
//            break;
//        case 2:
//        {
//            [self UserCenter_notice_get:UserCenter_post_get];
//        }
//            break;
//        case 1:
//        {
//            [self UserCenter_message_get];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
//    //设置接收消息代理
//    [RCIM sharedRCIM].receiveMessageDelegate = self;
    self.page=1;
    typeBool =0;
    
    [self UserCenter_notice_get:UserCenter_task_message_get];
    [self headUI];
    
    tip=[[UILabel alloc]init];
    tip.frame=CGRectMake(0,0, kScreenWidth, d_Device_height-iPhone_X_bool_Nav_height-AdFloat(108)-AdFloat(98)-iPhone_X_bool_tabbar_height);
    tip.textAlignment=NSTextAlignmentCenter;
    tip.text=@"暂无消息";
    tip.hidden=YES;
    [self.tableView addSubview:tip];
    
    
    
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        
        
        switch (typeBool) {
            case 0:
                {
                    [self UserCenter_notice_get:UserCenter_task_message_get];
                }
                break;
            case 3:
            {
                [self UserCenter_notice_get:UserCenter_notice_get];
            }
                break;
            case 2:
            {
               [self UserCenter_notice_get:UserCenter_post_get];
            }
                break;
            case 1:
            {
               [self UserCenter_message_get];
            }
                break;
                
            default:
                break;
        }
        
    }];
    self.tableView.mj_header.ignoredScrollViewContentInsetTop=Width(10);
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.page +=1;
        switch (typeBool) {
            case 0:
            {
                [self UserCenter_notice_get:UserCenter_task_message_get];
            }
                break;
            case 3:
            {
                [self UserCenter_notice_get:UserCenter_notice_get];
            }
                break;
            case 2:
            {
                [self UserCenter_notice_get:UserCenter_post_get];
            }
                break;
            case 1:
            {
                [self UserCenter_message_get];
            }
                break;
                
            default:
                break;
        }
    }];
    
    
}
#pragma mark - 切换按钮UI
-(void)headUI{
    _headView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    _headView.frame = CGRectMake(0, 0, d_Device_width, AdFloat(100));
    [self.view addSubview:_headView];
    
    
    xianImg = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"xianIMG"] cornerRadius:0];
    xianImg.frame = CGRectMake(AdFloat(30), AdFloat(95), d_Device_width/4-AdFloat(60), AdFloat(5));
    [_headView addSubview:xianImg];
    
    NSArray *arr = @[@"任务",@"私聊",@"酒馆",@"系统消息"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [F_UI SL_UI_Btn:arr[i] Color:[UIColor hex:@"666666"] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:0];
        btn.frame = CGRectMake(i*(d_Device_width/4), 0, d_Device_width/4, AdFloat(100));
        btn.tag = i+400;
        if (i == 0) {
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
        }
        [_headView addSubview:btn];
    }
    [self.view addSubview:self.tableView];
}
#pragma mark - 选择
-(void)btn:(UIButton *)sender{
    for (int i = 0; i < 4; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:(400+i)];
        if (btn.tag == sender.tag) {
            [btn setUserInteractionEnabled:NO];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                xianImg.frame = CGRectMake(AdFloat(30)+i*(d_Device_width/4), AdFloat(95), d_Device_width/4-AdFloat(60), AdFloat(5));
            }];
            typeBool = i;
            
            if (i==1) {
                [self UserCenter_message_get];
            }
            else if(i == 0){
                [self UserCenter_notice_get:UserCenter_task_message_get];
            }
            else if(i == 3){
                [self UserCenter_notice_get:UserCenter_notice_get];
            }
            else if(i == 2){
                [self UserCenter_notice_get:UserCenter_post_get];
            }
//            [self.tableView reloadData];
        }else{
            [btn setUserInteractionEnabled:YES];
            [btn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
        }
    }
}
-(UITableView *)tableView
{
    if (_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headView.maxY+AdFloat(16), d_Device_width, d_Device_height-iPhone_X_bool_Nav_height-AdFloat(108)-AdFloat(98)-iPhone_X_bool_tabbar_height)];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[YBMessageXXTableViewCell class] forCellReuseIdentifier:@"YBMessageXXTableViewCell"];
        [_tableView registerClass:[YBMyCollectRTableViewCell class] forCellReuseIdentifier:@"YBMyCollectRTableViewCell"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        
    }
    return _tableView;
}
#pragma mark - 分组cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(140);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (typeBool == 1) {
        YBMyCollectRTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[YBMyCollectRTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMyCollectRTableViewCell"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell networkDataCell:self.dataArr[indexPath.row]];
        
        return cell;
    }else{
        YBMessageXXTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[YBMessageXXTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMessageXXTableViewCell"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell networkDataCellmodel:self.dataArr[indexPath.row] type:typeBool];
        return cell;

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBLog(@"------ 点击%ld行 ------",(long)indexPath.row);
    
    
    
    NSString * message_type=@"";
    NSString * message_ids=@"";
    
    switch (typeBool) {
        case 0:
        {
            message_type =@"task";
            
            YBTaskMessagModel*model=  self.dataArr[indexPath.row];
            message_ids=  model.id;
            
        }
            break;
        case 3:
        {
            message_type =@"notice";
            
            YBSysMessagModel*model=  self.dataArr[indexPath.row];
            message_ids=  model.id;
        }
            break;
        case 2:
        {
            message_type =@"post";
            
            YBMessagModel*model=  self.dataArr[indexPath.row];
            message_ids=  model.id;
            
        }
            break;
        case 1:
        {
            message_type =@"message";
         YBMessagModel *model=  self.dataArr[indexPath.row];
            message_ids=  model.id;
        }
            break;
            
        default:
            break;
    }
    
    [self UserCenter_message_read_setmessage_type:message_type message_ids:message_ids];
    
    if (typeBool == 1) {
        
        YBMessagModel*model=  self.dataArr[indexPath.row];
        YBMessageConversationViewController *_conversationVC = [[YBMessageConversationViewController alloc] init];
        _conversationVC.conversationType = ConversationType_SYSTEM;
        _conversationVC.model=model;
        
        _conversationVC.targetId =model.touserid;
        _conversationVC.title = model.touser_name; // model.conversationTitle;
        //    _conversationVC.shareModel=shareModel;
        
        _conversationVC.displayUserNameInCell=NO;
        _conversationVC.unReadMessage = 0;//未读消息
        _conversationVC.enableNewComingMessageIcon = NO; //开启消息提醒
        _conversationVC.enableUnreadMessageIcon = YES;
        _conversationVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }
    
    else{
        
        
        YBTaskMsgViewController *_conversationVC =[[YBTaskMsgViewController alloc]init];
        _conversationVC.dataArr=self.dataArr;
        
//        YBTaskMsgViewController *_conversationVC =[[YBTaskMsgViewController alloc]init];
//
//        _conversationVC.conversationType = ConversationType_SYSTEM;

        switch (typeBool) {
            case 0:
            {
                 _conversationVC.title = @"任务"; //
                
                _conversationVC.type=@"task";
                
                _conversationVC.type=@"task";
                
                YBTaskMessagModel*model=  self.dataArr[indexPath.row];
                _conversationVC.message_id=  model.id;
                _conversationVC.toUserId=model.touserid;
            }
                break;
            case 3:
            {
                _conversationVC.title = @"系统消息"; //
                _conversationVC.type=@"notice";
                
                YBSysMessagModel*model=  self.dataArr[indexPath.row];
                _conversationVC.message_id=  model.id;
                
                
                _conversationVC.toUserId=model.touserid;
            }
                break;
            case 2:
            {
                _conversationVC.title = @"酒馆"; //
                _conversationVC.type=@"post";
                
                YBMessagModel*model=  self.dataArr[indexPath.row];
                _conversationVC.message_id=  model.id;
                _conversationVC.toUserId=model.touserid;
            }
                break;

            default:
                break;
        }

//        _conversationVC.dataArr=self.dataArr;
//        _conversationVC.targetId = _conversationVC.title;
//        //    _conversationVC.shareModel=shareModel;
//
//        _conversationVC.displayUserNameInCell=NO;
//        _conversationVC.unReadMessage = 0;//未读消息
//        _conversationVC.enableNewComingMessageIcon = NO; //开启消息提醒
//        _conversationVC.enableUnreadMessageIcon = YES;
//        _conversationVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:_conversationVC animated:YES];
        
        
        
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark request
#pragma mark 
-(void)UserCenter_message_get
{
   [self.dataArr removeAllObjects];
        NSDictionary *parameters =@{@"token":USERTOKEN,@"page":@(self.page)};
        [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_message_get parameters:parameters success:^(id data) {
            
            if ([data[@"code"]integerValue] ==0) {
                
                if (self.page==1) {
                    [self.dataArr removeAllObjects];
                }
                NSArray *arr = data[@"data"];
                if (arr.count <= 0){
                    
                    tip.hidden=NO;
                }
                else{
                    tip.hidden=YES;
                }
                if (arr.count <= 0 && self.page != 1) {
                    self.page -=1;
                }
                
                for (NSDictionary *dict in data[@"data"]) {
                    YBMessagModel *model =[YBMessagModel yy_modelWithDictionary:dict];
                    
                    RCUserInfo *_currentUserInfo =[[RCUserInfo alloc] initWithUserId:model.touserid name:model.touser_name portrait:[NSString stringWithFormat:@"%@%@",HOST,model.touserhead_img]];
                    [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
                    
                    [self.dataArr addObject:model];
                }
            }
            else
            {
                if (self.page != 1) {
                    self.page -=1;
                }
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            if (self.page != 1) {
                self.page -=1;
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
}

#pragma mark request
#pragma mark
-(void)UserCenter_message_read_setmessage_type:( NSString *)message_type  message_ids:(NSString *)message_ids
{

    //
    NSDictionary *parameters =@{@"token":USERTOKEN,@"message_ids":message_ids,@"message_type":message_type,@"read_status":@"read"};//USERTOKEN
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_message_read_set parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            
        }
    } failure:^(NSError *error) {
        
        
    }];
}


-(void)UserCenter_notice_get:(NSString *)url
{

    if (self.page==1) {
        [self.dataArr removeAllObjects];
    }
    NSDictionary *parameters =@{@"token":USERTOKEN,@"page":@(self.page)};
    [[YBRequestManager sharedYBManager]postWithUrlString:url parameters:parameters success:^(id data) {
        
        
        if ([data[@"code"]integerValue] ==0) {
            
            if (self.page==1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *arr = data[@"data"];
          
            if (arr.count <= 0){
                
                tip.hidden=NO;
            }
            else{
                tip.hidden=YES;
            }
            
            if (arr.count <= 0 && self.page != 1) {
                self.page -=1;
                
            }
            
            if (typeBool ==3) {
                
                for (NSDictionary *dict  in arr) {
                    YBSysMessagModel *model =[YBSysMessagModel yy_modelWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
            }
            else if (typeBool == 0)
            {
                
                for (NSDictionary *dict  in arr) {
                    YBTaskMessagModel *model =[YBTaskMessagModel yy_modelWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
            }
            else{
                for (NSDictionary *dict  in arr) {
                    YBMessagModel *model =[YBMessagModel yy_modelWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
            }
        }
        else
        {
            if (self.page != 1) {
                self.page -=1;
            }
            
        }
         [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        if (self.page != 1) {
            self.page -=1;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
//- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
//    self.page = 1;
//    switch (typeBool) {
//        case 0:
//        {
//            [self UserCenter_notice_get:UserCenter_task_message_get];
//        }
//            break;
//        case 3:
//        {
//            [self UserCenter_notice_get:UserCenter_notice_get];
//        }
//            break;
//        case 2:
//        {
//            [self UserCenter_notice_get:UserCenter_post_get];
//        }
//            break;
//        case 1:
//        {
//            [self UserCenter_message_get];
//        }
//            break;
//
//        default:
//            break;
//    }
//}

@end
