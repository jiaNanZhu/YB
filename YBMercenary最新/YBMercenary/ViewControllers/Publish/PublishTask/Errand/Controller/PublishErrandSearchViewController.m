//
//  PublishErrandSearchViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/20.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishErrandSearchViewController.h"
#import "PublishErrandSearchNavigationView.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearchOption.h>
@interface PublishErrandSearchViewController ()<UITableViewDelegate,UITableViewDataSource,BMKPoiSearchDelegate>
@property (nonatomic ,copy)NSArray *dataArray;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)BMKPoiSearch *poiSearch;
@property (nonatomic ,strong)PublishErrandSearchNavigationView *navigationView;
@end

@implementation PublishErrandSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _poiSearch.delegate = nil;
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(KNavHeight, 0, 0, 0));
    }];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(KNavHeight);
    }];
    // Do any additional setup after loading the view.
}
-(PublishErrandSearchNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[PublishErrandSearchNavigationView alloc]init];
        __weak typeof(self) weakSelf = self;
        _navigationView.searchTextBlock = ^(NSString *text) {

            weakSelf.searchText = text;
        };
    }
    return _navigationView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
-(BMKPoiSearch *)poiSearch{
    if (!_poiSearch) {
        //初始化检索对象
        _poiSearch =[[BMKPoiSearch alloc]init];
        _poiSearch.delegate = self;
    }
    return _poiSearch;
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    BMKPoiInfo *poiInfo = self.dataArray[indexPath.row];
    cell.textLabel.text = poiInfo.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMKPoiInfo *poiInfo = self.dataArray[indexPath.row];
    if (self.selectAddressBlock) {
        self.selectAddressBlock(poiInfo.name);
    }
    UIViewController *viewC = self.navigationController.viewControllers[0];
    viewC.navigationController.navigationBarHidden = NO;
    [self.navigationController popToViewController:viewC animated:YES];
}
-(void)setLatitude:(CGFloat)latitude{
    _latitude = latitude;
}
-(void)setLongitude:(CGFloat)longitude{
    _longitude = longitude;
}
-(void)setType:(NSString *)type{
    _type = type;
}
-(void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    //发起检索
    BMKPOINearbySearchOption *option = [[BMKPOINearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageSize = 10;
    option.location = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    option.keywords = @[self.searchText];
    BOOL flag = [self.poiSearch poiSearchNearBy:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
}
//实现PoiSearchDeleage处理回调结果
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        self.dataArray = poiResult.poiInfoList;
        [self.tableView reloadData];
        
    }else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
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
