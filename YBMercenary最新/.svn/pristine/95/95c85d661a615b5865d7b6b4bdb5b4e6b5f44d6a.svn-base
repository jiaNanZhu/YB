//
//  LeaveMessageCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/13.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "LeaveMessageCell.h"
#import "YBLoginViewController.h"
#import "YBNavigationViewController.h"
@interface LeaveMessageCell ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation LeaveMessageCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    LeaveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveMessageCell"];
    if (cell == nil) {
        cell = [[LeaveMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeaveMessageCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)initSubViews{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    UILabel *messageLabel = [F_UI SL_UI_Label:@"留言板" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(30) numberOfLines:1 ];
    [self.contentView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(backView).offset(Width(15));
    }];
    
    _textView = [[UITextView alloc]init];
    [_textView setBorderWidth:1 borderColor:[UIColor hex:Back_Color] radius:0];
    _textView.textColor = [UIColor hex:@"444444"];
    _textView.font = [UIFont fontSize:AdFloat(28)];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageLabel.mas_bottom).offset(Width(10));
        make.left.equalTo(messageLabel);
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(10));
        make.height.mas_equalTo(Width(70));
    }];
    
    _tipLabel = [F_UI SL_UI_Label:@"请输入留言内容" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:14 numberOfLines:1 ];
    [self.contentView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView).offset(Width(8));
        make.left.equalTo(_textView).offset(Width(5));
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        _tipLabel.hidden = YES;
    }else{
        _tipLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    if ([[YBUser boolLogin]isEqualToString:@""]||[YBUser boolLogin] == nil) {
        YBLoginViewController *viewc = [[YBLoginViewController alloc]init];
        YBNavigationViewController *nav = [[YBNavigationViewController alloc]initWithRootViewController:viewc];
        [self.viewController presentViewController:nav animated:YES completion:nil];
    }else{
        if (textView.text.length>0) {
            [self postMessageToServerWithText:textView.text];
        }
    }
}
-(void)postMessageToServerWithText:(NSString *)text{
    NSDictionary *dic = @{@"token":USERTOKEN,@"id":@(self.taskId),@"leavemsg_content":text};
    [[YBRequestManager sharedYBManager] postWithUrlString:Add_board parameters:dic success:^(id data) {
        DBLog(@"%@",data);
        if ([data[@"code"] integerValue] == 0) {
            if (self.refreshMessageList) {
                self.refreshMessageList();
            }
            self.textView.text = nil;
            [DWBToast showCenterWithText:@"留言发布成功"];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        DBLog(@"%@",error);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
