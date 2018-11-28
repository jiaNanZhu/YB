//
//  ChoseTaskTypeView.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ChoseTaskTypeView.h"
#import "YBNavigationViewController.h"

#import "PublishLifeTaskVC.h"
#import "PublicCustomTaskVC.h"
#import "PublishWorkTaskVC.h"
#import "PublishHealthTaskVC.h"
#import "PublishOtherTaskVC.h"
#import "PublishErrandTaskVC.h"

@interface ChoseTaskTypeView ()
@property (nonatomic, strong) UIView *mainTypeView;
@property (nonatomic, strong) UIView *twoView;
@property (nonatomic, strong) UIView *threeView;
@property (nonatomic, strong) UIView *fiveView;
@property (nonatomic, assign) NSInteger type;
@end

@implementation ChoseTaskTypeView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self creatSubViews];
    }
    return self;
}
-(void)getDataFromService{
    
}
- (void)creatSubViews{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)]];
    [self creatMainTypeView];
    [self creatPaotuiDingzhiView];
    [self creatThreeView];
    [self creatFiveView];
}

- (void)creatMainTypeView{
    _mainTypeView = [[UIView alloc]init];
    _mainTypeView.backgroundColor = [UIColor clearColor];
    [self addSubview:_mainTypeView];
    [_mainTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-Width(50));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(Width(180));
    }];
    UIButton *shenghuo = [F_UI creatBtnWithTager:self title:@"生活" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(mainAction:)];
    shenghuo.tag = 102;
    [_mainTypeView addSubview:shenghuo];
    [shenghuo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(_mainTypeView);
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *paotui = [F_UI creatBtnWithTager:self title:@"跑腿" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(mainAction:)];
    paotui.tag = 101;
    [_mainTypeView addSubview:paotui];
    [paotui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shenghuo);
        make.right.equalTo(shenghuo.mas_left).offset(-Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *dingzhi = [F_UI creatBtnWithTager:self title:@"个人定制" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(mainAction:)];
    dingzhi.tag = 104;
    [_mainTypeView addSubview:dingzhi];
    [dingzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shenghuo);
        make.left.equalTo(shenghuo.mas_right).offset(Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *jiankang = [F_UI creatBtnWithTager:self title:@"健康" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(mainAction:)];
    jiankang.tag = 105;
    [_mainTypeView addSubview:jiankang];
    [jiankang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(_mainTypeView);
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *work = [F_UI creatBtnWithTager:self title:@"工作" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(mainAction:)];
    work.tag = 103;
    [_mainTypeView addSubview:work];
    [work mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jiankang);
        make.right.equalTo(jiankang.mas_left).offset(-Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *other = [F_UI creatBtnWithTager:self title:@"其他" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(mainAction:)];
    other.tag = 106;
    [_mainTypeView addSubview:other];
    [other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(jiankang);
        make.left.equalTo(jiankang.mas_right).offset(Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
}

- (void)creatPaotuiDingzhiView{
    _twoView = [[UIView alloc]init];
    _twoView.hidden = YES;
    [self addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-Width(90));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(Width(74));
    }];
    
    UIButton *firstBtn = [F_UI creatBtnWithTager:self title:@"硬件" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(twoAction:)];
    firstBtn.tag = 201;
    [_twoView addSubview:firstBtn];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_twoView.mas_centerX).offset(-Width(24));
        make.centerY.equalTo(_twoView);
        make.width.height.mas_equalTo(Width(74));
    }];
    
    UIButton *lastBtn = [F_UI creatBtnWithTager:self title:@"软件" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(twoAction:)];
    lastBtn.tag = 202;
    [_twoView addSubview:lastBtn];
    [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_twoView.mas_centerX).offset(Width(24));
        make.centerY.equalTo(_twoView);
        make.width.height.mas_equalTo(Width(74));
    }];
}

