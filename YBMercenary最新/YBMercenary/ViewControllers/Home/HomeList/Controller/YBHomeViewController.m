//
//  YBHomeViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBHomeViewController.h"
#import "AdsCell.h"
#import "ZJNHomeTypeTableViewCell.h"
#import "HomeTaskCell.h"
#import "HotTopicsHeaderCell.h"
#import "HotTopicsCell.h"
#import "NavHeaderView.h"
#import "ChoseCityListVC.h"
#import "PubTypeListModel.h"
#import "ZJNDoubleBtnView.h"
#import "HomeTaskDetailCell.h"
#import "ZJNSignUpViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "ZJNPerfectInfoViewController.h"
@interface YBHomeViewController ()<BMKLocationServiceDelegate>
@property (nonatomic, copy)NSString *kType;
@property (nonatomic, copy)NSArray *urlArr;
@property (nonatomic, copy)NSArray *imageArr;//轮播图片数组
@property (nonatomic, strong)NSMutableArray *hotPostArr;//热门帖子
@property (nonatomic, strong)NavHeaderView *navHeaderView;
@property (nonatomic, copy)NSDictionary *taskListDic;
@property (nonatomic, strong)BMKLocationService *locService;
@end

@implementation YBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    self.hotPostArr = [NSMutableArray array];
    _kType = @"left";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    [self configTableView];
    
    if (USERTOKEN) {
        NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:PREFECTINFO];
        NSLog(@"____%@",string);
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:PREFECTINFO] isEqualToString:@"1"]) {
            UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:@"去完善信息" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ZJNPerfectInfoViewController *viewC = [[ZJNPerfectInfoViewController alloc]init];
                [self.navigationController pushViewController:viewC animated:NO];
            }];
            [okAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
            [actionSheetController addAction:okAction];
            [actionSheetController addAction:cancelAction];
            [self presentViewController:actionSheetController animated:YES completion:nil];
        }
    }
    
}

