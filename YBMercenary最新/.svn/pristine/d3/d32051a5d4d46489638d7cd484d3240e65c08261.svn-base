//
//  YBMessageSearchViewController.m
//  YBMercenary
//
//  Created by JW on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMessageSearchViewController.h"
#import "BMNavigationBar.h"
#import <RongIMKit/RongIMKit.h>
#import <RongCloudIM/RongIMKit/RCIM.h>
#import "YBMyCollectRTableViewCell.h"
#import "SearchResultModel.h"
#import "YBMessageConversationViewController.h"
@interface YBMessageSearchViewController ()
@property(nonatomic,strong)BMNavigationBar *navbar;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *resultDataSource;

//@property(nonatomic,strong)UISearchBar *searchBar;


@property(nonatomic, strong) UILabel *emptyLabel;
@end

@implementation YBMessageSearchViewController
- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        self.emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, self.view.frame.size.width - 20, 16)];
        self.emptyLabel.font = [UIFont systemFontOfSize:14.f];
        self.emptyLabel.textAlignment = NSTextAlignmentCenter;
        self.emptyLabel.numberOfLines = 0;
        [self.tableView addSubview:self.emptyLabel];
    }
    return _emptyLabel;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView  alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        //        _tableView.backgroundColor=[UIColor clearColor];
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
        _tableView.separatorColor=[UIColor clearColor];
        //        self.tableView.contentInset=UIEdgeInsetsMake(-UITableViewStyleGroupedcontentInset+UITableView_TOP, 0, 0, 0);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight           = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            
        }
    }
    
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navbar.searchBarView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navbar =[[BMNavigationBar alloc]init];
    self.navbar.buttonType= nil;
//    self.navbar.btntitle=kLocalizedString(@"搜索",@"搜索");
    self.navbar.isSearch=YES;
    
    self.navbar.searchBarView.delegate=self;
    
    
    self.navigationItem.titleView=self.navbar;
    
    self.tableView.mj_header=nil;
//    self.tableView.rowHeight=80.f;
    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionFooterHeight=0;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.tableView registerClass:[YBMyCollectRTableViewCell class] forCellReuseIdentifier:@"YBMyCollectRTableViewCell"];
    self.tableView.tableHeaderView=[UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
-(void)clickRightNaviItem
{
    
    [self.navbar.searchBarView resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (![searchText isEqualToString:@""] ||searchText!=nil) {
        [self requestsearchwithsearchText:searchText];
    }
    
    else{
        self.resultDataSource=nil;
        [self.tableView reloadData];
    }
    
    
}

-(void)requestsearchwithsearchText:(NSString *)searchText
{
    
    self.resultDataSource=[[NSMutableArray alloc]init];
    NSArray *array = [[RCIMClient sharedRCIMClient] searchMessages:ConversationType_PRIVATE
                                                          targetId:self.targetId
                                                           keyword:searchText
                                                             count:MAXFLOAT
                                                         startTime:0];
    
    
    for (RCMessage *message in array) {
        
        SearchResultModel *messegeModel =[[SearchResultModel alloc]init];
        
        messegeModel.targetId = self.targetId;
        messegeModel.otherInformation = [RCKitUtility formatMessage:message.content];
        messegeModel.time = message.sentTime;
        
        messegeModel.name = self.model.touser_name;
        messegeModel.portraitUri = self.model.touserhead_img;
        
        [self.resultDataSource addObject:messegeModel];
        
        
    }
    
    
    [self refreshSearchView:searchText];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(140);
}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    [self.searchBars resignFirstResponder];
//}
- (void)refreshSearchView:(NSString *)searchText {
    [self.tableView reloadData];
    NSString *searchStr = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!self.resultDataSource.count && searchText.length > 0 && searchStr.length > 0) {
        NSString *str = [NSString stringWithFormat:@"没有搜索到“%@”相关的内容", searchText];
        self.emptyLabel.textColor = [UIColor hex:@"999999"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor hex:@"0099ff"]
                                 range:NSMakeRange(6, searchText.length)];
        self.emptyLabel.attributedText = attributedString;
        CGFloat height = [self labelAdaptive:str];
        CGRect rect = self.emptyLabel.frame;
        rect.size.height = height;
        self.emptyLabel.frame = rect;
        self.emptyLabel.hidden = NO;
        
    } else {
        self.emptyLabel.hidden = YES;
    }
}
- (CGFloat)labelAdaptive:(NSString *)string {
    float maxWidth = self.view.frame.size.width - 20;
    CGRect textRect =
    [string boundingRectWithSize:CGSizeMake(maxWidth, 8000)
                         options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |
                                  NSStringDrawingUsesFontLeading)
                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]}
                         context:nil];
    textRect.size.height = ceilf(textRect.size.height);
    return textRect.size.height + 5;
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultDataSource.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorColor:[UIColor hex:@"FFEDEDED"]];
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.tableView setSeparatorColor:[UIColor hex:@"FFEDEDED"]];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YBMyCollectRTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[YBMyCollectRTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMyCollectRTableViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.searchString=self.navbar.searchBarView.text;
    
    [cell networkdatawithmsg:self.resultDataSource[indexPath.row]];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultModel *messegeModel = self.resultDataSource[indexPath.row];
    
    YBMessageConversationViewController *_conversationVC = [[YBMessageConversationViewController alloc] init];
    _conversationVC.conversationType = ConversationType_SYSTEM;
    _conversationVC.model=self.model;
    
    _conversationVC.targetId =messegeModel.targetId;
    _conversationVC.title = messegeModel.name; // model.conversationTitle;
    //    _conversationVC.shareModel=shareModel;
    
    _conversationVC.displayUserNameInCell=NO;
    _conversationVC.unReadMessage = 0;//未读消息
    _conversationVC.enableNewComingMessageIcon = NO; //开启消息提醒
    _conversationVC.enableUnreadMessageIcon = YES;
    
    _conversationVC.locatedMessageSentTime = messegeModel.time;
    _conversationVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_conversationVC animated:YES];
    
}


@end
