//
//  WaitChoseListCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/16.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "WaitChoseListCell.h"
#import "ChosePersonCell.h"

@interface WaitChoseListCell ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *backView;
}

@property (nonatomic, strong) UIButton *signupBtn;
@property (nonatomic, strong) UIButton *choseBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *choseView;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation WaitChoseListCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    WaitChoseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitChoseListCell"];
    if (cell == nil) {
        cell = [[WaitChoseListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WaitChoseListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor hex:Back_Color];
    }
    return cell;
}

- (void)initSubViews{
    self.type = @"signup";
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, Width(8), 0));
    }];
    
    _signupBtn = [F_UI creatBtnWithTager:self title:@"已报名人" font:15 image:nil backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"666666"] cornerRadius:0 action:@selector(alreadyMethod:)];
    [_signupBtn setTitleColor:[UIColor hex:Blue_Color] forState:UIControlStateSelected];
    [self.contentView addSubview:_signupBtn];
    [_signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(backView);
        make.height.mas_equalTo(Width(50));
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    _choseBtn = [F_UI creatBtnWithTager:self title:@"待选人" font:15 image:nil backImage:nil color:[UIColor whiteColor] textColor:[UIColor hex:@"666666"] cornerRadius:0 action:@selector(waitChoseMethod:)];
    [self.contentView addSubview:_choseBtn];
    [_choseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_signupBtn);
        make.right.equalTo(backView);
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    UIView *lineH = [[UIView alloc]init];
    lineH.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.equalTo(_signupBtn).offset(Width(8));
        make.bottom.equalTo(_signupBtn.mas_bottom).offset(-Width(8));
        make.width.mas_equalTo(Width(1));
    }];
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signupBtn.mas_bottom);
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(0);
        make.bottom.equalTo(backView).offset(-Width(8));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(_signupBtn.mas_bottom);
        make.height.mas_equalTo(Width(1));
    }];
    
    _choseView = [[UIView alloc]init];
    _choseView.backgroundColor = [UIColor hex:Blue_Color];
    [self.contentView addSubview:_choseView];
    [_choseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signupBtn.mas_bottom).offset(Width(-1));
        make.left.equalTo(backView);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(Width(2));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChosePersonCell *cell = [ChosePersonCell creatTableViewCellWithTableView:tableView];
    cell.type = self.type;
    NSDictionary *dic = self.dataArray[indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:dic[@"apply_user_headimg"]] placeholderImage:[UIImage imageNamed:@"Group1"]];
    cell.nameLabel.text = dic[@"apply_user_name"];
//    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"apply_amount"]];
    cell.priceLabel.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Width(60);
}

- (void)alreadyMethod:(UIButton *)sender{
    if (sender.selected) return;
    self.type = @"signup";
    sender.selected = YES;
    _choseBtn.selected = NO;
    [UIView animateWithDuration:0.1 animations:^{
        _choseView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
//    [_tableView reloadData];
    [self getDataFromService];
}

- (void)waitChoseMethod:(UIButton *)sender{
    if (sender.selected) return;
    self.type = @"chose";
    sender.selected = YES;
    _signupBtn.selected = NO;
    [UIView animateWithDuration:0.1 animations:^{
        _choseView.transform = CGAffineTransformMakeTranslation(kScreenWidth/2, 0);
    }];
//    [_tableView reloadData];
    [self getDataFromService];
}
-(void)setTaskId:(NSInteger)taskId{
    _taskId = taskId;
    [self getDataFromService];
}
-(void)getDataFromService{
    //signup chose
    NSInteger status;
    if ([self.type isEqualToString:@"chose"]) {
        status = 1;
    }else{
        status = 0;
    }
    NSDictionary *dic = @{@"id":@(self.taskId),@"apply_status":@(status)};
    [[YBRequestManager sharedYBManager] postWithUrlString:Get_applylist parameters:dic success:^(id data) {
        DBLog(@"%@",data);
        if ([data[@"code"] integerValue] == 0) {
            self.dataArray = data[@"data"];
            
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_signupBtn.mas_bottom);
                make.left.right.equalTo(backView);
                make.height.mas_equalTo(Width(60) * self.dataArray.count);
                make.bottom.equalTo(backView);
            }];
            
            if (self.updateTableViewHeightBlock) {
                self.updateTableViewHeightBlock();
            }
            [self.tableView reloadData];
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
