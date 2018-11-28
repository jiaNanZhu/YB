//
//  YBTaskMsgViewController.m
//  YBMercenary
//
//  Created by JW on 2018/8/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBTaskMsgViewController.h"
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "WeChatCell.h"
#import "ZhiNengBuyModel.h"
#import "MessageModel.h"
#import "YBSysMessagModel.h"
#import "YBMessagModel.h"
#import "YBTaskMessagModel.h"
@interface YBTaskMsgViewController ()
//@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)NSMutableArray *messageArr;
@property (nonatomic ,strong)UITableView *tableView;

@property(nonatomic,assign)NSInteger page;
@end

@implementation YBTaskMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageArr = [NSMutableArray array];
    
    self.page=1;
    // Do any additional setup after loading the view.
    
//    self.chatSessionInputBarControl.hidden=YES;
//    self.conversationMessageCollectionView.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//
//    [self.conversationDataRepository removeAllObjects];
//
    
//    for (NSDictionary *dict in self.dataArr) {
//    
//        
////        RCMessageModel *model =[[RCMessageModel alloc]init];
////        
////        model.senderUserId=@"酒馆";
////        model.targetId=self.targetId;
//////        model.content=;
////        
////        [self.conversationDataRepository addObject:model];
//    }
//    
//    [self.conversationMessageCollectionView reloadData];

    [self makeNavBar];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [self getDataFromService];
    
    
//    [self UserCenter_message_get];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(void)getDataFromService{
   

    
    
    
    
    if ([self.title isEqualToString:@"酒馆"]) {
        
        for (YBMessagModel *dict in self.dataArr) {
            MessageModel *answerModel=[[MessageModel alloc] init];
            answerModel.showMessageTime=NO;
            
            
            answerModel.messageTime=[self updateTimeForRow:dict.msgtime];
            answerModel.messageText=dict.content;
            answerModel.messageSenderType=MessageSenderTypeHantu;
            answerModel.messageType=MessageTypeText;
            
            //        model.theKeyword=dict.notice_push_content;
            //        NSString *itemStr = model.theKeyword;
            //        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:SetFont(AdFloat(24)),NSFontAttributeName, nil];
            //        CGFloat width = [itemStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
            //        model.width = width;
            [self.messageArr addObject:answerModel];
        }
    }
    
    else if([self.title isEqualToString:@"系统消息"])
    {
        for (YBSysMessagModel *dict in self.dataArr) {
        MessageModel *answerModel=[[MessageModel alloc] init];
        answerModel.showMessageTime=NO;
        
        
        answerModel.messageTime=[self updateTimeForRow:dict.push_time];
        answerModel.messageText=dict.notice_push_content;
        answerModel.messageSenderType=MessageSenderTypeHantu;
        answerModel.messageType=MessageTypeText;
        
        //        model.theKeyword=dict.notice_push_content;
        //        NSString *itemStr = model.theKeyword;
        //        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:SetFont(AdFloat(24)),NSFontAttributeName, nil];
        //        CGFloat width = [itemStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
        //        model.width = width;
        [self.messageArr addObject:answerModel];
    }
        
    }
    
    
    else{
        
        for (YBTaskMessagModel *dict in self.dataArr) {
            MessageModel *answerModel=[[MessageModel alloc] init];
            answerModel.showMessageTime=NO;
            
            
            answerModel.messageTime=[self updateTimeForRow:dict.push_time];
            answerModel.messageText=dict.content;
            answerModel.messageSenderType=MessageSenderTypeHantu;
            answerModel.messageType=MessageTypeText;
            
            //        model.theKeyword=dict.notice_push_content;
            //        NSString *itemStr = model.theKeyword;
            //        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:SetFont(AdFloat(24)),NSFontAttributeName, nil];
            //        CGFloat width = [itemStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
            //        model.width = width;
            [self.messageArr addObject:answerModel];
    }
    }
    
    
           
}
-(void)makeNavBar
{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"消息"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(messageClick)];
}

-(void)messageClick
{
//    if (IsLogin) {
//        self.tabBarController.selectedIndex = 1;
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//        [self toLogin];
//    }
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"notice_hidden" object:nil];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [WeChatCell tableHeightWithModel:self.messageArr[indexPath.row]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeChatCell *cell=[WeChatCell cellWithTableView:tableView messageModel:self.messageArr[indexPath.row]];
    cell.contentView.backgroundColor = RGBColor(245, 245, 245);
    [cell setDoubleClickBlock:^(MessageModel *model) {
        
        
    }];
    
    [cell setSingleblock:^(MessageModel *model) {
        
        //        NSLog(@"%@-----",model.imageUrl);
        
        if (model.messageType==MessageTypeVoice) {
            
        }else if (model.messageType==MessageTypeImage){
            
        }
    }];
    
    return cell;
}
#pragma mark-hpZNBottomViewDelegate
-(void)hpZNBottomViewPostQuestionWithModel:(ZhiNengBuyModel *)model{
    //获取当前时间日期
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"hh:mm"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    //    NSLog(@"%@",dateStr);
    
    MessageModel *sendModel = [[MessageModel alloc]init];
    sendModel.showMessageTime=YES;
    sendModel.messageTime = dateStr;
//    sendModel.logoUrl = [ApplicationManager sharedManager].user.pic;
    sendModel.messageText=model.theKeyword;
    sendModel.messageSenderType=MessageSenderTypeUser;
    sendModel.messageType=MessageTypeText;
    [self.messageArr addObject:sendModel];
    
    MessageModel *answerModel=[[MessageModel alloc] init];
    answerModel.showMessageTime=NO;
    //    answerModel.messageTime=[OverSeaDate getDateString:model.updateTime];
    answerModel.messageText=model.answer;
    answerModel.messageSenderType=MessageSenderTypeHantu;
    answerModel.messageType=MessageTypeText;
    [self.messageArr addObject:answerModel];
    
    [self.tableView reloadData];
}
- (NSString *)updateTimeForRow:(NSString *)createTimeString {
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval createTime = [createTimeString longLongValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger sec = time/60;
    
    if (time <60) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}




#pragma mark request
#pragma mark
-(void)UserCenter_message_get
{
    
    
    [self.dataArr removeAllObjects];
    NSDictionary *parameters =@{@"token":USERTOKEN,@"type":self.type,@"message_id":self.message_id,@"toUserId":self.toUserId,@"page":@(self.page)};//,@"post_type":self.post_type
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_message_info_get parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            
            
            if (self.page==1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *arr = data[@"data"];
            if (arr.count <= 0 && self.page != 1) {
                self.page -=1;
            }
            
            
            for (NSDictionary *dict in data[@"data"]) {
                YBMessagModel *model =[YBMessagModel yy_modelWithDictionary:dict];
                
                RCUserInfo *_currentUserInfo =[[RCUserInfo alloc] initWithUserId:model.fromuserid name:model.fromuser_name portrait:[NSString stringWithFormat:@"%@%@",HOST,model.fromuserhead_img]];
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



@end
