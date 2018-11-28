//
//  AdsCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "AdsCell.h"
#import "SDCycleScrollView.h"
#import "ZJNAdsViewController.h"
@interface AdsCell ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *scrollView;
@end

@implementation AdsCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    AdsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdsCell"];
    if (cell == nil) {
        cell = [[AdsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AdsCell"];
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
//    self.contentView.backgroundColor = [UIColor orangeColor];
    
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"首页banner"]];
    _scrollView.delegate = self;
    _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    cycleScrollView2.titlesGroup = titles;
    _scrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.contentView addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-Width(8));
        make.height.mas_equalTo(AdFloat(336)).priority(999);
    }];
    
    
    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _scrollView.imageURLStringsGroup = @[];
//    });
}

- (void)setImages:(NSArray *)images{
    _images = images;
    self.scrollView.imageURLStringsGroup = _images;
}
- (void)setUrlArray:(NSArray *)urlArray{
    _urlArray = urlArray;
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DBLog(@"%ld",(long)index);
    ZJNAdsViewController *viewC = [[ZJNAdsViewController alloc]init];
    viewC.title = @"详情";
    viewC.urlStr = self.urlArray[index];
    viewC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:viewC animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
