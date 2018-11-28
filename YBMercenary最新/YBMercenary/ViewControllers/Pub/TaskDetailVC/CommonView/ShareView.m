//
//  ShareView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ShareView.h"
#import "ShareButton.h"
@interface ShareView()
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIView *bottomView;
@property (nonatomic ,strong)UIButton *bottomBtn;
@end
@implementation ShareView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.mas_equalTo(AdFloat(464)+KAddBottomBarHeight);
        }];
        [self.bgView addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.equalTo(self.bgView);
            make.height.mas_equalTo(AdFloat(98)+KAddBottomBarHeight);
        }];
        [self.bottomView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.bottomView);
            make.height.mas_equalTo(AdFloat(98));
        }];
        NSArray *titleArr = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"微博"];
        NSArray *imageArr = @[@"微信",@"朋友圈",@"qq",@"空间",@"微博"];
        ShareButton *signBtn;
        CGFloat btnWidth = (kScreenWidth-AdFloat(400))/4.0;
        for (int i = 0; i<5; i ++) {
            ShareButton *button = [[ShareButton alloc]init];
            button.imageView.image = SetImage(imageArr[i]);
            button.titleLabel.text = titleArr[i];
            button.tag = 10+i;
            [button.button addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:button];
            if (i == 0) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.bgView).offset(AdFloat(80));
                    make.top.equalTo(self.bgView).offset(AdFloat(40));
                    make.size.mas_equalTo(CGSizeMake(btnWidth, AdFloat(150)));
                }];
                signBtn = button;
            }else if (i == 4){
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.bgView).offset(AdFloat(80));
                    make.top.equalTo(signBtn.mas_bottom).offset(AdFloat(16));
                    make.size.equalTo(signBtn);
                }];
            }else{
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(signBtn.mas_right).offset(AdFloat(80));
                    make.top.equalTo(signBtn);
                    make.size.equalTo(signBtn);
                }];
                signBtn = button;
            }
        }
    }
    return self;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    }
    return _bgView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.backgroundColor = [UIColor whiteColor];
        [_bottomBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = SetFont(AdFloat(32));
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}
-(void)shareButtonClick:(UIButton *)button{
    ShareButton *sButton = (ShareButton *)button.superview;
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewShareBtnClickWithTag:)]) {
        [self.delegate shareViewShareBtnClickWithTag:sButton.tag];
    }
}
-(void)bottomBtnClick{
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
