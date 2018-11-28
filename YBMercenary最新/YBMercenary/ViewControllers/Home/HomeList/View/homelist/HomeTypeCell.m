//
//  HomeTypeCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "HomeTypeCell.h"
#import "TypeSingleCell.h"
#import "TaskListVC.h"
@interface HomeTypeCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation HomeTypeCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    HomeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTypeCell"];
    if (cell == nil) {
        cell = [[HomeTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTypeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleArr = @[@"跑腿",@"生活",@"个人定制",@"工作",@"身心",@"其他",@"",@"",@"",@""];
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    CGFloat width = (kScreenWidth - Width(20)) / 5;
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.minimumInteritemSpacing = 0;
    _layout.itemSize = CGSizeMake(width, width);
    //单元格之间的垂直最小间隙
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [_collectionView registerClass:[TypeSingleCell class] forCellWithReuseIdentifier:@"TypeSingleCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = YES;
    _collectionView.pagingEnabled = YES;
    [self.contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(AdFloat(170));
    }];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = 2;//指定页面个数
    _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor whiteColor];
    //添加委托方法，当点击小白点就执行此方法
    _pageControl.pageIndicatorTintColor = [UIColor hex:Back_Color];// 设置非选中页的圆点颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor hex:Blue_Color]; // 设置选中页的圆点颜色
    [self.contentView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-AdFloat(16));
        make.top.equalTo(_collectionView.mas_bottom).offset(0);
        make.left.right.equalTo(self.contentView);
    }];
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TypeSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeSingleCell" forIndexPath:indexPath];
    cell.title = self.titleArr[indexPath.row];
    return cell;
}

// 调整单元格与父视图边界的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Width(10), 0, Width(10));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titleArr[indexPath.row];
    if (title.length > 0) {
        TaskListVC *vc = [[TaskListVC alloc]init];
        vc.type = indexPath.row+1;
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    if (x > 100) {
        _pageControl.currentPage = 1;
    }else{
        _pageControl.currentPage = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
