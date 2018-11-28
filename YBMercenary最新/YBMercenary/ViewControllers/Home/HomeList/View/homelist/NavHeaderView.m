//
//  NavHeaderView.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "NavHeaderView.h"
#import "ChoseCityListVC.h"
#import "YBNavigationViewController.h"
#import "ZJNSearchViewController.h"
@interface NavHeaderView ()
{
    UIButton *adressBtn;
}
//@property (nonatomic, strong) UIButton *adressBtn;

@end

@implementation NavHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:Blue_Color];
        [self creatSibViews];
    }
    return self;
}

- (void)creatSibViews{
    
    UIImage *image = [UIImage imageNamed:@"下拉箭头"];
    adressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    adressBtn.titleLabel.font = [UIFont fontSize:AdFloat(32)];
    [adressBtn setImage:image forState:UIControlStateNormal];
    [adressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    adressBtn.frame = CGRectMake(Width(5), 7, AdFloat(120), 30);
    [adressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [adressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (adressBtn.bounds.size.width - image.size.width), 0, 0)];
    [adressBtn addTarget:self action:@selector(choseTeam) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:adressBtn];

    UIImageView *searchimage = [[UIImageView alloc]init];
    searchimage.image = [UIImage imageNamed:@"搜索框"];
    searchimage.frame = CGRectMake(adressBtn.maxX + Width(10), 7, kScreenWidth - (adressBtn.maxX + Width(10) + Width(21)) , 30);
    searchimage.userInteractionEnabled = YES;
    [searchimage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)]];
    [self addSubview:searchimage];
    
    UIImageView *search = [[UIImageView alloc]init];
    search.image = [UIImage imageNamed:@"搜索"];
    search.frame = CGRectMake(0, 0, Width(20) , Width(20));
    search.center = CGPointMake(searchimage.minX + Width(20), searchimage.centerY);
    [self addSubview:search];
    
    UILabel *tip = [F_UI SL_UI_Label:@"请输入要搜索的任务" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentCenter textFont:14 numberOfLines:1];
    tip.frame = CGRectMake(searchimage.minX , search.minY + Width(1), Width(200) , Width(20));
    [self addSubview:tip];
}

-(void)choseTeam{
    ChoseCityListVC *vc = [[ChoseCityListVC alloc]init];
    vc.choseCityListBlock = ^(NSString *city) {
        self.cityName = city;
        if (self.navHeaderBlock) {
            self.navHeaderBlock(city);
        }
    };
    YBNavigationViewController *nav = (YBNavigationViewController *)self.viewController;
    [nav pushViewController:vc animated:YES];
}
-(void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    [adressBtn setTitle:self.cityName forState:UIControlStateNormal];
    [adressBtn setTitle:[NSString stringWithFormat:@"%@ ",self.cityName] forState:UIControlStateNormal];
    if (self.cityName.length > 3) {
        NSString *name = [self.cityName substringToIndex:1];
        name = [name stringByAppendingString:@"..."];
        [adressBtn setTitle:name forState:UIControlStateNormal];
    }else{
        [adressBtn setTitle:[NSString stringWithFormat:@"%@ ",self.cityName] forState:UIControlStateNormal];
    }
}
-(void)searchAction{
    ZJNSearchViewController *viewC = [[ZJNSearchViewController alloc]init];
    viewC.hidesBottomBarWhenPushed = YES;
    YBNavigationViewController *nav = (YBNavigationViewController *)self.viewController;
    [nav pushViewController:viewC animated:NO];
}

@end
