//
//  ZJNEvaluateBtnView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNEvaluateBtnView.h"

@implementation ZJNEvaluateBtnView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:@"0386FF"];
        [self addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(49);
        }];
    }
    return self;
}
-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
        [_btn setTitle:@"去评价" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor hex:@"0386FF"];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
