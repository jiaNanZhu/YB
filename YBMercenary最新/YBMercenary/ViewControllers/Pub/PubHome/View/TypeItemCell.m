//
//  TypeItemCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TypeItemCell.h"
#import "MarkItemCell.h"
#import "QL_CustomFlowLayout.h"
#import "PubTaskVC.h"
#import "PubTypeListVC.h"
@interface TypeItemCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *headerImage;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSArray *typeArr;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) NSArray *types;

@end

@implementation TypeItemCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    TypeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeItemCell"];
    if (cell == nil) {
        cell = [[TypeItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TypeItemCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}


- (void)initSubViews{
    
    self.typeArr = @[@[@{@"tag_name":@"跑腿",@"tag_id":@"1"},@{@"tag_name":@"接送人",@"tag_id":@"2"}],
  @[@{@"tag_name":@"衣",@"tag_id":@"1"},@{@"tag_name":@"食",@"tag_id":@"2"},@{@"tag_name":@"住",@"tag_id":@"3"},@{@"tag_name":@"行",@"tag_id":@"1"},@{@"tag_name":@"游",@"tag_id":@"1"}],
  @[@{@"tag_name":@"仕",@"tag_id":@"1"},@{@"tag_name":@"农",@"tag_id":@"2"},@{@"tag_name":@"工",@"tag_id":@"3"},@{@"tag_name":@"商",@"tag_id":@"1"},@{@"tag_name":@"律",@"tag_id":@"1"}],
  
      @[@{@"tag_name":@"硬件",@"tag_id":@"1"},@{@"tag_name":@"软件",@"tag_id":@"2"}],
  
      @[@{@"tag_name":@"减肥",@"tag_id":@"1"},@{@"tag_name":@"健身",@"tag_id":@"2"},@{@"tag_name":@"心理",@"tag_id":@"3"}]];

    self.contentView.backgroundColor = [UIColor hex:Back_Color];

    QL_CustomFlowLayout * flowLayout = [[QL_CustomFlowLayout alloc]initWithType:AlignWithLeft betweenOfCell:Width(15)];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor hex:Back_Color];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerIdentifier"];
    [self.collectionView registerClass:[MarkItemCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Width(10));
        make.left.equalTo(self.contentView).offset(Width(10));
        make.right.equalTo(self.contentView.mas_right).offset(Width(-10));
        make.height.mas_equalTo(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(10));
    }];
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *moreCellIdentifier = @"CellIdentifier";
    MarkItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreCellIdentifier forIndexPath:indexPath];
    ItemData *itemData = [self.listArr objectAtIndex:[indexPath item]];
    cell.content = itemData.content;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemData *itemData = [self.listArr objectAtIndex:[indexPath row]];
    return itemData.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    PubTaskVC *vc = [[PubTaskVC alloc]init];
//    vc.selectIndex = self.typeID - 1;
//    [self.viewController.navigationController pushViewController:vc animated:YES];
    
    
    ItemData *itemData = [self.listArr objectAtIndex:[indexPath item]];
    
//    itemData.tag_name
    if ([self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:tagName:)]) {
        
        [self.delegate didSelectItemAtIndexPath:indexPath.row tagName:itemData.content];
        
    }
    
    
}

- (void)setTypeID:(NSInteger)typeID{
    _typeID = typeID;
    if (self.typeID == 0 || _typeID == self.typeArr.count+1) {
        _types = nil;
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(1));
            make.height.mas_equalTo(Width(0));
        }];
    }else{
        _collectionView.hidden = NO;
        _listArr = [NSMutableArray array];
        _types = self.typeArr[_typeID - 1];
        for (NSDictionary *dic in _types) {
            ItemData *itemData = [[ItemData alloc] init];
            itemData.content = dic[@"tag_name"];
            itemData.tag_id = [dic[@"id"] integerValue];
            CGSize size = [itemData.content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kCellLabelFont,NSFontAttributeName,nil]];
            itemData.size = CGSizeMake(size.width + kCellEmptyWidth,kItemHegith);
            [self.listArr addObject:itemData];
        }
        [_collectionView reloadData];
    }
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_types.count) {
        CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.top.equalTo(self.contentView).offset(Width(10));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(10));
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
