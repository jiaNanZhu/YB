//
//  YBPubViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBPubViewController.h"
#import "TypeListCell.h"
#import "TaskListHeaderView.h"
#import "PubTaskListCell.h"
#import "TypeItemCell.h"
#import "PostsDetailVC.h"
#import "PubTypeListVC.h"
#import "PubTypeListModel.h"
#import "ZJNAdsViewController.h"
@interface YBPubViewController ()<UITableViewDelegate,UITableViewDataSource,TypeItemCellDelegate>

@property (nonatomic, strong) UITableView *typeTableView;
@property (nonatomic, strong) NSArray *typeList;
@property (nonatomic, strong) TypeListCell *selectCell;
@property (nonatomic, assign) NSInteger selectSection;

@property (nonatomic, strong) UITableView *taskTableView;
@property (nonatomic, strong) UITableView *taskArr;

@property (nonatomic, strong) TaskListHeaderView *headerView;

@property (nonatomic, assign) CGFloat typecellHeight;
@property (nonatomic, assign) BOOL changeHeight;
@property (nonatomic, strong) NSMutableArray *dataArr;


@property (nonatomic, copy)NSArray *urlArr;
@property (nonatomic, copy)NSArray *imageArr;//轮播图片数组

@end

@implementation YBPubViewController
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _typeList = @[@"热门推荐",@"跑腿",@"生活",@"个人定制",@"工作",@"健康",@"其他"];
    _typeList = @[@"热门推荐",@"跑腿",@"生活",@"个人定制",@"工作",@"健康"];
    
    [self getBannerImagesDataFromService];
    self.navigationItem.title = @"全部分类";
    [self creatSubViews];
    
    [self requestCommonDrunkery_post_list];
}

- (void)creatSubViews{
    _typeTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    _typeTableView.backgroundColor = [UIColor hex:Back_Color];
    _typeTableView.estimatedRowHeight = 100;
    _typeTableView.rowHeight = UITableViewAutomaticDimension;
    _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_typeTableView];
    [_typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.mas_offset(Width(100));
    }];
    
    _taskTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _taskTableView.delegate = self;
    _taskTableView.dataSource = self;
    _taskTableView.backgroundColor = [UIColor hex:Back_Color];
    _taskTableView.estimatedRowHeight = 100;
    _taskTableView.rowHeight = UITableViewAutomaticDimension;
    _taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _taskTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_taskTableView];
    [_taskTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(self.view.mas_right).offset(-Width(10));
        make.bottom.equalTo(self.view);
        make.left.equalTo(_typeTableView.mas_right).offset(Width(10));
    }];
    
    _headerView = [[TaskListHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth -Width(120) , Width(160))];
    _taskTableView.tableHeaderView = _headerView;
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
    [_headerView addGestureRecognizer:myTap];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _typeTableView) {
        return _typeList.count;
    }
    return self.dataArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _typeTableView) {
        TypeListCell *cell = [TypeListCell creatTableViewCellWithTableView:tableView];
        if (self.selectCell == nil) {
            self.selectCell = cell;
        }
        cell.title = self.typeList[indexPath.row];
        return cell;
    }else{
        if (indexPath.row == 0) {
            TypeItemCell *cell = [TypeItemCell creatTableViewCellWithTableView:tableView];
            cell.typeID = self.selectSection;
            self.changeHeight = NO;
            cell.delegate=self;
            return cell;
        }
        PubTaskListCell *cell = [PubTaskListCell creatTableViewCellWithTableView:tableView];
      
        [cell configurationwith:self.dataArr[indexPath.row-1]];
        return cell;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.taskTableView) {
//        if (indexPath.row == 0) {
//            return self.typecellHeight;
//        }
//    }
//    return UITableViewAutomaticDimension;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _typeTableView) {
        if (_selectSection == indexPath.row) return;
        TypeListCell *cell = [_typeTableView cellForRowAtIndexPath:indexPath];
        self.selectCell = cell;
        _selectSection = indexPath.row;
//        _headerView.typeID = indexPath.row;
//        [self.taskTableView reloadData];
        
        [self requestCommonDrunkery_post_list];
        
    }else{
        if (indexPath.row !=0) {
            PubTypeListModel *model=self.dataArr[indexPath.row-1];
            PostsDetailVC *vc = [[PostsDetailVC alloc]init];
            vc.detailid=model.id;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
       
    }
}

- (void)setSelectCell:(TypeListCell *)selectCell{
    if (_selectCell != selectCell) {
        _selectCell.leftView.hidden = YES;
        _selectCell.titleLabel.textColor = [UIColor hex:@"333333"];
        _selectCell = selectCell;
        _selectCell.leftView.hidden = NO;
        _selectCell.titleLabel.textColor = [UIColor hex:Blue_Color];
    }
}


-(void)didSelectItemAtIndexPath:(NSInteger)selectIndex tagName:(NSString *)tagName
{
    PubTypeListVC *vc = [[PubTypeListVC alloc]init];
    
//    NSString *typestr=nil;
//    switch (selectIndex) {
//        case 0:{
//            typestr = @"跑腿";
//        }
//            break;
//        case 1:{
//            typestr = @"生活";
//        }
//            break;
//        case 2:{
//            typestr = @"个人定制";
//        }
//            break;
//        case 3:{
//            typestr = @"工作";
//        }
//            break;
//        case 4:{
//            typestr = @"健康";
//        }
//            break;
//        default:
//            typestr = @"其他";
//            break;
//    }
    vc.task_type=self.selectSection;
    vc.task_type_child=selectIndex+1;
    vc.title=tagName;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark request
#pragma mark
-(void)requestCommonDrunkery_post_list
{
    
    
    if (!self.selectSection) {
        self.selectSection =0;
    }
    NSDictionary *parameters =@{@"pageNum":@(1),@"pageSize":@(10),@"task_type":@(self.self.selectSection),@"task_type_child":@(0)};
    [[YBRequestManager sharedYBManager]postWithUrlString:CommonDrunkery_post_list parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            
            
            [self.dataArr removeAllObjects];
            for (NSDictionary *dict  in data[@"data"]) {
                PubTypeListModel *model =[PubTypeListModel yy_modelWithDictionary:dict];
                [self.dataArr addObject:model];
            }
           
            
        }
        else{
//            [DWBToast showCenterWithText:data[@"msg"]];
            [self.dataArr removeAllObjects];
        }
        
         [_taskTableView reloadData];
        
        
    } failure:^(NSError *error) {
       
    }];
    
}

//获取轮播图
-(void)getBannerImagesDataFromService{
    [[YBRequestManager sharedYBManager] postWithUrlString:getBanner parameters:@{@"type":@(2)} success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *urlTempArr = [NSMutableArray array];
            for (NSDictionary *dic in data[@"data"]) {
                [tempArray addObject:[NSString stringWithFormat:@"%@%@",HOST,dic[@"pic"]]];
                [urlTempArr addObject:[NSString stringWithFormat:@"%@%@",HOST,dic[@"url"]]];
            }
            self.imageArr = tempArray;
            self.urlArr = urlTempArr;
            
            if (tempArray.count>0) {
               [self.headerView.headerImage sd_setImageWithURL:[NSURL URLWithString:tempArray[0]] placeholderImage:[UIImage imageNamed:@"酒馆-顶部-广告"]];
            }
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
    
    if (self.urlArr.count>0) {
        ZJNAdsViewController *viewC = [[ZJNAdsViewController alloc]init];
        viewC.title = @"详情";
        viewC.urlStr = self.urlArr[0];
        viewC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewC animated:YES];
    }
    
}
@end
