//
//  ZJNChoseTaskTypeView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNChoseTaskTypeView.h"
#import "ZJNChoseBgView.h"
#import "ZJNSixTypeView.h"
#import "ZJNTwoTypeView.h"
#import "ZJNThreeTypeView.h"
#import "ZJNFiveTypeView.h"

#import "YBNavigationViewController.h"
#import "PublishLifeTaskVC.h"
#import "PublicCustomTaskVC.h"
#import "PublishWorkTaskVC.h"
#import "PublishHealthTaskVC.h"
#import "PublishOtherTaskVC.h"
#import "PublishErrandTaskVC.h"

@interface ZJNChoseTaskTypeView()<ZJNSixTypeViewDelegate,ZJNTwoTypeViewDelegate,ZJNThreeTypeViewDelegate,ZJNFiveTypeViewDelegate>{
    NSInteger type;
}
@property (nonatomic ,strong)ZJNChoseBgView *bgView;
@property (nonatomic ,strong)ZJNSixTypeView *sixTypeView;
@property (nonatomic ,strong)ZJNTwoTypeView *twoTypeView;
@property (nonatomic ,strong)ZJNThreeTypeView *threeTypeView;
@property (nonatomic ,strong)ZJNFiveTypeView *fiveTypeView;
@end

@implementation ZJNChoseTaskTypeView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)]];
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.bgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-20);
            make.height.mas_equalTo(AdFloat(460));
        }];
        
        self.sixTypeView.infoArr = @[@"跑腿",@"生活",@"个人定制",@"工作",@"身心",@"其他"];
        [self.bgView.contentView addSubview:self.sixTypeView];
        [self.sixTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView.contentView);
        }];
        
        
    }
    return self;
}
-(ZJNChoseBgView *)bgView{
    if (!_bgView) {
        _bgView = [[ZJNChoseBgView alloc]init];
        
    }
    return _bgView;
}
-(ZJNSixTypeView *)sixTypeView{
    if (!_sixTypeView) {
        _sixTypeView = [[ZJNSixTypeView alloc]init];
        _sixTypeView.delegate = self;
    }
    return _sixTypeView;
}
-(ZJNTwoTypeView *)twoTypeView{
    if (!_twoTypeView) {
        _twoTypeView = [[ZJNTwoTypeView alloc]init];
        _twoTypeView.delegate = self;
    }
    return _twoTypeView;
}
-(ZJNThreeTypeView *)threeTypeView{
    if (!_threeTypeView) {
        _threeTypeView = [[ZJNThreeTypeView alloc]init];
        _threeTypeView.delegate = self;
    }
    return _threeTypeView;
}
-(ZJNFiveTypeView *)fiveTypeView{
    if (!_fiveTypeView) {
        _fiveTypeView = [[ZJNFiveTypeView alloc]init];
        _fiveTypeView.delegate = self;
    }
    return _fiveTypeView;
}
- (void)hiddenView{
    [self removeFromSuperview];
}

#pragma mark-ZJNSixTypeViewDelegate
-(void)zjnSixTypeViewButtonSelectedWithTag:(NSInteger)tag{
    if (tag == 10) {
        //跑腿:物品，人员
        type = 10;
        self.twoTypeView.infoArr = @[@"跑腿",@"接送人"];
        for (UIView *view in self.bgView.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self.bgView.contentView addSubview:self.twoTypeView];
        [self.twoTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView.contentView);
        }];
    }else if (tag == 11){
        //生活:衣，食，住，行，游
        type = 11;
        self.fiveTypeView.infoArr = @[@"衣",@"食",@"住",@"行",@"游"];
        for (UIView *view in self.bgView.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self.bgView.contentView addSubview:self.fiveTypeView];
        [self.fiveTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView.contentView);
        }];
    }else if (tag == 12){
        //个人定制:软件，硬件
        type = 12;
        self.twoTypeView.infoArr = @[@"软件",@"硬件"];
        for (UIView *view in self.bgView.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self.bgView.contentView addSubview:self.twoTypeView];
        [self.twoTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView.contentView);
        }];
    }else if (tag == 13){
        //工作:仕，农，工，商，律
        type = 13;
        self.fiveTypeView.infoArr = @[@"仕",@"农",@"工",@"商",@"律"];
        for (UIView *view in self.bgView.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self.bgView.contentView addSubview:self.fiveTypeView];
        [self.fiveTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView.contentView);
        }];
    }else if (tag == 14){
        //健康:减肥，健康，心理健康
        type = 14;
        self.threeTypeView.infoArr = @[@"减肥",@"健身",@"心理健康"];
        for (UIView *view in self.bgView.contentView.subviews) {
            [view removeFromSuperview];
        }
        [self.bgView.contentView addSubview:self.threeTypeView];
        [self.threeTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView.contentView);
        }];
    }else{
        //其他
        PublishOtherTaskVC *vc = [[PublishOtherTaskVC alloc]init];
        vc.task_type=6;
        vc.task_type_child=1;
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
        [self removeFromSuperview];
    }
}

#pragma mark-ZJNTwoTypeViewDelegate
-(void)zjnTwoTypeViewButtonSelectedWithTag:(NSInteger)tag{
    // type = 10 跑腿:物品，人员
    // type = 12 个人定制:软件，硬件
    if (type == 10) {
        PublishErrandTaskVC *vc = [[PublishErrandTaskVC alloc]init];
        vc.task_type=1;
        if (tag == 0) {
            vc.task_type_child=1;
        }else{
            [DWBToast showCenterWithText:@"接送人暂不开放"];
            return;
            //开放后解注释下方代码
//            vc.task_type_child=2;
        }
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }else{
        PublicCustomTaskVC *vc= [[PublicCustomTaskVC alloc]init];
        vc.task_type=3;
        if (tag == 0) {
            vc.task_type_child=14;
        }else{
            vc.task_type_child=13;
        }
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }
    [self removeFromSuperview];
}

#pragma mark-ZJNThreeTypeViewDelegate
-(void)zjnThreeTypeViewButtonSelectedWithTag:(NSInteger)tag{
    // type = 14 健康:减肥，健康，心理健康
    PublishHealthTaskVC *vc = [[PublishHealthTaskVC alloc]init];
    vc.task_type=5;
    if (tag == 0) {
        vc.task_type_child=15;
    }else if (tag == 1){
        vc.task_type_child=16;
    }else{
        vc.task_type_child=17;
    }
    YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
    [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    [self removeFromSuperview];
    
}

#pragma mark-ZJNFiveTypeViewDelegate
-(void)zjnFiveTypeViewButtonSelected:(NSInteger)tag{
    // type = 11 生活:衣，食，住，行，游
    // type = 13 工作:仕，农，工，商，律
    if (type == 11) {
        PublishLifeTaskVC *vc = [[PublishLifeTaskVC alloc]init];
        vc.task_type=2;
        if (tag == 10) {
            vc.task_type_child=3;
        }else if (tag == 11){
            vc.task_type_child=4;
        }else if (tag == 12){
            vc.task_type_child=5;
        }else if (tag == 13){
            vc.task_type_child=6;
        }else{
            vc.task_type_child=7;
        }
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }else{
        PublishWorkTaskVC *vc= [[PublishWorkTaskVC alloc]init];
        vc.task_type=4;
        if (tag == 10) {
            vc.task_type_child=8;
        }else if (tag == 11){
            vc.task_type_child=9;
        }else if (tag == 12){
            vc.task_type_child=10;
        }else if (tag == 13){
            vc.task_type_child=11;
        }else {
            vc.task_type_child=12;
        }
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
