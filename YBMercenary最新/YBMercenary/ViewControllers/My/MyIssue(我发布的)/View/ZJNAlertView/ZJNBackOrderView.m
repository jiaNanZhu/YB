//
//  ZJNBackOrderView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/8.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNBackOrderView.h"
@interface ZJNBackOrderView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UITextView *textView;
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UIButton *okBtn;
@property (nonatomic ,strong)UIButton *cancelBtn;

@end
@implementation ZJNBackOrderView
-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AdFloat(530), AdFloat(440)));
    }];
    
    [self.bgView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(AdFloat(40));
        make.left.equalTo(self.bgView).offset(AdFloat(30));
        make.right.equalTo(self.bgView).offset(-AdFloat(30));
        make.height.mas_equalTo(AdFloat(180));
    }];
    
    [self.bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(AdFloat(20));
        make.left.equalTo(self.bgView).offset(AdFloat(30));
        make.right.equalTo(self.bgView).offset(-AdFloat(30));
        make.height.mas_equalTo(AdFloat(60));
    }];
    
    UIView *coverV = [[UIView alloc]init];
//    coverV.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:coverV];
    [coverV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.textField);
        make.right.equalTo(self.textField).offset(-AdFloat(AdFloat(120)));
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.bgView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-AdFloat(100));
        make.height.mas_equalTo(1);
    }];
    UIView *hLineV = [[UIView alloc]init];
    hLineV.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.bgView addSubview:hLineV];
    [hLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
        make.top.equalTo(lineV.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
    [self.bgView addSubview:self.okBtn];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom);
        make.left.equalTo(self.bgView);
        make.right.equalTo(hLineV.mas_left);
        make.bottom.equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom);
        make.left.equalTo(hLineV.mas_right);
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.borderColor = [UIColor hex:@"ededed"].CGColor;
        _tableView.layer.borderWidth = 1;
    }
    return _tableView;
}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = SetFont(AdFloat(26));
        _textView.textColor = [UIColor hex:@"666666"];
        _textView.backgroundColor = [UIColor hex:@"f5f5f5"];
        //创建一个label
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.font = SetFont(13);
        placeholderLabel.textColor = [UIColor hex:@"999999"];
        placeholderLabel.text = @"请输入延期原因";
        [_textView addSubview:placeholderLabel];
        //最关键的一句
        [_textView setValue:placeholderLabel forKey:@"_placeholderLabel"];
    }
    return _textView;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"请选择延期天数";
        _textField.font = SetFont(AdFloat(26));
        _textField.textColor = [UIColor hex:@"666666"];
        _textField.backgroundColor = [UIColor hex:@"f5f5f5"];
        _textField.layer.borderColor = [UIColor hex:@"ededed"].CGColor;
        _textField.layer.borderWidth = 1;

        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor hex:@"45bafe"]];
        button.frame = CGRectMake(0, 0, AdFloat(60), AdFloat(60));
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _textField.rightView = button;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AdFloat(16), AdFloat(60))];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}
-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.titleLabel.font = SetFont(AdFloat(30));
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = SetFont(AdFloat(30));
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor hex:@"444444"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdFloat(60);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.font = SetFont(AdFloat(26));
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.textField.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [tableView removeFromSuperview];
}
-(void)okBtnClick{
    if (self.textView.text.length == 0) {
        [DWBToast showCenterWithText:@"请输入延期原因"];
        return;
    }
    if (self.textField.text.length == 0) {
        [DWBToast showCenterWithText:@"请选择延期天数"];
        return;
    }
    [self.superview removeFromSuperview];
    if (self.backOrderBlock) {
    self.backOrderBlock(@{@"info":self.textView.text,@"day":self.textField.text});
    }
}

-(void)cancelBtnClick{
    [self.superview removeFromSuperview];
}

-(void)buttonClick:(UIButton *)button{
    if (button.selected) {
        [self.tableView removeFromSuperview];
    }else{
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.textField);
            make.top.equalTo(self.textField.mas_bottom);
            make.height.mas_equalTo(AdFloat(240));
        }];
    }
    button.selected = !button.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
