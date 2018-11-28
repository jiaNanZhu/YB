//
//  ZJNMessageHeaderView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNMessageHeaderView.h"
@interface ZJNMessageHeaderView()
@property (nonatomic ,strong)UIButton *signBtn;
@property (nonatomic ,strong)UIImageView *sliderImageV;
@end
@implementation ZJNMessageHeaderView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *arr = @[@"任务",@"私聊",@"酒馆",@"系统消息"];
        CGFloat btnWidth = d_Device_width/4.0;
        for (int i = 0; i < arr.count; i++) {
            UIButton *btn = [F_UI SL_UI_Btn:arr[i] Color:[UIColor hex:@"666666"] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(btn:) cornerRadius:0];
            [btn setTitleColor:[UIColor hex:@"0386FF"] forState:UIControlStateSelected];
            btn.tag = i+400;
            if (i == 0) {
                btn.selected = YES;
                self.signBtn = btn;
            }
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(i *btnWidth);
                make.top.equalTo(self);
                make.width.mas_equalTo(btnWidth);
                make.height.mas_equalTo(AdFloat(100));
            }];
        }
        
        UIButton *taskBtn = (UIButton *)[self viewWithTag:400];
        [self addSubview:self.sliderImageV];
        [self.sliderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(taskBtn).priorityMedium();
            make.top.equalTo(taskBtn.mas_bottom);
            make.width.mas_equalTo(btnWidth-AdFloat(60));
            make.height.mas_equalTo(AdFloat(5));
        }];
    }
    return self;
}
-(UIImageView *)sliderImageV{
    if (!_sliderImageV) {
        _sliderImageV = [[UIImageView alloc]initWithImage:SetImage(@"xianIMG")];        
    }
    return _sliderImageV;
}
-(void)btn:(UIButton *)btn{
    if (btn.selected == YES) {
        return;
    }
    
    self.signBtn.selected = NO;
    btn.selected = YES;
    self.signBtn = btn;
    
    [self.sliderImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn).priorityMedium();
        make.top.equalTo(btn.mas_bottom);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnMessageHeaderViewBtnClickWithTag:)]) {
        [self.delegate zjnMessageHeaderViewBtnClickWithTag:btn.tag-400];
    }
}
-(void)setTask:(int)task{
    
}
-(void)setChat:(int)chat{
    
}
-(void)setTavern:(int)tavern{
    
}
-(void)setSystem:(int)system{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
