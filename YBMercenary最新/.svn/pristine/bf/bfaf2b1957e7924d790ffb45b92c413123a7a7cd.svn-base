//
//  YBMyAchievementViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyAchievementViewController.h"
#import "YBMyAchievementWCTableViewCell.h"
@interface YBMyAchievementViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *done_achieveArr;
@property(nonatomic,strong)NSMutableArray *not_achieveArr;

@property(nonatomic,strong)NSMutableArray *xunzhangArr;


@end

@implementation YBMyAchievementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.done_achieveArr =[[NSMutableArray alloc]init];
    self.not_achieveArr =[[NSMutableArray alloc]init];
    self.xunzhangArr =[[NSMutableArray alloc]init];
    
    [self UserCenter_my_achieve];
    
}
#pragma mark - UI
-(void)makeUI{
    UIView *backdropView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backdropView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(306));
    [self.view addSubview:backdropView];
    
    UIImageView *backdropImg = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"my_Achievement_xian"] cornerRadius:0];
    backdropImg.frame = CGRectMake(0, AdFloat(20), AdFloat(232), AdFloat(48));
    [backdropView addSubview:backdropImg];
    
    UILabel *medalLab = [F_UI SL_UI_Label:@"最近获得3枚勋章" color:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:AdFloat(26) numberOfLines:1];
    medalLab.frame = CGRectMake(0, 0, backdropImg.width, backdropImg.height);
    [backdropImg addSubview:medalLab];
    
    UIImageView *leftIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"勋章"] cornerRadius:0];
    leftIMG.frame = CGRectMake(AdFloat(80), AdFloat(96), AdFloat(170), AdFloat(170));
    [backdropView addSubview:leftIMG];
    
    UIImageView *centerIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"勋章"] cornerRadius:0];
    centerIMG.frame = CGRectMake(leftIMG.maxX+AdFloat(30), AdFloat(86), AdFloat(190), AdFloat(190));
    [backdropView addSubview:centerIMG];
    
    UIImageView *rightIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"勋章"] cornerRadius:0];
    rightIMG.frame = CGRectMake(centerIMG.maxX+AdFloat(30), AdFloat(96), AdFloat(170), AdFloat(170));
    [backdropView addSubview:rightIMG];
    if (self.xunzhangArr.count<=0) {
        backdropView.hidden=YES;
    }
    
    
    
    switch (self.xunzhangArr.count) {
        case 1:
        {
            
            NSDictionary *dict =(NSDictionary *)self.xunzhangArr[0];
            [centerIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,dict[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
        }
            break;
        case 2:
        {
            
            NSDictionary *dict =(NSDictionary *)self.xunzhangArr[0];
            NSDictionary *leftdict =(NSDictionary *)self.xunzhangArr[1];
            [centerIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,dict[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
            
            [leftIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,leftdict[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
        }
            break;
        case 3:
        {
            NSDictionary *dict =(NSDictionary *)self.xunzhangArr[0];
            NSDictionary *leftdict =(NSDictionary *)self.xunzhangArr[1];
            NSDictionary *rightdict =(NSDictionary *)self.xunzhangArr[2];
            [centerIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,dict[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
            
            [leftIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,leftdict[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
            [rightIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,rightdict[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
        }
            break;
            
        default:
            break;
    }
    
    [self.view addSubview:self.tableView];
}
#pragma mark - UI
-(UITableView *)tableView
{
    if (_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AdFloat(338), d_Device_width, d_Device_height-AdFloat(338)-iPhone_X_bool_Nav_height)  style:UITableViewStyleGrouped];
        
        
        if (self.xunzhangArr.count<=0) {
            _tableView.frame=CGRectMake(0, AdFloat(0), d_Device_width, d_Device_height-AdFloat(338)-iPhone_X_bool_Nav_height) ;
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[YBMyAchievementWCTableViewCell class] forCellReuseIdentifier:@"YBMyAchievementWCTableViewCell"];
//        [_tableView registerClass:[DSCompetitionCSGODZXQZDTableViewCell class] forCellReuseIdentifier:@"DSCompetitionCSGODZXQZDTableViewCell"];
        _tableView.backgroundColor = [UIColor hex:@"F2F2F2"];
        _tableView.sectionHeaderHeight = 8;
        _tableView.sectionFooterHeight = 8;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
#pragma mark - 分组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.otherAchievement) {
        return 1;
    }else{
        return 2;
    }
}

#pragma mark - 分组头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AdFloat(92);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.done_achieveArr.count;
    }
    return self.not_achieveArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(182);
}
#pragma mark - 分组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * titleArray = @[@"已完成成就",@"未完成成就"];
    NSArray *imgArr = @[@"my_Achievement_W",@"my_Achievement_WW"];
    UIView *view = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    view.frame = CGRectMake(0, 0, d_Device_width, AdFloat(90));
    
    UIImageView *img = [F_UI SL_UI_UIimg:[UIImage imageNamed:imgArr[section]] cornerRadius:0];
    img.frame = CGRectMake(AdFloat(30), AdFloat(22), AdFloat(30), AdFloat(46));
    [view addSubview:img];
    
    UILabel *titleLab = [F_UI SL_UI_Label:titleArray[section] color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(30) numberOfLines:1];
    titleLab.frame = CGRectMake(img.maxX+AdFloat(16), 0, AdFloat(200), AdFloat(90));
    [view addSubview:titleLab];
    
    UIView *xianView = [F_UI SL_UI_View:[UIColor hex:@"F2F2F2"] cornerRadius:0 borderColor:nil borderWidth:0];
    xianView.frame = CGRectMake(0, AdFloat(88), d_Device_width, AdFloat(2));
    [view addSubview:xianView];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        YBMyAchievementWCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[YBMyAchievementWCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMyAchievementWCTableViewCell"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
      [cell networkDataCell:self.done_achieveArr[indexPath.row] row:(int)indexPath.row section:(int)indexPath.section];
    }
    else
    {
        [cell networkDataCell:self.not_achieveArr[indexPath.row] row:(int)indexPath.row section:(int)indexPath.section];
    }
    
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark request
#pragma mark
-(void)UserCenter_my_achieve
{
    
    NSDictionary *parameters =@{@"token":USERTOKEN};
    
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_my_achieve parameters:parameters success:^(id data) {
        
        
        //        [self.dataArr removeAllObjects];
        if ([data[@"code"]integerValue] ==0) {
            
            
            
            
            
            for (NSDictionary *dict in data[@"data"][@"done_achieve"]) {
                
                [self.done_achieveArr addObject:dict];
                
            }
            
            
            for (NSDictionary *dict in data[@"data"][@"not_achieve"]) {
                
                [self.not_achieveArr addObject:dict];
                
            }
            
            for (NSDictionary *dict in data[@"data"][@"xunzhang"]) {
                
                [self.xunzhangArr addObject:dict];
            }
            
            [self makeUI];
            [self.tableView reloadData];
            
            
        }
        else if ([data[@"code"]integerValue] ==1)
        {
            
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