- (void)creatThreeView{
    _threeView = [[UIView alloc]init];
    _threeView.hidden = YES;
    [self addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-Width(90));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(Width(74));
    }];
    
    UIButton *middleBtn = [F_UI creatBtnWithTager:self title:@"健身" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(threeAction:)];
    middleBtn.tag = 302;
    [_threeView addSubview:middleBtn];
    [middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_threeView);
        make.centerY.equalTo(_threeView);
        make.width.height.mas_equalTo(Width(74));
    }];
    
    UIButton *firstBtn = [F_UI creatBtnWithTager:self title:@"减肥" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(threeAction:)];
    firstBtn.tag = 301;
    [_threeView addSubview:firstBtn];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(middleBtn.mas_left).offset(-Width(47));
        make.centerY.equalTo(middleBtn);
        make.width.height.mas_equalTo(Width(74));
    }];
    
    UIButton *lastBtn = [F_UI creatBtnWithTager:self title:@"心理" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(threeAction:)];
    lastBtn.tag = 303;
    [_threeView addSubview:lastBtn];
    [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleBtn.mas_right).offset(Width(47));
        make.centerY.equalTo(_threeView);
        make.width.height.mas_equalTo(Width(74));
    }];
}

- (void)creatFiveView{
    _fiveView = [[UIView alloc]init];
    _fiveView.hidden = YES;
    [self addSubview:_fiveView];
    [_fiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-Width(50));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(Width(180));
    }];
    
    UIButton *two = [F_UI creatBtnWithTager:self title:@"生活" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(fiveAction:)];
    two.tag = 502;
    [_fiveView addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(_fiveView);
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *one = [F_UI creatBtnWithTager:self title:@"跑腿" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(fiveAction:)];
    one.tag = 501;
    [_fiveView addSubview:one];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(two);
        make.right.equalTo(two.mas_left).offset(-Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *three = [F_UI creatBtnWithTager:self title:@"工作" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(fiveAction:)];
    three.tag = 503;
    [_fiveView addSubview:three];
    [three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(two);
        make.left.equalTo(two.mas_right).offset(Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *five = [F_UI creatBtnWithTager:self title:@"健康" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(fiveAction:)];
    five.tag = 505;
    [_fiveView addSubview:five];
    [five mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(_fiveView);
        make.width.height.mas_equalTo(Width(74));
    }];
    UIButton *four = [F_UI creatBtnWithTager:self title:@"个人定制" font:15 image:nil backImage:nil color:[UIColor hex:Blue_Color] textColor:[UIColor whiteColor] cornerRadius:Width(37) action:@selector(fiveAction:)];
    four.tag = 504;
    [_fiveView addSubview:four];
    [four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(five);
        make.right.equalTo(five.mas_left).offset(-Width(50));
        make.width.height.mas_equalTo(Width(74));
    }];
}

#pragma mark 主菜单按钮点击事件
- (void)mainAction:(UIButton *)sender{
    _mainTypeView.hidden = YES;
    switch (sender.tag) {
        case 101:{
            _twoView.hidden = NO;
            self.type = 1;
            UIButton *btn1 = (UIButton *)[_twoView viewWithTag:201];
            [btn1 setTitle:@"物品" forState:UIControlStateNormal];
            UIButton *btn2 = (UIButton *)[_twoView viewWithTag:202];
            [btn2 setTitle:@"人员" forState:UIControlStateNormal];
        }
            break;
        case 102:{
            self.type = 2;
            _fiveView.hidden = NO;
        }
            break;
        case 103:{
            self.type = 3;
            _fiveView.hidden = NO;
        }
            break;
        case 104:{
            _twoView.hidden = NO;
            self.type = 4;
            UIButton *btn1 = (UIButton *)[_twoView viewWithTag:201];
            [btn1 setTitle:@"硬件" forState:UIControlStateNormal];
            UIButton *btn2 = (UIButton *)[_twoView viewWithTag:202];
            [btn2 setTitle:@"软件" forState:UIControlStateNormal];
        }
            break;
        case 105:
            _threeView.hidden = NO;
            self.type = 5;
            break;
        case 106:{
            [self removeFromSuperview];
            PublishOtherTaskVC *vc = [[PublishOtherTaskVC alloc]init];
            vc.task_type=6;
            vc.task_type_child=1;
            YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
            
            [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    if (self.type == 2 || self.type == 3) {
        UIButton *btn1 = (UIButton *)[_fiveView viewWithTag:501];
        UIButton *btn2 = (UIButton *)[_fiveView viewWithTag:502];
        UIButton *btn3 = (UIButton *)[_fiveView viewWithTag:503];
        UIButton *btn4 = (UIButton *)[_fiveView viewWithTag:504];
        UIButton *btn5 = (UIButton *)[_fiveView viewWithTag:505];
        if (self.type == 2) {
            [btn1 setTitle:@"衣" forState:UIControlStateNormal];
            [btn2 setTitle:@"食" forState:UIControlStateNormal];
            [btn3 setTitle:@"住" forState:UIControlStateNormal];
            [btn4 setTitle:@"行" forState:UIControlStateNormal];
            [btn5 setTitle:@"游" forState:UIControlStateNormal];
        }else{
            [btn1 setTitle:@"仕" forState:UIControlStateNormal];
            [btn2 setTitle:@"农" forState:UIControlStateNormal];
            [btn3 setTitle:@"工" forState:UIControlStateNormal];
            [btn4 setTitle:@"商" forState:UIControlStateNormal];
            [btn5 setTitle:@"律" forState:UIControlStateNormal];
        }
    }
}

- (void)twoAction:(UIButton *)sender{
    if (self.type == 4) {
        #pragma mark  个人定制
        PublicCustomTaskVC *vc= [[PublicCustomTaskVC alloc]init];
        vc.task_type=3;
        if (sender.tag == 201) {
            vc.task_type_child=13;
        }else{
            vc.task_type_child=14;
        }
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }else{
        #pragma mark  跑腿
        PublishErrandTaskVC *vc = [[PublishErrandTaskVC alloc]init];
         vc.task_type=1;
        if (sender.tag == 201) {
            vc.task_type_child=1;
        }else{
            vc.task_type_child=2;
        }
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }
    [self removeFromSuperview];
}

- (void)threeAction:(UIButton *)sender{
    
    PublishHealthTaskVC *vc = [[PublishHealthTaskVC alloc]init];
    vc.task_type=5;
    if (sender.tag == 301) {
//        [DWBToast showCenterWithText:@"健身"];
        vc.task_type_child=15;
    }else if (sender.tag == 302){
//        [DWBToast showCenterWithText:@"减肥"];
        vc.task_type_child=16;
    }else{
//        [DWBToast showCenterWithText:@"心理"];
        vc.task_type_child=17;
    }
    
    YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
    [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    [self removeFromSuperview];
}

- (void)fiveAction:(UIButton *)sender{
    
    if (self.type == 2) {
        #pragma mark  生活
        
        PublishLifeTaskVC *vc = [[PublishLifeTaskVC alloc]init];
    
        vc.task_type=2;
        if (sender.tag == 501) {
//            [DWBToast showCenterWithText:@"衣"];
            vc.task_type_child=3;
        }else if (sender.tag == 502){
//            [DWBToast showCenterWithText:@"食"];
            vc.task_type_child=4;
        }else if (sender.tag == 503){
//            [DWBToast showCenterWithText:@"住"];
            vc.task_type_child=5;
        }else if (sender.tag == 504){
//            [DWBToast showCenterWithText:@"行"];
            vc.task_type_child=6;
        }else if (sender.tag == 505){
//            [DWBToast showCenterWithText:@"游"];
            vc.task_type_child=7;
        }
       
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }else{
        #pragma mark 工作
        
        PublishWorkTaskVC *vc= [[PublishWorkTaskVC alloc]init];
        vc.task_type=4;
        if (sender.tag == 501) {
//            [DWBToast showCenterWithText:@"士"];
            vc.task_type_child=8;
        }else if (sender.tag == 502){
//            [DWBToast showCenterWithText:@"农"];
            vc.task_type_child=9;
        }else if (sender.tag == 503){
//            [DWBToast showCenterWithText:@"工"];
            vc.task_type_child=10;
        }else if (sender.tag == 504){
//            [DWBToast showCenterWithText:@"商"];
            vc.task_type_child=11;
        }else if (sender.tag == 505){
//            [DWBToast showCenterWithText:@"律"];
            vc.task_type_child=12;
        }
        
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:vc];
        [self.getCurrentVC presentViewController:nav animated:YES completion:nil];
    }
    [self removeFromSuperview];
}

- (void)show{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

- (void)hiddenView{
    [self removeFromSuperview];
}

@end
