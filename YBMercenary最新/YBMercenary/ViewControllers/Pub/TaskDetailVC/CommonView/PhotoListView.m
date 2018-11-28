//
//  PhotoListView.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PhotoListView.h"
#import "TopicsImageCell.h"

@interface PhotoListView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation PhotoListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cretaSubViews];
    }
    return self;
}

- (void)cretaSubViews{
    CGFloat width = (kScreenWidth - Width(40)) / 3;
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize = CGSizeMake(width, width);
    //单元格之间的水平最小间隙
    _layout.minimumLineSpacing = Width(5);
    //单元格之间的垂直最小间隙
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [_collectionView registerClass:[TopicsImageCell class] forCellWithReuseIdentifier:@"TopicsImageCell"];
    _collectionView.collectionViewLayout = self.layout;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
//    _collectionView.scrollEnabled = NO;
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(width);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.model.imageList.count;
    return self.imageList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopicsImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopicsImageCell" forIndexPath:indexPath];
    DBLog(@"%@",[NSString stringWithFormat:@"%@/%@",HOST,self.imageList[indexPath.row]]);
    [cell.zoneImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",HOST,self.imageList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"发帖图"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [DWBToast showCenterWithText:@"查看大图"];
    if (self.showImageBlock) {
        self.showImageBlock(indexPath.row);
    }
}

// 调整单元格与父视图边界的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)setImageList:(NSArray *)imageList{
    _imageList = imageList;
    [self.collectionView reloadData];
}
@end
