//
//  UserInfoVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "UserInfoVC.h"
#import "YBMyAchievementViewController.h"
#import "UserInfoCell.h"
#import "UserInfoHeaderCell.h"
#import "UserCredentialCell.h"
#import "UserTaskStatisticsCell.h"
#import "UserInfoModel.h"
#import "DateTool.h"
#import "UservitaeModel.h"
#import "TasksumModel.h"
#import "YBMessageConversationViewController.h"
@interface UserInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *iconImage;//头像
@property (nonatomic, strong) UILabel *nameLabel;//名字
@property (nonatomic, strong) UILabel *dateLabel;//日期
@property (nonatomic, strong) UILabel *fansLabel;//粉丝
@property (nonatomic, strong) UILabel *totalValueLabel;//总价值
@property (nonatomic, strong) UIView *blueView;     //蓝色标志视图

@property (nonatomic, strong) UIButton *followBtn;//关注按钮
@property (nonatomic, strong) UIButton *collectBtn;//收藏按钮

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *identify;

@property (nonatomic, strong) UservitaeModel *uservitaeModel;

@property (nonatomic, strong) TasksumModel *tasksumModel;


@property (nonatomic, strong) UIButton *messageBtn;

@property (nonatomic, strong) UserInfoModel *user;


@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    [self initSubViews];
    
    [self requestuserInfoisself];
    [self requestuserInfo];
    
    [self UserCenter_get_uservitae];
}

- (void)initSubViews{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view).offset(Width(10));
    }];
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    _iconImage.layer.cornerRadius = Width(30);
    _iconImage.layer.masksToBounds = YES;
    [self.view addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView).offset(Width(15));
        make.width.height.mas_equalTo(Width(60));
    }];
    
    _nameLabel = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:16 numberOfLines:1];
    [self.view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.mas_right).offset(Width(12));
        make.centerY.equalTo(_iconImage);
    }];
    
    _dateLabel = [F_UI SL_UI_Label:@"注册于" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:13 numberOfLines:1];
//    _dateLabel.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(Width(20));
        make.centerY.equalTo(_nameLabel);
        
