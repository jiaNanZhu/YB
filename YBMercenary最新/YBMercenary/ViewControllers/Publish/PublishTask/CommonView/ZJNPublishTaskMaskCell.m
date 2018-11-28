//
//  ZJNPublishTaskMaskCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNPublishTaskMaskCell.h"
#import "ZJNTaskTequireCollectionViewCell.h"
@interface ZJNPublishTaskMaskCell()<UICollectionViewDelegate,UICollectionViewDataSource,ZJNTaskRequireCollectionCellDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end
@implementation ZJNPublishTaskMaskCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    ZJNPublishTaskMaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJNPublishTaskMaskCell"];
    if (cell == nil) {
        cell = [[ZJNPublishTaskMaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZJNPublishTaskMaskCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor hex:Back_Color];
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews{
    
    self.dataArr=[[NSMutableArray alloc]initWithObjects:@"", nil];
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Width(8));
        make.left.right.bottom.equalTo(self.contentView);
    }];
    
    UILabel *taskRequire = [F_UI SL_UI_Label:@"任务标签" color:[UIColor hex:@"444444"] textAlignment:0 textFont:14 numberOfLines:1];
    [self.contentView addSubview:taskRequire];
    [taskRequire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(Width(10));
        make.left.equalTo(backView).offset(Width(15));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(taskRequire.mas_bottom).offset(Width(10));
        make.height.mas_equalTo(Width(1));
    }];
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize = CGSizeMake(kScreenWidth - Width(30), Width(53));
    //单元格之间的垂直最小间隙
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [_collectionView registerClass:[ZJNTaskTequireCollectionViewCell class] forCellWithReuseIdentifier:@"ZJNTaskTequireCollectionViewCell"];
    _collectionView.collectionViewLayout = self.layout;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    [self.contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(backView).offset(Width(15));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.height.mas_equalTo(Width(53));
    }];
    
    UIButton *addBtn = [F_UI creatBtnWithTager:self title:@"添加标签" font:AdFloat(28) image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:3 action:@selector(addRequireAction)];
    [self.contentView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom).offset(Width(12));
        make.left.equalTo(backView).offset(Width(15) + Width(35) + Width(10));
        make.width.mas_equalTo(Width(90));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(15));
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJNTaskTequireCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZJNTaskTequireCollectionViewCell" forIndexPath:indexPath];
    cell.row = indexPath.row;
    cell.textField.tag=indexPath.row;
    cell.textField.delegate=self;
    cell.textField.text=self.dataArr[indexPath.row];
    [cell.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    cell.delegate = self;
    return cell;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    NSLog(@"%@",self.dataArr);
    if (textField.text.length>0) {
        if (self.publishTaskMaskBlock) {
            self.publishTaskMaskBlock(self.dataArr);
        }
    }
}

-(void)textFieldValueChanged:(UITextField *)textField{
    if (textField.text.length > 5) // MAXLENGTH为最大字数
    {
        textField.text = [textField.text substringToIndex:5]; // MAXLENGTH为最大字数
    }
    [self.dataArr replaceObjectAtIndex:textField.tag withObject:textField.text];
}
// 调整单元格与父视图边界的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setLinecount:(NSInteger)linecount{
    _linecount = linecount;
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Width(54) * linecount);
    }];
    [self.collectionView reloadData];
}

- (void)addRequireAction{
    if (_linecount >=3) {
        return;
    }
    _linecount ++;
    [self.dataArr addObject:@""];
    [self.delegate zjnReloadeViewWithLineCount:_linecount];
}
-(void)zjnDeleteRowWithIndex:(NSInteger)index{
    _linecount -- ;
    [self.dataArr removeObjectAtIndex:index];
    [self.delegate zjnReloadeViewWithLineCount:_linecount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
