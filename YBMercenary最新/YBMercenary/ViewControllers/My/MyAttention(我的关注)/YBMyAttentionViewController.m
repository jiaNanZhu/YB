//
//  YBMyAttentionViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyAttentionViewController.h"
#import "YBMyCollectRTableViewCell.h"
@interface YBMyAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation YBMyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    [self requestUserCenter_get_care];
}
-(UITableView *)tableView
{
    if (_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AdFloat(16), d_Device_width, d_Device_height-iPhone_X_bool_Nav_height-AdFloat(16))];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
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
    return 16;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AdFloat(140);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        YBMyCollectRTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[YBMyCollectRTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMyCollectRTableViewCell"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBLog(@"------ 点击%ld行 ------",(long)indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark request
#pragma mark
-(void)requestUserCenter_get_care
{
    
    NSDictionary *parameters =@{@"token":USERTOKEN};
    
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_get_care parameters:parameters success:^(id data) {
        
        
        [self.dataArr removeAllObjects];
        if ([data[@"code"]integerValue] ==0) {
            
            
            for (NSDictionary *dict in data[@"data"]) {
                
            }
            
            
            
        }
        else if ([data[@"code"]integerValue] ==1)
        {
            
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
@end
