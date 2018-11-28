//
//  ZJNSliderView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/9.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNSliderView.h"
@interface ZJNSliderView()
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *sliderLabel;
@end
@implementation ZJNSliderView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(AdFloat(58));
            
        }];
        
        [self addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right).offset(AdFloat(40));
            make.height.mas_equalTo(AdFloat(60));
            make.width.mas_equalTo(AdFloat(240));
            make.centerY.equalTo(self.titleLab);
        }];
        
        [self addSubview:self.sliderLabel];
        [self.sliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.slider);
            make.top.equalTo(self.slider.mas_bottom);
            make.height.mas_equalTo(AdFloat(40));
        }];
    }
    return self;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor hex:@"444444"];
        _titleLab.font = SetFont(AdFloat(28));
        _titleLab.text = @"总金额";
    }
    return _titleLab;
}
-(UILabel *)sliderLabel{
    if (!_sliderLabel) {
        _sliderLabel = [[UILabel alloc]init];
        _sliderLabel.textColor = [UIColor colorWithRed:82/255.0 green:153/255.0 blue:245/255.0 alpha:1];
        _sliderLabel.font = SetFont(AdFloat(26));
    }
    return _sliderLabel;
}
-(UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        _slider.continuous = YES;
        [_slider setThumbImage:SetImage(@"一选中") forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}
-(void)sliderValueChanged:(UISlider *)slider{
    UIImageView *imageV = (UIImageView *)[slider.subviews lastObject];
    NSLog(@"%f",imageV.frame.origin.x);
    self.sliderLabel.text = [NSString stringWithFormat:@"%.2f",slider.value];
    [self.sliderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageV);
        make.top.equalTo(self.slider.mas_bottom);
        make.height.mas_equalTo(AdFloat(40));
    }];
    
    if (self.sliderViewBlock) {
        self.sliderViewBlock(slider.value);
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
