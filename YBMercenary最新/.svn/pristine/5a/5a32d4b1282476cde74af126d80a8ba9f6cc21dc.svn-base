//
//  ZoneCommentListCell.m
//  Ranch
//
//  Created by 龙青磊 on 2018/3/7.
//  Copyright © 2018年 xfkeji_Ranch. All rights reserved.
//

#import "ZoneCommentListCell.h"
#import "UIFont+FitSize.h"
#import "UILabel+QLabel.h"

@interface ZoneCommentListCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *backView;
@end

@implementation ZoneCommentListCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    ZoneCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZoneCommentListCell"];
    if (cell == nil) {
        cell = [[ZoneCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZoneCommentListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor clearColor];
    _backView.clipsToBounds = YES;
    [self.contentView addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width(0));
        make.right.equalTo(self.contentView.mas_right).offset(-Width(0));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor hex:@"666666"];
    _contentLabel.font = [UIFont fontSize:14];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView).offset(Width(10));
        make.left.equalTo(_backView).offset(Width(10));
        make.right.equalTo(_backView).offset(-Width(10));
        make.bottom.equalTo(_backView.mas_bottom);
    }];
}

- (void)setModel:(PostsCommentListModel *)model{
    _model = model;
    
    
    NSString *commentname = model.huifu_user_name;//[_model.commenter objectForKey:@"username"];
    NSString *content = model.huifu_content;//_model.content;
    NSString *totalString = [NSString stringWithFormat:@"%@: %@",commentname, content];
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:totalString];
    [newString addAttribute:NSFontAttributeName value:[UIFont fontSize:14] range:NSMakeRange(0, totalString.length)];
    [newString addAttribute:NSForegroundColorAttributeName value:[UIColor hex:@"333333"] range:NSMakeRange(0, commentname.length)];
    _contentLabel.attributedText = newString;
    [_contentLabel onTapRangeActionWithString:@[totalString] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"点击了-->--%@ ---下标：%ld",string,index);
    }];
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
