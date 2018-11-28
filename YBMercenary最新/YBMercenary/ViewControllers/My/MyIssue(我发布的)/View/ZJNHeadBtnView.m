//
//  ZJNHeadBtnView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNHeadBtnView.h"
@interface ZJNHeadBtnView()

@end
@implementation ZJNHeadBtnView
-(id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titleArr;
        self.backgroundColor = [UIColor whiteColor];
        CGFloat btnW = kScreenWidth/self.titleArray.count;
        UIButton *signBtn;
//        NSArray *titleArr = @[@"全部",@"未决定",@"任务中",@"审核中",@"待评价",@"已下架"];
        for (int i = 0; i <self.titleArray.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateSelected];
            [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = SetFont(AdFloat(30));
            button.tag = 10+i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if (i == 0) {
                button.selected = YES;
                self.selectBtn = button;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(btnW, 42));
                }];
                signBtn = button;
            }else{
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(signBtn);
                    make.left.equalTo(signBtn.mas_right);
                    make.size.equalTo(signBtn);
                }];
                signBtn = button;
            }
        }
        [self addSubview:self.sliderView];

    }
    return self;
}

-(UIView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth/self.titleArray.count, 2)];
        _sliderView.backgroundColor = [UIColor hex:@"0386FF"];
    }
    return _sliderView;
}

-(void)buttonClick:(UIButton *)button{
    if (button.selected) {
        return;
    }
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderView.frame = CGRectMake((button.tag - 10)*(kScreenWidth/self.titleArray.count), 42, kScreenWidth/self.titleArray.count, 2);
    }];
    if (self.headBtnViewBlock) {
        self.headBtnViewBlock(button.tag-10);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
