//
//  ZJNTabBarView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTabBarView.h"
#import "UIView+Size.h"
#import "UIButton+Edge.h"
@implementation ZJNTabBarView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat w = kScreenWidth/5.0;;
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(0, 0, w, w);
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _sendBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:_sendBtn];
        
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake((w-54)/2, 2, 54, 54)];
        btnView.backgroundColor = [UIColor whiteColor];
        btnView.layer.cornerRadius = 27;
        btnView.layer.masksToBounds =YES;
        [_sendBtn addSubview:btnView];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 44, 44)];
        img.image = [UIImage imageNamed:@"发布"];
        [btnView addSubview:img];
        
        UILabel *btnLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 58, w, 12)];
        btnLab.text = @"发布";
        btnLab.textColor = [UIColor grayColor];
        btnLab.font = [UIFont systemFontOfSize:10];
        btnLab.textAlignment = NSTextAlignmentCenter;
        [_sendBtn addSubview:btnLab];
        [_sendBtn setImagePositionWithType:SSImagePositionTypeTop spacing:4];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
