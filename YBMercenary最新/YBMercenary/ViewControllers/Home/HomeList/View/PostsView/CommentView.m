//
//  CommentView.m
//  Ranch
//
//  Created by 龙青磊 on 2018/3/7.
//  Copyright © 2018年 xfkeji_Ranch. All rights reserved.
//

#import "CommentView.h"
#import "UILabel+QLabel.h"
#import "ZoneCommentListCell.h"

@interface CommentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatSubViews];
        self.clipsToBounds = YES;
    }
    return self;
}


- (void)creatSubViews{
    self.backgroundColor = [UIColor hex:Back_Color];

    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Width(5));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-Width(5));
    }];
    
}

- (void)setModel:(PostsCommentModel *)model{
    _model = model;
//    if (_model.commentList.count > 0) {
//        _tableView.hidden = NO;
//        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
////            make.height.mas_equalTo(_model.commentHeight);
////            make.height.mas_equalTo(Width(30)*_model.commentList.count);
//        }];
//    }else{
//        _tableView.hidden = YES;
//        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self);
//            make.bottom.equalTo(self.mas_bottom);
//            make.height.mas_equalTo(0);
//        }];
//    }
    [_tableView reloadData];
//    [self updateConstraints];
//    [self layoutIfNeeded];
}



#pragma mark  UITableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.huifu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZoneCommentListCell *cell = [ZoneCommentListCell creatTableViewCellWithTableView:tableView];
    cell.model = self.model.huifu[indexPath.row];
    return cell;
}

@end