//        make.width.mas_equalTo(70);
    }];
    
    _followBtn = [F_UI creatBtnWithTager:self title:@"+关注" font:15 image:nil backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"f87d6d"] cornerRadius:2 action:@selector(followAction)];
    _followBtn.layer.borderColor = [UIColor hex:@"f87d6d"].CGColor;
    [_followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    _followBtn.layer.borderWidth = 1;
    [self.view addSubview:_followBtn];
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImage);
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.width.mas_equalTo(Width(60));
        make.height.mas_equalTo(Width(25));
    }];
    
    
    
    UILabel *fans = [F_UI SL_UI_Label:@"粉丝:" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:16 numberOfLines:1];
    [self.view addSubview:fans];
    [fans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(Width(20));
    }];
    
    _fansLabel = [F_UI SL_UI_Label:@"0" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:13 numberOfLines:1];
    [self.view addSubview:_fansLabel];
    [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fans.mas_right).offset(Width(8));
        make.centerY.equalTo(fans);
    }];
    
    UILabel *value = [F_UI SL_UI_Label:@"当前总价值:" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:16 numberOfLines:1];
    [self.view addSubview:value];
    [value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(fans.mas_bottom).offset(Width(10));
    }];
    
    _totalValueLabel = [F_UI SL_UI_Label:@"0元" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:13 numberOfLines:1];
    [self.view addSubview:_totalValueLabel];
    [_totalValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(value.mas_right).offset(Width(8));
        make.centerY.equalTo(value);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(value.mas_bottom).offset(Width(15));
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(Width(1));
    }];
    
    UIButton *lvli = [F_UI creatBtnWithTager:self title:@"履历" font:15 image:nil backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"666666"] cornerRadius:0 action:@selector(lvliAction:)];
    lvli.tag = 111;
    [lvli setTitleColor:[UIColor hex:Blue_Color] forState:UIControlStateSelected];
    [self.view addSubview:lvli];
    [lvli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.bottom.equalTo(backView);
        make.width.mas_equalTo(kScreenWidth / 3);
        make.height.mas_equalTo(Width(45));
    }];
    
    UIButton *chengjiu = [F_UI creatBtnWithTager:self title:@"成就" font:15 image:nil backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"666666"] cornerRadius:0 action:@selector(chengjiuAction:)];
    chengjiu.tag = 333;
    [self.view addSubview:chengjiu];
    [chengjiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.equalTo(lvli);
        make.right.equalTo(backView.mas_right);
    }];
    
    UIButton *tongji = [F_UI creatBtnWithTager:self title:@"任务统计" font:15 image:nil backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"666666"] cornerRadius:0 action:@selector(tongjiAction:)];
    tongji.tag = 222;
    [tongji setTitleColor:[UIColor hex:Blue_Color] forState:UIControlStateSelected];
    [self.view addSubview:tongji];
    [tongji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.equalTo(lvli);
        make.right.equalTo(chengjiu.mas_left);
        make.left.equalTo(lvli.mas_right);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor hex:Back_Color];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lvli.mas_right);
        make.centerY.equalTo(lvli);
        make.height.mas_equalTo(Width(20));
        make.width.mas_equalTo(Width(1));
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor hex:Back_Color];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chengjiu.mas_left);
        make.centerY.equalTo(chengjiu);
        make.height.mas_equalTo(Width(20));
        make.width.mas_equalTo(Width(1));
    }];
    
    _blueView = [[UIView alloc]init];
    _blueView.backgroundColor = [UIColor hex:Blue_Color];
    [self.view addSubview:_blueView];
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(backView);
        make.height.mas_equalTo(Width(2));
        make.width.mas_equalTo(kScreenWidth / 3);
    }];
    
    _collectBtn = [F_UI creatBtnWithTager:self title:@"收藏" font:16 image:[UIImage imageNamed:@"collect_no"] backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(collectionAction:)];
    [_collectBtn setImage:[UIImage imageNamed:@"collect_yes"] forState:UIControlStateSelected];
    [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, Width(8))];
    [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, Width(8), 0, 0)];
    [self.view addSubview:_collectBtn];
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.height.mas_equalTo(Width(KTabbarHeight));
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    _messageBtn = [F_UI creatBtnWithTager:self title:@"私信" font:15 image:[UIImage imageNamed:@"信息"] backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"444444"] cornerRadius:0 action:@selector(messageAction)];
    [_messageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, Width(8))];
    [_messageBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, Width(8), 0, 0)];
    [self.view addSubview:_messageBtn];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(Width(KTabbarHeight));
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor hex:Back_Color];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_collectBtn);
        make.height.mas_equalTo(Width(1));
    }];
    
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = [UIColor hex:Back_Color];
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectBtn.mas_right);
        make.centerY.equalTo(_collectBtn);
        make.height.mas_equalTo(Width(1));
        make.width.mas_equalTo(Width(1));
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.backgroundColor = [UIColor hex:Back_Color];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(Width(10));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_collectBtn.mas_top);
    }];

    
    
}
-(void)collectionAction:(UIButton *)btn
{
    
    [self UserCenter_add_care:_followBtn.selected?2:1];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.identify isEqualToString:@"tongji"]) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.identify isEqualToString:@"tongji"]) {
        return 1;
    }else{
        if (section == 0) {
            return 1;
        }else{
            if (self.uservitaeModel) {
              return 2;
            }
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.identify isEqualToString:@"tongji"]) {
        UserTaskStatisticsCell *cell = [UserTaskStatisticsCell creatTableViewCellWithTableView:tableView];
        
        cell.tasksumModel=self.tasksumModel;
        return cell;
    }else{
        if (indexPath.section == 0) {
            UserInfoCell *cell = [UserInfoCell creatTableViewCellWithTableView:tableView];
            
            [cell configurationwith:self.uservitaeModel];
            return cell;
        }else{
            if (indexPath.row == 0) {
                UserInfoHeaderCell *cell = [UserInfoHeaderCell creatTableViewCellWithTableView:tableView];
               
                return cell;
            }else{
                UserCredentialCell *cell = [UserCredentialCell creatTableViewCellWithTableView:tableView];
                [cell configurationwith:self.uservitaeModel];
                return cell;
            }
        }
    }
}

