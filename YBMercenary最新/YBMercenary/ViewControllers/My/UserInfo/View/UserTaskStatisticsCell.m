//
//  UserTaskStatisticsCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/24.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "UserTaskStatisticsCell.h"
#import "TaskStarCell.h"

@interface UserTaskStatisticsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *sendView;
@property (nonatomic, strong) UICollectionView *finishView;

//@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation UserTaskStatisticsCell


+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    UserTaskStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTaskStatisticsCell"];
    if (cell == nil) {
        cell = [[UserTaskStatisticsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserTaskStatisticsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}

- (void)initSubViews{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    UILabel *titleLabel = [F_UI SL_UI_Label:@"我的任务" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView).offset(Width(15));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(titleLabel.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(1));
    }];
    
    UILabel *sendLabel = [F_UI SL_UI_Label:@"我发布的" color:[UIColor hex:@"ffffff"] textAlignment:NSTextAlignmentCenter textFont:14 numberOfLines:1];
    sendLabel.backgroundColor = [UIColor hex:Yellow_Color];
    [self.contentView addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Width(15));
        make.left.equalTo(backView).offset(Width(15));
        make.width.mas_equalTo(Width(74));
        make.height.mas_equalTo(Width(25));
    }];
    
    
    CGFloat width = (kScreenWidth - Width(30)) / 6;
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize = CGSizeMake(width, Width(60));
    //单元格之间的水平最小间隙
    _layout.minimumLineSpacing = 0;
    //单元格之间的垂直最小间隙
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _sendView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
    _sendView.delegate = self;
    _sendView.dataSource = self;
    _sendView.scrollEnabled = NO;
    _sendView.backgroundColor = [UIColor whiteColor];
    [_sendView registerClass:[TaskStarCell class] forCellWithReuseIdentifier:@"SendTaskStarCell"];
    [self.contentView addSubview:_sendView];
    [_sendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(sendLabel.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(60));
    }];
    
    UILabel *finishLabel = [F_UI SL_UI_Label:@"我完成的" color:[UIColor hex:@"ffffff"] textAlignment:NSTextAlignmentCenter textFont:14 numberOfLines:1];
    finishLabel.backgroundColor = [UIColor hex:Yellow_Color];
    [self.contentView addSubview:finishLabel];
    [finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendView.mas_bottom).offset(Width(15));
        make.left.equalTo(backView).offset(Width(15));
        make.width.mas_equalTo(Width(74));
        make.height.mas_equalTo(Width(25));
    }];

    _finishView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
    _finishView.delegate = self;
    _finishView.dataSource = self;
    _finishView.scrollEnabled = NO;
    _finishView.backgroundColor = [UIColor whiteColor];
    [_finishView registerClass:[TaskStarCell class] forCellWithReuseIdentifier:@"FinishTaskStarCell"];
    [self.contentView addSubview:_finishView];
    [_finishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(finishLabel.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(60));
        make.bottom.equalTo(backView).offset(-Width(15));
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _sendView) {
        TaskStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SendTaskStarCell" forIndexPath:indexPath];
       
//        cell.dict=self.tasksumModel.publish;
//        cell.index = indexPath.row;
        
        [cell configurationindex:indexPath.row dict:self.tasksumModel.publish];
        return cell;
    }else{
        TaskStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FinishTaskStarCell" forIndexPath:indexPath];
//        cell.dict=self.tasksumModel.receive;
//        cell.index = indexPath.row;
        
        [cell configurationindex:indexPath.row dict:self.tasksumModel.receive];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [DWBToast showCenterWithText:@"查看大图"];
}

// 调整单元格与父视图边界的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Width(10), 0, Width(20));
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTasksumModel:(TasksumModel *)tasksumModel
{
    _tasksumModel =tasksumModel;
    
    [_finishView reloadData];
    
     [_sendView reloadData];
    
}
@end
