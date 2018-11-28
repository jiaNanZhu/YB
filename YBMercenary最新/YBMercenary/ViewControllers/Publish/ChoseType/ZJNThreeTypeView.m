//
//  ZJNThreeTypeView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNThreeTypeView.h"
#import "ZJNHomeTypeView.h"
@interface ZJNThreeTypeView()
@property (nonatomic ,strong)ZJNHomeTypeView *leftTypeView;
@property (nonatomic ,strong)ZJNHomeTypeView *midTypeView;
@property (nonatomic ,strong)ZJNHomeTypeView *rightTypeView;
@end
@implementation ZJNThreeTypeView
-(id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat imageH = (kScreenWidth-AdFloat(328+60))/4.0;
        [self addSubview:self.midTypeView];
        [self addSubview:self.leftTypeView];
        [self addSubview:self.rightTypeView];
        
        [self.midTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(AdFloat(80));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
        }];
        
        [self.leftTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(AdFloat(80));
            make.right.equalTo(self.midTypeView.mas_left).offset(-AdFloat(100));
            make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
        }];
        
        [self.rightTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(AdFloat(80));
            make.left.equalTo(self.midTypeView.mas_right).offset(AdFloat(100));
            make.size.mas_equalTo(CGSizeMake(imageH, imageH+AdFloat(52)));
        }];
    }
    return self;
}
-(ZJNHomeTypeView *)leftTypeView{
    if (!_leftTypeView) {
        _leftTypeView = [[ZJNHomeTypeView alloc]init];
        [_leftTypeView.button addTarget:self action:@selector(leftTypeViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftTypeView;
}
-(ZJNHomeTypeView *)midTypeView{
    if (!_midTypeView) {
        _midTypeView = [[ZJNHomeTypeView alloc]init];
        [_midTypeView.button addTarget:self action:@selector(midTypeViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _midTypeView;
}
-(ZJNHomeTypeView *)rightTypeView{
    if (!_rightTypeView) {
        _rightTypeView = [[ZJNHomeTypeView alloc]init];
        [_rightTypeView.button addTarget:self action:@selector(rightTypeViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightTypeView;
}

-(void)setInfoArr:(NSArray *)infoArr{
    NSString *leftStr = infoArr[0];
    NSString *midStr  = infoArr[1];
    NSString *rightStr = infoArr[2];
    self.leftTypeView.imageV.image = SetImage(leftStr);
    self.leftTypeView.titleLabel.text = leftStr;
    self.midTypeView.imageV.image = SetImage(midStr);
    self.midTypeView.titleLabel.text = midStr;
    self.rightTypeView.imageV.image = SetImage(rightStr);
    self.rightTypeView.titleLabel.text = rightStr;
}

-(void)leftTypeViewButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnThreeTypeViewButtonSelectedWithTag:)]) {
        [self.delegate zjnThreeTypeViewButtonSelectedWithTag:0];
    }
}

-(void)midTypeViewButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnThreeTypeViewButtonSelectedWithTag:)]) {
        [self.delegate zjnThreeTypeViewButtonSelectedWithTag:1];
    }
}

-(void)rightTypeViewButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnThreeTypeViewButtonSelectedWithTag:)]) {
        [self.delegate zjnThreeTypeViewButtonSelectedWithTag:2];
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
