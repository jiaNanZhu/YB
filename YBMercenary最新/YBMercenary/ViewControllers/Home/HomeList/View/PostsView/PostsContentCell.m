//
//  PostsContentCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PostsContentCell.h"
#import "TopicsImageCell.h"
#import "DateTool.h"
#import "SDPhotoBrowser.h"
#import "PostsDetailVC.h"
@interface PostsContentCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *iconImage;//头像
@property (nonatomic, strong) UILabel *nameLabel;//名称
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel *contentLabel;//内容

@property (nonatomic, strong) UICollectionView *collectionView;//图片
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;//布局

@property (nonatomic, strong) UIButton *commentBtn;//评论



@property (nonatomic, strong) NSMutableArray *imgs;
@end

@implementation PostsContentCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    PostsContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsContentCell"];
    if (cell == nil) {
        cell = [[PostsContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostsContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor hex:Back_Color];
    }
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
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView).offset(Width(8));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.layer.cornerRadius = Width(20);
    _iconImage.layer.borderWidth = 1;
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Width(15));
        make.top.equalTo(backView).offset(Width(15));
        make.width.height.mas_equalTo(Width(40));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"豆豆";
    _nameLabel.textColor = [UIColor hex:@"444444"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage);
        make.left.equalTo(_iconImage.mas_right).offset(Width(10));
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"1分钟前";
    _timeLabel.textColor = [UIColor hex:@"999999"];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconImage.mas_bottom);
        make.left.equalTo(_nameLabel);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.text = @"今天天气不错,晒个图大家一起开心一下.今天天气不错,晒个图大家一起开心一下.今天天气不错,晒个图大家一起开心一下.今天天气不错,晒个图大家一起开心一下.今天天气不错,晒个图大家一起开心一下.今天天气不错,晒个图大家一起开心一下.";
    _contentLabel.textColor = [UIColor hex:@"444444"];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(Width(12));
        make.left.equalTo(_iconImage.mas_right).offset(Width(10));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
    }];
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumInteritemSpacing = Width(5);
    _layout.minimumLineSpacing = Width(5);
    _layout.itemSize = CGSizeMake((kScreenWidth - Width(100))/3, (kScreenWidth - Width(100))/3);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [_collectionView registerClass:[TopicsImageCell class] forCellWithReuseIdentifier:@"TopicsImageCell"];
    _collectionView.collectionViewLayout = self.layout;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    [self.contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel);
        make.top.equalTo(_contentLabel.mas_bottom).offset(Width(12)).priority(999);
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.height.mas_equalTo((kScreenWidth - Width(100))/3 * 2 + Width(5));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.collectionView.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(Width(8));
    }];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentBtn setTitle:@"评论0" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont fontSize:12];
    [_commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -Width(20), 0, 0)];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Width(15));
        make.top.equalTo(lineView.mas_bottom).offset(Width(10));
        make.width.mas_equalTo(Width(120));
        make.height.mas_equalTo(Width(25));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Width(10));
    }];
    
//    UIView *line = [[UIView alloc]init];
//    line.backgroundColor = [UIColor hex:@"f5f5f5"];
//    [self.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.contentView);
//        make.top.equalTo(self.contentView);
//        make.height.mas_equalTo(Width(1));
//    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.model.imageList.count;
    return self.imgs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopicsImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopicsImageCell" forIndexPath:indexPath];
    
    [cell.zoneImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,self.imgs[indexPath.row]]] placeholderImage:nil];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.viewController isKindOfClass:[PostsDetailVC class]]) {
        
         PostsDetailVC *vc = self.viewController;
        
        [vc.commentView endEditing:YES];
    }
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.row;
    photoBrowser.imageCount = self.imgs.count;
    photoBrowser.sourceImagesContainerView = collectionView;
    [photoBrowser show];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    //    NSArray *imagePaths = [self.detailModel.task_img componentsSeparatedByString:@"|"];
    
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,self.imgs[index]]];
}

// 调整单元格与父视图边界的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(PostsDetailModel *)model
{
    self.imgs= (NSMutableArray *)[model.post_img componentsSeparatedByString:@"|"];
    
    [self configCollectionView];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.post_user_headimg]] placeholderImage:[UIImage imageNamed:@"Group1"]];
    _nameLabel.text=model.post_user_name;
    
    
    
    _timeLabel.text=[DateTool timeStampToString:[model.create_time intValue]];
    _contentLabel.text=model.post_content;
}

- (void)configCollectionView{
    if (self.imgs.count >= 9) {
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((kScreenWidth - Width(100))/3*3 + Width(20));
        }];
    }else{
        NSInteger excess = (self.imgs.count + 1) % 4;
        NSInteger line = (self.imgs.count + 1) / 4;
        if (excess == 0) {
            [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((kScreenWidth - Width(100))/3*(line) + Width(10) * (line - 1));
            }];
        }else{
            [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((kScreenWidth - Width(100))/3*(line+1) + Width(10) * line);
            }];
        }
    }
    [self.contentView updateConstraints];
    [self.contentView layoutIfNeeded];
    [KVNProgress dismiss];
    [self.collectionView reloadData];
}

-(void)setComments:(NSInteger)comments
{
    _comments=comments;
    [_commentBtn setTitle:[NSString stringWithFormat:@"评论%ld",comments] forState:UIControlStateNormal];
}
@end
