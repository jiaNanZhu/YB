//
//  ZJNAgreeRulesViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/4.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNAgreeRulesViewController.h"
#import "ZJNRulesTableViewCell.h"
@interface ZJNAgreeRulesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,copy)NSArray *infoArr;
@property (nonatomic ,copy)NSArray *titleArr;
@property (nonatomic ,strong)UIView *footerView;
@property (nonatomic ,assign)BOOL isAgree;
@end

@implementation ZJNAgreeRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推广准则";
    self.isAgree = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _infoArr = @[@[@"本协议为您（甲方）与APP管理者（乙方）之间所订立的契约，具有合同的法律效力，请您仔细阅读。您点击“我已阅读并同意本《佣兵天下APP》服务分销协议”按钮后，本协议即生效，对双方产生约束力。"],@[@"1.1甲方可通过各种合法合规的方式，向周边人群推送自己在乙方所申请到的推广二维码。为乙方发展用户。",@"1.2甲方可以得到自己发展成功的用户交易金额的百分之一作为提成。"],@[@"1.1乙方通过软件向甲方发送乙方所申请的二维码，并协助乙方发展用户。",@"1.2乙方在甲方所发展的用户交易完毕后将乙方所发展交易金额的百分之一作为提成转至乙方在APP内的账户并记录，并通过APP向乙方告知。"],@[@"甲方不可使用违法违规的方法进行推广，若甲方有违法违规的推广行为，由甲方自行承担责任。"]];
    _titleArr = @[@"甲方的权利与义务",@"乙方的权利与义务",@"免责条款"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = self.footerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _footerView.backgroundColor = [UIColor whiteColor];
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.layer.cornerRadius = 22;
        agreeBtn.layer.masksToBounds = YES;
        [agreeBtn setTitle:@"我已阅读并同意《佣兵天下》的服务协议" forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        agreeBtn.titleLabel.font = SetFont(AdFloat(32));
        [agreeBtn setBackgroundImage:SetImage(@"nav") forState:UIControlStateNormal];
        [_footerView addSubview:agreeBtn];
        [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footerView).offset(AdFloat(60));
            make.right.equalTo(_footerView).offset(-AdFloat(60));
            make.top.equalTo(_footerView).offset(50);
            make.height.mas_equalTo(44);
        }];
        UILabel *readLabel = [[UILabel alloc]init];
        readLabel.text = @"我已阅读推广准则";
        readLabel.font = SetFont(AdFloat(28));
        readLabel.textColor = [UIColor hex:@"999999"];
        [_footerView addSubview:readLabel];
        [readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_footerView).offset(10);
            make.top.equalTo(agreeBtn.mas_bottom).offset(AdFloat(30));
        }];
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:SetImage(@"Rectangle 55 Copy") forState:UIControlStateNormal];
        [selectBtn setImage:SetImage(@"Group") forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(readLabel.mas_left).offset(10);
            make.centerY.equalTo(readLabel);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
    }
    return _footerView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 38;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 38)];
        topView.backgroundColor = [UIColor hex:@"e6e6e6"];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, kScreenWidth, 30)];
        bgView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:bgView];
        return topView;
    }
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(AdFloat(30), 4, kScreenWidth-AdFloat(60), 36)];
    titleLabel.textColor = [UIColor hex:@"333333"];
    titleLabel.font = SetFont(AdFloat(28));
    titleLabel.text = self.titleArr[section-1];
    [bgView addSubview:titleLabel];
    
    return bgView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    ZJNRulesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ZJNRulesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.infoStr = self.infoArr[indexPath.section][indexPath.row];
    return cell;
}

-(void)selectBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    self.isAgree = button.selected;
}
-(void)agreeBtnClick{
    if (self.isAgree) {
        NSDictionary *dic = @{@"token":USERTOKEN,@"isagree":@"1"};
        [[YBRequestManager sharedYBManager] postWithUrlString:IsAgree parameters:dic success:^(id data) {
            if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [DWBToast showCenterWithText:data[@"msg"]];
            }
        } failure:^(NSError *error) {
            [DWBToast showCenterWithText:@"连接服务器失败"];
        }];
    }else{
        [DWBToast showCenterWithText:@"未同意推广准则"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

