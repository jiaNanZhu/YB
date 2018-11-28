//
//  PublishErrandSearchNavigationView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/21.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishErrandSearchNavigationView.h"
@interface PublishErrandSearchNavigationView()<UITextFieldDelegate>
@property (nonatomic ,copy)NSString *searchText;
@property (nonatomic ,strong)UIButton *backButton;
@property (nonatomic ,strong)UIButton *searchButton;
@property (nonatomic ,strong)UITextField *textField;
@end
@implementation PublishErrandSearchNavigationView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:@"0386FF"];
        [self addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self);
            make.width.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.searchButton];
        [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self.backButton);
            make.height.equalTo(self.backButton);
            make.width.mas_equalTo(60);
        }];
        
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.backButton);
            make.width.mas_equalTo(AdFloat(544));
            make.height.mas_equalTo(30);
        
        }];
    }
    return self;
}
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:SetImage(@"back") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.titleLabel.font = SetFont(AdFloat(32));
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入要搜索的地址";
        _textField.textColor = [UIColor hex:@"999999"];
        _textField.font = SetFont(AdFloat(28));
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
        imageView.center = bgView.center;
        imageView.image = SetImage(@"搜索");
        [bgView addSubview:imageView];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = bgView;
        _textField.layer.cornerRadius = 15;
        _textField.layer.masksToBounds = YES;
        _textField.returnKeyType = UIReturnKeyDone;
        [_textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
#pragma mark-UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//返回
-(void)backButtonClick{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
//搜索
-(void)searchButtonClick{
    [self.textField resignFirstResponder];
    if (self.searchTextBlock) {
        self.searchTextBlock(self.searchText);
    }
}
//搜索框
-(void)textFieldValueChanged:(UITextField *)textField{
    self.searchText = textField.text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
