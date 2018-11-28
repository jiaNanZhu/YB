//
//  PostsCommentCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PostsCommentCell.h"
#import "CommentView.h"
#import "DateTool.h"
@interface PostsCommentCell ()

@property (nonatomic, strong) UIImageView *iconImage;//头像
@property (nonatomic, strong) UILabel *nameLabel;//名称
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel *contentLabel;//内容
@property (nonatomic, strong) CommentView *commentView;
@property (nonatomic, strong) UIButton *commentBtn;//评论

@end

@implementation PostsCommentCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    PostsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCommentCell"];
    if (cell == nil) {
        cell = [[PostsCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostsCommentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(Width(1));
    }];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(line.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    _iconImage = [[UIImageView alloc]init];
    _iconImage.layer.cornerRadius = Width(20);
    _iconImage.layer.borderWidth = 1;
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.image = [UIImage imageNamed:@"Group1"];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Width(15));
        make.top.equalTo(backView).offset(Width(15));
        make.width.height.mas_equalTo(Width(40));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"豆豆";
    _nameLabel.textColor = [UIColor hex:@"444444"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImage);
        make.left.equalTo(_iconImage.mas_right).offset(Width(10));
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"1分钟前";
    _timeLabel.textColor = [UIColor hex:@"999999"];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.centerY.equalTo(_iconImage);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.text = @"今天天气不错,晒个图";
    _contentLabel.textColor = [UIColor hex:@"444444"];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(Width(12));
        make.left.equalTo(_iconImage.mas_right).offset(Width(10));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
//        make.bottom.equalTo(backView.mas_bottom).offset(-Width(15));
    }];
    
    _commentView = [[CommentView alloc]init];
    [self.contentView addSubview:_commentView];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(Width(10));
        make.left.equalTo(_contentLabel);
        make.right.equalTo(_contentLabel.mas_right);
        make.height.mas_equalTo(Width(30));
    }];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont fontSize:12];
    [_commentBtn addTarget:self action:@selector(commentMethodclick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLabel);
        make.top.equalTo(_commentView.mas_bottom).offset(Width(15));
        make.width.mas_equalTo(Width(30));
        make.height.mas_equalTo(Width(25));
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(15));
    }];
}

- (void)setModel:(PostsCommentModel *)model{
    _model = model;
    
    _nameLabel.text= model.liuyan_user_name;
    _timeLabel.text=[DateTool timeStampToString:[model.create_time integerValue]];
    _contentLabel.text=model.liuyan_content;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.liuyan_user_headimg]] placeholderImage:[UIImage imageNamed:@"Group1"]];
    
    self.commentView.model = model;
    
    if (model.huifu.count > 0) {
        [_commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Width(30)*_model.huifu.count + Width(10));
        }];
    }
    else{
        
        [_commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Width(0)*_model.commentList.count + Width(0));
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)commentMethodclick{
//    [DWBToast showCenterWithText:@"开始评论"];
    
    self.commentMethod(_model.id);
}

@end
