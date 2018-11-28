//
//  ZJNIncomeDetailViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNIncomeDetailViewController.h"
#import "IncomeDetailTableViewCell.h"
#import "IncomeTimeTableViewCell.h"
#import "SelectedTimeView.h"
#import "ZJNTopBtnView.h"
@interface ZJNIncomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)SelectedTimeView *timeView;
@property (nonatomic ,strong)UITableView      *tableView;
@property (nonatomic ,strong)ZJNTopBtnView    *topBtnView;
//0 全部 1收入 2支出
@property (nonatomic ,assign)NSInteger         detailType;
@property (nonatomic ,copy)NSString *dateStr;
@property (nonatomic ,copy)NSString *orderType;
@property (nonatomic ,copy)NSArray  *zcArr;
@property (nonatomic ,copy)NSArray  *srArr;
@property (nonatomic ,copy)NSArray  *totalArr;
@property (nonatomic ,copy)NSString *totalZC;
@property (nonatomic ,copy)NSString *totalSR;
@property (nonatomic ,copy)NSString *sYear;

@end

@implementation ZJNIncomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"零钱明细";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topBtnView];
    [self.topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(44, 0, 0, 0));
    }];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    self.dateStr = [formatter stringFromDate:currentDate];
    self.orderType = @"ASC";
    self.detailType = 0;
    [self getDataFromService];
    // Do any additional setup after loading the view.
}
-(void)getDataFromService{
    NSArray *array = [self.dateStr componentsSeparatedByString:@"-"];
    NSInteger year = [array[0] integerValue];
    NSInteger month = [array[1] integerValue];
    NSDictionary *dic = @{@"token":USERTOKEN,@"order_type":self.orderType,@"year":@(year),@"month":@(month)};
    [[YBRequestManager sharedYBManager] postWithUrlString:getMingXi parameters:dic success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            self.zcArr    = data[@"data"][@"zhichu"];
            self.srArr    = data[@"data"][@"shouru"];
            self.totalArr = data[@"data"][@"all"];
            self.totalSR  = data[@"data"][@"shouru_total"];
            self.totalZC  = data[@"data"][@"zhichu_total"];
            self.sYear    = data[@"data"][@"date"][@"year"];
            [self.tableView reloadData];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
-(SelectedTimeView *)timeView{
    if (!_timeView) {
        _timeView = [[SelectedTimeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _timeView;
}
-(ZJNTopBtnView *)topBtnView{
    if (!_topBtnView) {
        _topBtnView = [[ZJNTopBtnView alloc]init];
        __weak typeof(self) weakSelf = self;
        _topBtnView.refreshListBlock = ^(NSDictionary *dic) {
            if ([dic[@"tag"] integerValue] == 10) {
                //0全部 1收入 2支出
                weakSelf.detailType = [dic[@"index"] integerValue];
                [weakSelf getDataFromService];
            }else{
                //0由远及近 1由近及远
                if ([dic[@"index"] integerValue] == 0) {
                    weakSelf.orderType = @"ASC";
                }else{
                    weakSelf.orderType = @"DESC";
                }
                [weakSelf getDataFromService];
            }
        };
    }
    return _topBtnView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (self.detailType == 0) {
        return self.totalArr.count;
    }else if (self.detailType == 1){
        return self.srArr.count;
    }else{
        return self.zcArr.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return AdFloat(150);
    }
    return AdFloat(140);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellid = @"cellID";
        IncomeTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[IncomeTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.timeButton addTarget:self action:@selector(selectTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cell.timeLabel.text = self.dateStr;
        cell.incomeLabel.text = [NSString stringWithFormat:@"收入 ¥%@",self.totalSR];
        cell.expenditureLabel.text = [NSString stringWithFormat:@"支出 ¥%@",self.totalZC];
        return cell;
    }else{
        static NSString *cellid = @"cellid";
        IncomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[IncomeDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dic;
        if (self.detailType == 0) {
            dic = self.totalArr[indexPath.row];
        }else if (self.detailType == 1){
            dic = self.srArr[indexPath.row];
        }else{
            dic = self.zcArr[indexPath.row];
        }
        cell.titleLabel.text = dic[@"task_name"];
        cell.contentLabel.text = dic[@"task_description"];
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"money"]];
        return cell;
    }
}

#pragma mark-选择时间
-(void)selectTimeBtnClick{
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentDYear = [formatter stringFromDate:currentDate];
    NSInteger startY = [self.sYear integerValue];
    NSInteger cYear = [currentDYear integerValue];

    
    NSMutableArray *tempArr = [NSMutableArray array];
    if (startY == cYear) {
        [tempArr addObject:[@(startY) stringValue]];
    }else{
        for (int i = 0; i <cYear-startY+1; i++) {
            [tempArr addObject:[NSString stringWithFormat:@"%ld",startY+i]];
        }
    }
    [BRStringPickerView showStringPickerWithTitle:@"请选择日期" dataSource:@[[tempArr copy],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]] defaultSelValue:@"2018" resultBlock:^(id selectValue) {
    
        self.dateStr = [NSString stringWithFormat:@"%@-%@",selectValue[0],selectValue[1]];
        [self getDataFromService];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