//获取轮播图
-(void)getBannerImagesDataFromService{
    [[YBRequestManager sharedYBManager] postWithUrlString:getBanner parameters:@{@"type":@(1)} success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *urlTempArr = [NSMutableArray array];
            for (NSDictionary *dic in data[@"data"]) {
                [tempArray addObject:[NSString stringWithFormat:@"%@%@",HOST,dic[@"pic"]]];
                [urlTempArr addObject:[NSString stringWithFormat:@"%@",dic[@"url"]]];
            }
            self.imageArr = tempArray;
            self.urlArr = urlTempArr;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

//获取热门帖子
-(void)getHotPostDataFromService{
    
    [[YBRequestManager sharedYBManager] postWithUrlString:hotPost parameters:@{@"pageNum":@(1)} success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            NSArray *array = data[@"data"];
            for (NSDictionary *dic in array) {
                PubTypeListModel *model = [PubTypeListModel yy_modelWithDictionary:dic];
                [self.hotPostArr addObject:model];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

//获取任务列表
-(void)getTaskListDataFromService{
    NSString *cityStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCity"];
    [[YBRequestManager sharedYBManager] postWithUrlString:indexTask parameters:@{@"city":cityStr} success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            self.taskListDic = data[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)initNav{
    self.navigationItem.titleView = self.navHeaderView;
}
- (NavHeaderView *)navHeaderView{
    if (!_navHeaderView) {
        _navHeaderView = [[NavHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhone_X_bool_Nav_height)];
        NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCity"];
        _navHeaderView.cityName = cityName;
        __weak typeof(self)weakSelf = self;
        _navHeaderView.navHeaderBlock = ^(NSString *cityName) {
            [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"locationCity"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [weakSelf getTaskListDataFromService];
        };
    }
    return _navHeaderView;
}
- (void)configTableView{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor hex:Back_Color];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return AdFloat(100);
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        if ([self.kType isEqualToString:@"left"]) {
            NSArray *arr = self.taskListDic[@"tuijian"];
            return arr.count;
        }else{
            NSArray *arr = self.taskListDic[@"same_city"];
            return arr.count;
        }
    }else{
        return self.hotPostArr.count+1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        ZJNDoubleBtnView *btnView = [[ZJNDoubleBtnView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, AdFloat(100))];
        [btnView.leftButton setTitle:@"推荐" forState:UIControlStateNormal];
        [btnView.rightButton setTitle:@"同城" forState:UIControlStateNormal];
        btnView.type = self.kType;
        btnView.tableViewReloadBlock = ^(NSString *type) {
            self.kType = type;
            [self.tableView reloadData];
        };
        return btnView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AdsCell *cell = [AdsCell creatTableViewCellWithTableView:tableView];
            cell.images = _imageArr;
            cell.urlArray = self.urlArr;
            return cell;
        }else{
            ZJNHomeTypeTableViewCell *cell = [ZJNHomeTypeTableViewCell creatTableViewCellForTableView:tableView];
            cell.refreshListBlock = ^{
                [self.tableView reloadData];
            };
            return cell;
        }

    }else if (indexPath.section == 1){
        HomeTaskDetailCell *cell = [HomeTaskDetailCell creatTableViewCellWithTableView:tableView];
        if ([self.kType isEqualToString:@"left"]) {
            NSArray *arr = self.taskListDic[@"tuijian"];
            cell.data = arr[indexPath.row];
        }else{
            NSArray *arr = self.taskListDic[@"same_city"];
            cell.data = arr[indexPath.row];
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            HotTopicsHeaderCell *cell = [HotTopicsHeaderCell creatTableViewCellWithTableView:tableView];
            return cell;
        }else{
            HotTopicsCell *cell = [HotTopicsCell creatTableViewCellWithTableView:tableView];
            [cell configurationcellwithmodel:self.hotPostArr[indexPath.row-1]];
            return cell;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSDictionary *dic;
        if ([self.kType isEqualToString:@"left"]) {
            NSArray *arr = self.taskListDic[@"tuijian"];
            dic = arr[indexPath.row];
        }else{
            NSArray *arr = self.taskListDic[@"same_city"];
            dic = arr[indexPath.row];
        }
        ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
        vc.type = [dic[@"task_type"] integerValue];
        vc.taskId = [dic[@"id"] integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    NSLog(@"%f",userLocation.location.coordinate.latitude);
    CLLocation *location = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            //编码失败，找不到地址
            DBLog(@"你现在可能在月球上%@",error);
            //定位失败 默认城市为背景
            self.navHeaderView.cityName = @"北京";
            [[NSUserDefaults standardUserDefaults] setObject:@"北京" forKey:@"locationCity"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            /*
             编码成功
             */
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            /*
             firstPlacemark.ISOcountryCode  国家编码 ：中国（CN）
             firstPlacemark.country   国家
             firstPlacemark.administrativeArea  省份
             firstPlacemark.locality   城市
             firstPlacemark.subLocality  区
             firstPlacemark.thoroughfare 街道
             firstPlacemark.addressDictionary  字典，包含地址的一些基本信息
             */
            NSString *cityName = firstPlacemark.locality;
            if([cityName length] > 0){
                cityName = [cityName substringToIndex:([cityName length]-1)];// 去掉最后一个“市”
            }else{
                cityName = @"北京";
            }
            NSString *cityN = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCity"];
            if (cityN.length == 0) {
                self.navHeaderView.cityName = cityName;
                [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"locationCity"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                if (cityN != cityName) {
                    [self showAlertWithCityName:cityName];
                }
            }
        }
        [self getBannerImagesDataFromService];
        [self getHotPostDataFromService];
        [self getTaskListDataFromService];
    }];
    [_locService stopUserLocationService];
    
}
-(void)showAlertWithCityName:(NSString *)cityName{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"系统定位到您当前位于:%@ 是否切换位置",cityName] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.navHeaderView.cityName = cityName;
        [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"locationCity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [alertC addAction:cancelA];
    [alertC addAction:okA];
    [self presentViewController:alertC animated:YES completion:nil];
    
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
