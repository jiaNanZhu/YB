//
//  TaskChoseView.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/13.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskChoseView.h"
#import "TaskChoseCell.h"
#import "PubTypeListVC.h"

@interface TaskChoseView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TaskChoseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}

- (void)setTypeArr:(NSArray *)typeArr{
    _typeArr = typeArr;
    [_tableView reloadData];
}
-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex=selectIndex;
    [_tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.typeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskChoseCell *cell = [TaskChoseCell creatTableViewCellWithTableView:tableView];
    cell.title = self.typeArr[indexPath.row];
    cell.type = self.type;
    if (indexPath.row == self.selectIndex) {
        cell.chose = YES;
    }else{
        cell.chose = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.type isEqualToString:@"task"]) {
        self.selectIndex = indexPath.row;
        [self.tableView reloadData];
        if (_choseFinish) {
            self.choseFinish();
        }
    }else{
        self.selectIndex = indexPath.row;
        [self.tableView reloadData];
        if (_choseFinish) {
            self.choseFinish();
        }
        PubTypeListVC *vc = [[PubTypeListVC alloc]init];
        
        NSString *typestr=nil;
        switch (self.selectIndex) {
            case 0:{
                typestr = @"跑腿";
            }
                break;
            case 1:{
                typestr = @"生活";
            }
                break;
            case 2:{
                typestr = @"个人定制";
            }
                break;
            case 3:{
                typestr = @"工作";
            }
                break;
            case 4:{
                typestr = @"健康";
            }
                break;
            default:
                typestr = @"其他";
                break;
        }
        vc.title=typestr;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

@end
