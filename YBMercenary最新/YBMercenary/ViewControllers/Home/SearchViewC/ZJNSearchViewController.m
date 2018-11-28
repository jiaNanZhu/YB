//
//  ZJNSearchViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/1.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSearchViewController.h"
#import "ZJNSearchNavView.h"
#import "ZJNSearchCollectionReusableView.h"
#import "ZJNSearchCollectionViewFlowLayout.h"
#import "ZJNSearchCollectionViewCell.h"
#import "ZJNSearchResultView.h"
#import "ZJNFMDBManager.h"
@interface ZJNSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)ZJNSearchNavView *searchNavView;
@property (nonatomic ,strong)ZJNSearchResultView *resultView;
@property (nonatomic ,copy)NSArray *cacheArr;
@property (nonatomic ,copy)NSArray *hotArr;
@end

@implementation ZJNSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cacheArr = [[ZJNFMDBManager sharedInstance] getAllSearchText];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchNavView];
    [self.searchNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KNavHeight);
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(KNavHeight, 0, 0, 0));
    }];
    [self getDataFromService];
    // Do any additional setup after loading the view.
}
-(void)getDataFromService{
    [[YBRequestManager sharedYBManager] postWithUrlString:getHotSearch parameters:nil success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            _hotArr = data[@"data"];
            [self.collectionView reloadData];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
-(ZJNSearchResultView *)resultView{
    if (!_resultView) {
        _resultView = [[ZJNSearchResultView alloc]initWithFrame:CGRectMake(0, KNavHeight, kScreenWidth, kScreenHeight-KNavHeight)];
    }
    return _resultView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        ZJNSearchCollectionViewFlowLayout *flowLayout = [[ZJNSearchCollectionViewFlowLayout alloc]init];
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, AdFloat(108));
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[ZJNSearchCollectionViewCell class] forCellWithReuseIdentifier:@"HplCellID"];
        [_collectionView registerClass:[ZJNSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"supplementary"];
    }
    return _collectionView;
}
-(ZJNSearchNavView *)searchNavView{
    if (!_searchNavView) {
        __weak typeof(self)weakSelf = self;
        _searchNavView = [[ZJNSearchNavView alloc]init];
        _searchNavView.searchNavViewBlock = ^(NSString *searchText) {
            [weakSelf.view addSubview:weakSelf.resultView];
            weakSelf.resultView.searchText = searchText;
        };
        _searchNavView.hideResultViewBlock = ^{
            [weakSelf.resultView removeFromSuperview];
        };
    }
    return _searchNavView;
}
#pragma mark-

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotArr.count;
    }
    return self.cacheArr.count;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZJNSearchCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"supplementary" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            view.clearBtn.hidden = YES;
            view.titleLabel.text = @"热门搜索";
        }else{
            view.clearBtn.hidden = NO;
            view.titleLabel.text = @"历史记录";
            if (self.cacheArr.count == 0) {
                view.clearBtn.hidden = YES;
            }else{
                [view.clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        return view;
    }else{
        return nil;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJNSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HplCellID" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSDictionary *dic = self.hotArr[indexPath.row];
        cell.contentLabel.text = dic[@"search_content"];
    }else{
        cell.contentLabel.text = self.cacheArr[indexPath.row];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemStr;
    if (indexPath.section == 0) {
        NSDictionary *dic = self.hotArr[indexPath.row];
        itemStr = dic[@"search_content"];
    }else{
        itemStr = self.cacheArr[indexPath.row];
    }
    
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:AdFloat(28)],NSFontAttributeName, nil];
    CGSize size = [itemStr boundingRectWithSize:CGSizeMake(kScreenWidth-AdFloat(60), AdFloat(60)) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    size.width += AdFloat(80);
    size.height = AdFloat(60);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view addSubview:self.resultView];
    if (indexPath.section == 0) {
        NSDictionary *dic = self.hotArr[indexPath.row];
        self.searchNavView.searchText = dic[@"search_content"];
        self.resultView.searchText = dic[@"search_content"];
        [[ZJNFMDBManager sharedInstance] addSearchTextWithSearchText:dic[@"search_content"]];
    }else{
        self.searchNavView.searchText = self.cacheArr[indexPath.row];
        self.resultView.searchText = self.cacheArr[indexPath.row];
    }
}

#pragma mark-清空缓存
-(void)clearBtnClick{
    [[ZJNFMDBManager sharedInstance] deleteAllSearchText];
    self.cacheArr = [[ZJNFMDBManager sharedInstance] getAllSearchText];
    [self.collectionView reloadData];
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
