//
//  ZJNSearchResultView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/1.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSearchResultView.h"
#import "ZJNSignUpViewController.h"
#import "ZJNSearchResultTableViewCell.h"
@interface ZJNSearchResultView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,copy)NSArray *dataArr;
@property (nonatomic ,strong)UITableView *tableView;
@end
@implementation ZJNSearchResultView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdFloat(225);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJNSearchResultTableViewCell *cell = [ZJNSearchResultTableViewCell creatTableViewCellWithTableView:tableView];
    cell.data = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    ZJNSignUpViewController *vc = [[ZJNSignUpViewController alloc]init];
    vc.type = [dic[@"task_type"] integerValue];
    vc.taskId = [dic[@"id"] integerValue];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

-(void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    [self getDataFromServiceWithSearchText:self.searchText];
}

-(void)getDataFromServiceWithSearchText:(NSString *)searchText{
    [[YBRequestManager sharedYBManager] postWithUrlString:getSearch parameters:@{@"search":searchText} success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            self.dataArr = data[@"data"];
            [self.tableView reloadData];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
