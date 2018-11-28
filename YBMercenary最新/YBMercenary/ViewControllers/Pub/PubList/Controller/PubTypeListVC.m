//
//  PubTaskListVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/12.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PubTypeListVC.h"
#import "HotTopicsCell.h"
#import "SendDynamicVC.h"
#import "PubTypeListModel.h"
#import "PostsDetailVC.h"
#import "YBLoginViewController.h"
@interface PubTypeListVC ()

@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation PubTypeListVC
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    
    return _dataArr;
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self setCameraBtn];
//    
//     [self requestCommonDrunkery_post_list];
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_cameraBtn removeFromSuperview];
    _cameraBtn = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum=1;
//    self.navigationItem.title = @"工作酒馆";
    [self creatSubView];
    [self setCameraBtn];
    
    [self requestCommonDrunkery_post_list];
    
   
}

- (void)creatSubView{
    self.tableView.contentInset = UIEdgeInsetsMake(Width(10), 0, 0, 0);
//        [self setCameraBtn];
    

    
     self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        
        [self requestCommonDrunkery_post_list];
    }];
    self.tableView.mj_header.ignoredScrollViewContentInsetTop=Width(10);
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.pageNum +=1;
        [self requestCommonDrunkery_post_list];
    }];
}

- (void)setCameraBtn{
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraBtn.tag = 100;
    [_cameraBtn setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(cameraMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_cameraBtn];
    [_cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationController.view.mas_right).offset(-Width(20));
        make.bottom.equalTo(self.navigationController.view.mas_bottom).offset(-Width(80));
        make.width.height.mas_equalTo(Width(60));
    }];
//    [self.navigationController.view bringSubviewToFront:_cameraBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotTopicsCell *cell = [HotTopicsCell creatTableViewCellWithTableView:tableView];
    
    [cell configurationcellwithmodel:self.dataArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PubTypeListModel *model =  self.dataArr[indexPath.row];
    PostsDetailVC *vc = [[PostsDetailVC alloc]init];
    vc.detailid=model.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)cameraMethod{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [_cameraBtn removeFromSuperview];
    
    
    if ([[YBUser boolLogin] isEqualToString:@""]||[YBUser boolLogin] == nil) {
        [self login];
    }
    else
    {
        SendDynamicVC *vc = [[SendDynamicVC alloc]init];
        vc.task_type=self.task_type;
        vc.task_type_child=self.task_type_child;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
//    }];
//    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [_cameraBtn removeFromSuperview];
//        SendDynamicVC *vc = [[SendDynamicVC alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
//    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:camera];
//    [alert addAction:album];
//    [alert addAction:cancle];
//    [self presentViewController:alert animated:YES completion:nil];
}
-(void)login{
    YBLoginViewController *login = [[YBLoginViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:login];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}


#pragma mark request
#pragma mark
-(void)requestCommonDrunkery_post_list
{
    
    NSDictionary *parameters =@{@"pageNum":@(self.pageNum),@"pageSize":@(10),@"task_type":@(self.task_type),@"task_type_child":@(self.task_type_child)};
    [[YBRequestManager sharedYBManager]postWithUrlString:CommonDrunkery_post_list parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            
            
            if (self.pageNum==1) {
                [self.dataArr removeAllObjects];
            }
            NSArray *arr = data[@"data"];
            if (arr.count <= 0 && self.pageNum != 1) {
                self.pageNum -=1;
            }
            for (NSDictionary *dict  in data[@"data"]) {
                PubTypeListModel *model =[PubTypeListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];
            
        }
        else{
          
//            if (self.pageNum != 1) {
//                 self.pageNum -=1;
//            }
            
            if (self.pageNum == 1) {
                [DWBToast showCenterWithText:data[@"msg"]];
            }
            else{
                [DWBToast showCenterWithText:@"暂无更多"];
            }
            
            
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        if (self.pageNum != 1) {
            self.pageNum -=1;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


@end
