//
//  ZJNChoseBgView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNChoseBgView.h"
@interface ZJNChoseBgView()
@property (nonatomic ,strong)UIView  *lineView;
@property (nonatomic ,strong)UILabel *titleLabel;

@end
@implementation ZJNChoseBgView
-(id)init{
    self = [super init];
    if (self) {
        self.layer.cornerRadius  = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(AdFloat(90));
        }];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self.lineView.mas_bottom);
        }];
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor hex:@"333333"];
        _titleLabel.text = @"发布任务";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = SetFont(AdFloat(36));
    }
    return _titleLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor hex:@"e6e6e6"];
    }
    return _lineView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
