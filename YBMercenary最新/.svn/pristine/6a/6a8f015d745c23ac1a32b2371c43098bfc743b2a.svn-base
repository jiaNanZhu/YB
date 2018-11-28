//
//  TaskMarkView.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskMarkView.h"

@interface TaskMarkView ()

@property (nonatomic, strong) UILabel *oneLabel;
@property (nonatomic, strong) UILabel *twoLabel;
@property (nonatomic, strong) UILabel *lastLabel;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@end

@implementation TaskMarkView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    _oneLabel = [F_UI SL_UI_Label:nil color:[UIColor hex:@"f5513c"] textAlignment:0 textFont:13 numberOfLines:1];
    [_oneLabel setBorderWidth:1 borderColor:[UIColor hex:@"f5513c"] radius:Width(3)];
    [self addSubview:_oneLabel];
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
    }];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn1 setImage:[UIImage imageNamed:@"删"] forState:UIControlStateNormal];
    _btn1.hidden = YES;
    _btn1.tag = 10000;
    [_btn1 addTarget:self action:@selector(deletemark:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn1];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oneLabel).offset(-Width(3));
        make.right.equalTo(_oneLabel.mas_right).offset(Width(3));
        make.width.height.mas_equalTo(Width(10));
    }];
    
    _twoLabel = [F_UI SL_UI_Label:nil color:[UIColor hex:@"f5513c"] textAlignment:0 textFont:13 numberOfLines:1];
    [_twoLabel setBorderWidth:1 borderColor:[UIColor hex:@"f5513c"] radius:Width(3)];
    [self addSubview:_twoLabel];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(_oneLabel.mas_right).offset(Width(10));
    }];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn2 setImage:[UIImage imageNamed:@"删"] forState:UIControlStateNormal];
    _btn2.hidden = YES;
    _btn2.tag = 10001;
    [_btn2 addTarget:self action:@selector(deletemark:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoLabel).offset(-Width(3));
        make.right.equalTo(_twoLabel.mas_right).offset(Width(3));
        make.width.height.mas_equalTo(Width(10));
    }];
    
    _lastLabel = [F_UI SL_UI_Label:nil color:[UIColor hex:@"f5513c"] textAlignment:0 textFont:13 numberOfLines:1];
    [_lastLabel setBorderWidth:1 borderColor:[UIColor hex:@"f5513c"] radius:Width(3)];
    [self addSubview:_lastLabel];
    [_lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(_twoLabel.mas_right).offset(Width(12));
    }];
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn3 setImage:[UIImage imageNamed:@"删"] forState:UIControlStateNormal];
    _btn3.hidden = YES;
    _btn3.tag = 10002;
    [_btn3 addTarget:self action:@selector(deletemark:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn3];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastLabel).offset(-Width(3));
        make.right.equalTo(_lastLabel.mas_right).offset(Width(3));
        make.width.height.mas_equalTo(Width(10));
    }];
}

- (void)setMarkArr:(NSArray *)markArr{
    _markArr = markArr;
    if (_markArr.count== 1) {
        _oneLabel.text = [NSString stringWithFormat:@"  %@  ",_markArr[0]];
        _twoLabel.text = nil;
        _lastLabel.text = nil;
        self.btn2.hidden = YES;
        self.btn3.hidden = YES;
    }else if (_markArr.count == 2){
        _oneLabel.text = [NSString stringWithFormat:@"  %@  ",_markArr[0]];
        _twoLabel.text = [NSString stringWithFormat:@"  %@  ",_markArr[1]];
        _lastLabel.text = nil;
        self.btn3.hidden = YES;
    }else if(_markArr.count >= 3){
        _oneLabel.text = [NSString stringWithFormat:@"  %@  ",_markArr[0]];
        _twoLabel.text = [NSString stringWithFormat:@"  %@  ",_markArr[1]];
        _lastLabel.text = [NSString stringWithFormat:@"  %@  ",_markArr[2]];
    }
}

- (void)startDelete{
    if (self.markArr.count == 1) {
        self.btn1.hidden = NO;
        self.btn2.hidden = YES;
        self.btn3.hidden = YES;
    }else if (self.markArr.count == 2){
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
        self.btn3.hidden = YES;
    }else if(self.markArr.count >= 3){
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
        self.btn3.hidden = NO;
    }
}

- (void)stopDelete{
    self.btn1.hidden = YES;
    self.btn2.hidden = YES;
    self.btn3.hidden = YES;
}

- (void)deletemark:(UIButton *)sender{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.markArr];
    NSString *mark = arr[sender.tag-10000];
    if (self.deleteMarkBlock) {
        self.deleteMarkBlock(mark);
    }
    [arr removeObjectAtIndex:sender.tag - 10000];
    self.markArr = arr;
}

@end
