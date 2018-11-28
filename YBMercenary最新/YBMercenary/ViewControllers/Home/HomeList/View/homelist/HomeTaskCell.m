//
//  HomeTaskCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "HomeTaskCell.h"
#import "HomeTaskDetailCell.h"
#import "SignUpVC.h"

@interface HomeTaskCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *recommendBtn;//推荐任务按钮
@property (nonatomic, strong) UIButton *cityBtn;    //同城按钮
@property (nonatomic, strong) UIView *blueView;     //蓝色标志视图
@property (nonatomic, strong) UITableView *tableView;//
@property (nonatomic, strong) NSArray *listArr;//数据源
@end

@implementation HomeTaskCell

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView{
    HomeTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTaskCell"];
    if (cell == nil) {
        cell = [[HomeTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTaskCell"];
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
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recommendBtn setTitle:@"任务推荐" forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:[UIColor hex:Blue_Color] forState:UIControlStateSelected];
    _recommendBtn.backgroundColor = [UIColor whiteColor];
    _recommendBtn.titleLabel.font = [UIFont fontSize:15];
    _recommendBtn.selected = YES;
    [_recommendBtn addTarget:self action:@selector(recommenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_recommendBtn];
    [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.height.mas_equalTo(Width(45));
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityBtn setTitle:@"同城" forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor hex:@"666666"] forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor hex:Blue_Color] forState:UIControlStateSelected];
    _cityBtn.titleLabel.font = [UIFont fontSize:15];
    _cityBtn.backgroundColor = [UIColor whiteColor];
    [_cityBtn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_cityBtn];
    [_cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(Width(45));
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(_recommendBtn);
        make.width.mas_equalTo(AdFloat(2));
        make.height.mas_equalTo(AdFloat(50));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hex:@"f5f5f5"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_recommendBtn.mas_bottom).offset(-Width(1));
        make.height.mas_equalTo(Width(1));
    }];
    
    _blueView = [[UIView alloc]init];
    _blueView.backgroundColor = [UIColor hex:Blue_Color];
    [self.contentView addSubview:_blueView];
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.height.mas_equalTo(AdFloat(4));
        make.width.mas_equalTo(kScreenWidth/2);
        make.bottom.equalTo(_recommendBtn);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor hex:Back_Color];
    [self.contentView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recommendBtn.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-Width(8));
        make.height.mas_equalTo(Width(110) * 2).priority(999);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.listArr.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTaskDetailCell *cell = [HomeTaskDetailCell creatTableViewCellWithTableView:tableView];
    cell.data = @{@"aaa":@"没有内容"};
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdFloat(220);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [DWBToast showCenterWithText:@"查看任务详情"];
    SignUpVC *vc = [[SignUpVC alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark  点击推荐任务
- (void)recommenAction:(UIButton *)sender{
    if (sender.selected) return;
    sender.selected = YES;
    _cityBtn.selected = NO;
    [UIView animateWithDuration:0.1 animations:^{
        _blueView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

#pragma mark  点击同城任务
- (void)cityAction:(UIButton *)sender{
    if (sender.selected) return;
    sender.selected = YES;
    _recommendBtn.selected = NO;
    [UIView animateWithDuration:0.1 animations:^{
        _blueView.transform = CGAffineTransformMakeTranslation(kScreenWidth/2, 0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
