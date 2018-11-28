//
//  ZJNMyIssueTJTopButtonView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMyIssueTJTopButtonView.h"
@interface ZJNMyIssueTJTopButtonView()
@property (nonatomic ,strong)UIView *sliderView;
@property (nonatomic ,strong)UIView *signBgView;
@end
@implementation ZJNMyIssueTJTopButtonView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *titleArray = @[@"一星",@"二星",@"三星",@"四星",@"五星",@"总计"];
        NSArray *countArray = @[@"0",@"0",@"0",@"0",@"0",@"0"];
        CGFloat btnWidth = kScreenWidth/6.0;
        UIView *signView;
        for (int i = 0; i <6; i ++) {
            UIView *bgView = [[UIView alloc]init];
            bgView.tag = 10+i;
            bgView.backgroundColor = [UIColor whiteColor];
            [self addSubview:bgView];
            if (i == 0) {
                [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.equalTo(self);
                    make.height.mas_equalTo(62);
                    make.width.mas_equalTo(btnWidth);
                }];
                _signBgView = bgView;
                signView = bgView;
            }else{
                [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(signView);
                    make.left.equalTo(signView.mas_right);
                    make.size.equalTo(signView);
                }];
                signView = bgView;
            }
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.font = SetFont(AdFloat(30));
            if (i == 0) {
                titleLabel.textColor = [UIColor hex:@"0386FF"];
            }else{
                titleLabel.textColor = [UIColor hex:@"666666"];
            }
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = titleArray[i];
            [bgView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(bgView);
                make.top.equalTo(bgView).offset(9);
            }];
            
            UILabel *countLabel = [[UILabel alloc]init];
            countLabel.font = SetFont(AdFloat(28));
            countLabel.tag = 100;
            if (i == 0) {
                countLabel.textColor = [UIColor hex:@"0386FF"];
            }else{
                countLabel.textColor = [UIColor hex:@"666666"];
            }
            countLabel.textAlignment = NSTextAlignmentCenter;
            countLabel.text = countArray[i];
            [bgView addSubview:countLabel];
            [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(bgView);
                make.top.equalTo(titleLabel.mas_bottom).offset(6);
            }];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 10+i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(bgView);
            }];
        }
        [self addSubview:self.sliderView];
        
    }
    return self;
}
-(UIView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 62, kScreenWidth/6.0, 2)];
        _sliderView.backgroundColor = [UIColor hex:@"0386FF"];
    }
    return _sliderView;
}
-(void)buttonClick:(UIButton *)button{
    
    NSArray *signArr = self.signBgView.subviews;
    for (id subView in signArr) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            if (label.tag == 100) {
                label.textColor = [UIColor hex:@"444444"];
            }else{
                label.textColor = [UIColor hex:@"666666"];
            }
        }
    }
    
    UIView *bgView = (UIView *)[button superview];
    NSArray *array = bgView.subviews;
    for (id subView in array) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            label.textColor = [UIColor hex:@"0386FF"];
        }
    }
    self.signBgView = bgView;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderView.frame = CGRectMake((button.tag-10)*(kScreenWidth/6.0), 62, kScreenWidth/6.0, 2);
    }];
    
    if (self.myIssueTJBlock) {
        self.myIssueTJBlock(button.tag-9);
    }
}

-(void)setTjType:(TjType)tjType{
    _tjType = tjType;
    if (self.tjType == 0) {
        [self getDataFromServiceWithUrlStr:UserCenter_MyTask_publish_sum_total];
    }else{
        [self getDataFromServiceWithUrlStr:receiveTotal];
    }
}
-(void)getDataFromServiceWithUrlStr:(NSString *)urlStr
{
    NSDictionary *parameters =@{@"token":USERTOKEN};
    [[YBRequestManager sharedYBManager]postWithUrlString:urlStr parameters:parameters success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            NSDictionary *dic = data[@"data"];
            //接受个数据好难啊
            NSString *oneStr = [[NSNumber numberWithInteger:[dic[@"one"] integerValue]] stringValue];
            NSString *twoStr = [[NSNumber numberWithInteger:[dic[@"two"] integerValue]] stringValue];
            NSString *threeStr = [[NSNumber numberWithInteger:[dic[@"three"] integerValue]] stringValue];
            NSString *fourStr = [[NSNumber numberWithInteger:[dic[@"fore"] integerValue]] stringValue];
            NSString *fiveStr = [[NSNumber numberWithInteger:[dic[@"five"] integerValue]] stringValue];
            NSString *totalStr = [[NSNumber numberWithInteger:[dic[@"total"] integerValue]] stringValue];
            NSArray *array = @[oneStr,twoStr,threeStr,fourStr,fiveStr,totalStr];
            for (int i = 0; i <6; i ++) {
                UIView *bgView = (UIView *)[self viewWithTag:10+i];
                UILabel *countLabel = (UILabel *)[bgView viewWithTag:100];
                countLabel.text = array[i];
            }
            
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
