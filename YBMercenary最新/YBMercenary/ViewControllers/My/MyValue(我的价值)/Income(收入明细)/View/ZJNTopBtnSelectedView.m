//
//  ZJNTopBtnSelectedView.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNTopBtnSelectedView.h"
#import "SelectModel.h"
@interface ZJNTopBtnSelectedView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@end
@implementation ZJNTopBtnSelectedView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        UIImageView *checkImageV = [[UIImageView alloc]init];
        checkImageV.tag = 100;
        [cell.contentView addSubview:checkImageV];
        [checkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-AdFloat(30));
            make.centerY.equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(22, 14));
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = SetFont(AdFloat(28));
    UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:100];
    SelectModel *model = self.sourceArr[indexPath.row];
    cell.textLabel.text = model.text;
    if (model.selected) {
        cell.textLabel.textColor = [UIColor hex:@"0386FF"];
        imageV.image = SetImage(@"选中 copy 3");
    }else{
        cell.textLabel.textColor = [UIColor hex:@"444444"];
        imageV.image = SetImage(@"");
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshSelectedBlock) {
        self.refreshSelectedBlock(indexPath.row);
    }
}
-(void)setSourceArr:(NSArray *)sourceArr{
    _sourceArr = sourceArr;
    [self.tableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
