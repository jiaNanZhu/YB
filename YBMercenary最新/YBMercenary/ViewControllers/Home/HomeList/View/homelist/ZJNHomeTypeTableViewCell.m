//
//  ZJNHomeTypeTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNHomeTypeTableViewCell.h"
#import "ZJNHomeTypeView.h"
#import "TaskListVC.h"
@interface ZJNHomeTypeTableViewCell()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UIPageControl *pageControl;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIButton *signBtn;

@end
@implementation ZJNHomeTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(ZJNHomeTypeTableViewCell *)creatTableViewCellForTableView:(UITableView *)tableView{
    ZJNHomeTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJNHomeTypeTableViewCell"];
    if (cell == nil) {
        cell = [[ZJNHomeTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZJNHomeTypeTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(AdFloat(180));
        }];
        CGFloat imageH = (kScreenWidth-AdFloat(308))/5.0;
        NSArray *firstArr = @[@"跑腿",@"生活",@"个人定制",@"工作",@"身心",@"其他"];
        ZJNHomeTypeView *signView;
        for (int i = 0; i <6; i ++) {
            ZJNHomeTypeView *typeView = [[ZJNHomeTypeView alloc]init];
            typeView.imageV.image = SetImage(firstArr[i]);
            typeView.titleLabel.text = firstArr[i];
            typeView.tag = 10+i;
            [typeView.button addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:typeView];
            if (i == 0) {
                [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.equalTo(self.scrollView).offset(AdFloat(40));
                    make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
                }];
                signView  = typeView;
            }else if (i == 5){
                [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(signView);
                    make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
                    make.left.equalTo(signView.mas_right).offset(AdFloat(80));
                }];
            }else{
                [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(signView);
                    make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
                    make.left.equalTo(signView.mas_right).offset(AdFloat(57));
                }];
                signView = typeView;
            }
        }
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.scrollView.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        ZJNHomeTypeView *secondSignView;
        for (int i =0 ; i <5; i ++) {
            ZJNHomeTypeView *typeView = [[ZJNHomeTypeView alloc]init];
            typeView.tag = 20+i;
            typeView.hidden = YES;
            [typeView.button addTarget:self action:@selector(secondTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:typeView];
            if (i == 0) {
                [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.equalTo(self.bgView).offset(AdFloat(40));
                    make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
                }];
                secondSignView  = typeView;
            }else{
                [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(secondSignView);
                    make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
                    make.left.equalTo(secondSignView.mas_right).offset(AdFloat(57));
                }];
                secondSignView = typeView;
            }
        }
        [self addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(AdFloat(60));
        }];
    }
    return self;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(2*kScreenWidth, 0);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = 2;//指定页面个数
        _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = [UIColor whiteColor];
        //添加委托方法，当点击小白点就执行此方法
        _pageControl.pageIndicatorTintColor = [UIColor hex:Back_Color];// 设置非选中页的圆点颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor hex:Blue_Color]; // 设置选中页的圆点颜色
    }
    return _pageControl;
}
-(void)typeButtonClick:(UIButton *)button{
    
    ZJNHomeTypeView *typeView = (ZJNHomeTypeView *)[button superview];
    for (int i = 0; i <5; i ++) {
        ZJNHomeTypeView *typeView = (ZJNHomeTypeView *)[self.bgView viewWithTag:20+i];
        typeView.imageV.image = nil;
        typeView.titleLabel.text = nil;
        typeView.hidden = YES;
    }
    if (typeView.tag == 15) {
        TaskListVC *vc = [[TaskListVC alloc]init];
        vc.type = 6;
        vc.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else{
        if (button.selected) {
            [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.scrollView.mas_bottom);
                make.height.mas_equalTo(AdFloat(0));
            }];
            button.selected = NO;
        }else{
            
            [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.scrollView.mas_bottom);
                make.height.mas_equalTo(AdFloat(180));
            }];
            self.signBtn.selected = NO;
            button.selected = YES;
            self.signBtn = button;
        }
        if (typeView.tag == 10) {
            //跑腿:物品 人员
            NSArray *titleArr = @[@"跑腿",@"接送人"];
            for (int i = 0; i <2; i ++) {
                ZJNHomeTypeView *typeV = (ZJNHomeTypeView *)[self.bgView viewWithTag:20+i];
                typeV.imageV.image = [UIImage imageNamed:titleArr[i]];
                typeV.titleLabel.text = titleArr[i];
                typeV.hidden = NO;
            }
        }else if (typeView.tag == 11){
            //生活:衣 食 住 行 游
            NSArray *titleArr = @[@"衣",@"食",@"住",@"行",@"游"];
            for (int i = 0; i <5; i ++) {
                ZJNHomeTypeView *typeV = (ZJNHomeTypeView *)[self.bgView viewWithTag:20+i];
                typeV.imageV.image = [UIImage imageNamed:titleArr[i]];
                typeV.titleLabel.text = titleArr[i];
                typeV.hidden = NO;
            }
        }else if (typeView.tag == 12){
            //个人定制:硬件 软件
            NSArray *titleArr = @[@"硬件",@"软件"];
            for (int i = 0; i <2; i ++) {
                ZJNHomeTypeView *typeV = (ZJNHomeTypeView *)[self.bgView viewWithTag:20+i];
                typeV.imageV.image = [UIImage imageNamed:titleArr[i]];
                typeV.titleLabel.text = titleArr[i];
                typeV.hidden = NO;
            }
        }else if (typeView.tag == 13){
            //工作:仕 农 工 商 律
            NSArray *titleArr = @[@"仕",@"农",@"工",@"商",@"律"];
            for (int i = 0; i <5; i ++) {
                ZJNHomeTypeView *typeV = (ZJNHomeTypeView *)[self.bgView viewWithTag:20+i];
                typeV.imageV.image = [UIImage imageNamed:titleArr[i]];
                typeV.titleLabel.text = titleArr[i];
                typeV.hidden = NO;
            }
        }else if (typeView.tag == 14){
            //身心:减肥 健身 心理
            NSArray *titleArr = @[@"减肥",@"健身",@"心理健康"];
            for (int i = 0; i <3; i ++) {
                ZJNHomeTypeView *typeV = (ZJNHomeTypeView *)[self.bgView viewWithTag:20+i];
                typeV.imageV.image = [UIImage imageNamed:titleArr[i]];
                typeV.titleLabel.text = titleArr[i];
                typeV.hidden = NO;
            }
        }
        if (self.refreshListBlock) {
            self.refreshListBlock();
        }
    }
}
-(void)secondTypeButtonClick:(UIButton *)button{
    ZJNHomeTypeView *typeV = (ZJNHomeTypeView *)[button superview];
    ZJNHomeTypeView *signTypeV = (ZJNHomeTypeView *)[self.signBtn superview];
    NSInteger childType;
    if (signTypeV.tag == 10) {
        if (typeV.tag == 20) {
            childType = 1;
        }else{
            [DWBToast showCenterWithText:@"接送人暂不开放"];
            return;
            //开放接送人后直接解注释下方代码
//            childType = 2;
        }
    }else if (signTypeV.tag == 11){
        if (typeV.tag == 20) {
            childType = 3;
        }else if (typeV.tag == 21){
            childType = 4;
        }else if (typeV.tag == 22){
            childType = 5;
        }else if (typeV.tag == 23){
            childType = 6;
        }else{
            childType = 7;
        }
    }else if (signTypeV.tag == 12){
        if (typeV.tag == 20) {
            childType = 13;
        }else{
            childType = 14;
        }
    }else if (signTypeV.tag == 13){
        if (typeV.tag == 20) {
            childType = 8;
        }else if (typeV.tag == 21){
            childType = 9;
        }else if (typeV.tag == 22){
            childType = 10;
        }else if (typeV.tag == 23){
            childType = 11;
        }else{
            childType = 12;
        }
    }else {
        if (typeV.tag == 20) {
            childType = 15;
        }else if (typeV.tag == 21){
            childType = 16;
        }else {
            childType = 17;
        }
    }
    
    TaskListVC *vc = [[TaskListVC alloc]init];
    vc.type = signTypeV.tag-9;
    vc.childType = childType;
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger x = scrollView.contentOffset.x/kScreenWidth;
    _pageControl.currentPage = x;
    self.signBtn.selected = NO;
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.scrollView.mas_bottom);
        make.height.mas_equalTo(AdFloat(0));
    }];
    if (self.refreshListBlock) {
        self.refreshListBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