#pragma mark 顶部三个按钮的点击事件
- (void)lvliAction:(UIButton *)sender{
    if (sender.selected) return;
    self.identify = @"lvli";
    UIButton *btn = [self.view viewWithTag:222];
    btn.selected = NO;
    sender.selected = YES;
    [UIView animateWithDuration:0.1 animations:^{
        _blueView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
    [self UserCenter_get_uservitae];
    [self reloadTableView];
}

- (void)tongjiAction:(UIButton *)sender{
    if (sender.selected) return;
    self.identify = @"tongji";
    UIButton *btn = [self.view viewWithTag:111];
    btn.selected = NO;
    sender.selected = YES;
    [UIView animateWithDuration:0.1 animations:^{
        _blueView.transform = CGAffineTransformMakeTranslation(kScreenWidth/3, 0);
    }];
    
    [self UserCenter_get_tasksum];
     [self reloadTableView];
}

- (void)chengjiuAction:(UIButton *)sender{
    YBMyAchievementViewController *vc = [[YBMyAchievementViewController alloc]init];
    vc.otherAchievement = YES;
    vc.navigationItem.title = @"成就";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 关注按钮点击事件
- (void)followAction{
    
    [self UserCenter_add_care:_followBtn.selected?2:1];
}

- (void)messageAction{
    [self pushToChatViewControllerWithChatId:self.user_id title:self.user.name];
//    YBMessageConversationViewController *_conversationVC = [[YBMessageConversationViewController alloc] init];
//    _conversationVC.conversationType = ConversationType_SYSTEM;
//
//    model.touserid=self.user_id;
//
//    model.touser_name=self.user.name;
//    model.touserhead_img=self.user.head_img;
//    _conversationVC.model=model;
//
//    _conversationVC.targetId =self.user_id;
//    _conversationVC.title = self.user.name; // model.conversationTitle;
//    //    _conversationVC.shareModel=shareModel;
//
//    _conversationVC.displayUserNameInCell=NO;
//    _conversationVC.unReadMessage = 0;//未读消息
//    _conversationVC.enableNewComingMessageIcon = NO; //开启消息提醒
//    _conversationVC.enableUnreadMessageIcon = YES;
//    _conversationVC.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:_conversationVC animated:YES];
}

- (void)reloadTableView{
    KWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.tableView reloadData];
        NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark request
#pragma mark 个人资料——基本信息
-(void)requestuserInfo
{
   
    NSDictionary *parameters =@{@"token":USERTOKEN,@"uid":self.user_id};
        [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_get_userinfo parameters:parameters success:^(id data) {
            
            if ([data[@"code"]integerValue] ==0) {
                UserInfoModel *user =[UserInfoModel yy_modelWithDictionary:data[@"data"]];
                
                self.user=user;
                [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,user.head_img]] placeholderImage:SetImage(@"Group1")];
                
                _nameLabel.text=user.name;
                
                _fansLabel.text=user.fans;
                
                
                _totalValueLabel.text=[NSString stringWithFormat:@"%@元",user.total];
                
                _dateLabel.text=[NSString stringWithFormat:@"注册于: %@",[DateTool timeStampToString:[user.create_time integerValue]]];
                
                _followBtn.selected=[user.iscare boolValue];
                _collectBtn.selected=[user.iscare boolValue];
            }
            else{
                [DWBToast showCenterWithText:data[@"msg"]];
            }
        } failure:^(NSError *error) {
            
        }];
}
#pragma mark request
//获取用户信息
-(void)requestuserInfoisself
{
    NSLog(@"%@",USERTOKEN);
        NSDictionary *parameters =@{@"token":USERTOKEN};
        [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_getinfo parameters:parameters success:^(id data) {
            
            if ([data[@"code"]integerValue] ==0) {
                YBUser *user =[YBUser yy_modelWithDictionary:data[@"data"]];
                
                
                if ([self.user_id isEqualToString:user.id]) {
                    _followBtn.hidden=YES;
                    _collectBtn.hidden=YES;
                    _messageBtn.hidden=YES;
                    
                    [_dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_nameLabel.mas_right).offset(Width(20));
                        make.centerY.equalTo(_nameLabel);
                        
                        make.right.mas_equalTo(self.view.mas_right).offset(-AdFloat(15*2));
                    }];
                    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom);
                    }];
                    
                }

                
            }
        } failure:^(NSError *error) {
            
        }];
}

#pragma mark request
#pragma mark 个人资料——我的履历
-(void)UserCenter_get_uservitae
{
    
    NSDictionary *parameters =@{@"token":USERTOKEN,@"uid":self.user_id};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_get_uservitae parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            UservitaeModel *user =[UservitaeModel yy_modelWithDictionary:data[@"data"]];
            self.uservitaeModel=user;
        }
        else{
          [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark request
#pragma mark 个人资料——我的任务
-(void)UserCenter_get_tasksum
{
    
    NSDictionary *parameters =@{@"token":USERTOKEN,@"uid":self.user_id};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_get_tasksum parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            TasksumModel *user =[TasksumModel yy_modelWithDictionary:data[@"data"]];
            
            self.tasksumModel=user;
            
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)UserCenter_add_care:(NSInteger )type
{
    
    //1关注 2取消
    NSDictionary *parameters =@{@"token":USERTOKEN,@"care_user_id":self.user_id,@"type":@(type)};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_add_care parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            
            if (type ==1 ) {
                _followBtn.selected=YES;
                
                _collectBtn.selected=YES;
            }
            else{
                _followBtn.selected=NO;
                _collectBtn.selected=NO;
            }
            
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


@end
