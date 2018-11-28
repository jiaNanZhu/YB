//
//  PublishListTaskVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/26.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PublishLifeTaskVC.h"
#import "PublishTaskNameCell.h"
#import "PublishTaskGoal.h"
#import "PublishTaskRequireCell.h"
#import "PublishTaskMarkCell.h"
#import "LifeFiltrateReceiverCell.h"
#import "PublishTaskDetailCell.h"
#import "PublishTaskAddPhotosCell.h"
#import "ZJNPublishTaskMaskCell.h"
@interface PublishLifeTaskVC ()<PublishTaskRequireCellDelegate,UIScrollViewDelegate,ZJNPublishTaskMaskCellDelegate>

@property (nonatomic, assign) NSInteger lineCount;
@property (nonatomic, assign) NSInteger maskLineCount;

@property(nonatomic,strong)PublishTaskNameCell *task_nameCell;

@property(nonatomic,strong)PublishTaskGoal *task_purposeCell;
@property(nonatomic,strong)PublishTaskRequireCell *requireCell;
@property(nonatomic,strong)LifeFiltrateReceiverCell *receiverCell;


@property(nonatomic,strong)ZJNPublishTaskMaskCell *markCell;
@property(nonatomic,strong)PublishTaskDetailCell *detailCell;

@property(nonatomic,strong)NSString *task_request;

@property(nonatomic,strong)NSString *task_tag;

@property(nonatomic,copy)NSString *imagePath;
@end

@implementation PublishLifeTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _lineCount = 1;
    _maskLineCount = 1;
    _imagePath = @"";
    [self configNav];
    [self configTableView];
}

- (void)configNav{
    self.navigationItem.title = @"发布任务";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)configTableView{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor hex:Back_Color];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, Width(10), 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PublishTaskNameCell *cell = [PublishTaskNameCell creatTableViewCellWithTableView:tableView];
        self.task_nameCell=cell;
        return cell;
    }else if(indexPath.row == 1){
        PublishTaskGoal *cell = [PublishTaskGoal creatTableViewCellWithTableView:tableView];
        self.task_purposeCell=cell;
        return cell;
    }else if(indexPath.row == 2){
        PublishTaskRequireCell *cell= [PublishTaskRequireCell creatTableViewCellWithTableView:tableView];
        self.requireCell=cell;
        cell.linecount = self.lineCount;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 3){
        LifeFiltrateReceiverCell *cell = [LifeFiltrateReceiverCell creatTableViewCellWithTableView:tableView];
        self.receiverCell=cell;
        return cell;
    }else if (indexPath.row == 4){
        ZJNPublishTaskMaskCell *cell = [ZJNPublishTaskMaskCell creatTableViewCellWithTableView:tableView];
        self.markCell = cell;
        cell.linecount = _maskLineCount;
        cell.delegate = self;
        return cell;
//        PublishTaskMarkCell *cell = [PublishTaskMarkCell creatTableViewCellWithTableView:tableView];
//        self.markCell=cell;
//        return cell;
    }
    else if (indexPath.row == 5){
        PublishTaskDetailCell *cell = [PublishTaskDetailCell creatTableViewCellWithTableView:tableView];
        self.detailCell=cell;
        return cell;
    }else{
        PublishTaskAddPhotosCell *cell = [PublishTaskAddPhotosCell creatTableViewCellWithTableView:tableView];
        cell.vc=self;
        cell.imageUrlsBlock = ^(NSString *imagePaths) {
            self.imagePath = imagePaths;
        };
        return cell;
    }
}

#pragma mark 点击导航右侧按钮
- (void)publishAction{
    
    
    self.task_request=nil;
    self.task_tag=nil;
    for (NSString * str in self.requireCell.dataArr) {
        if (!self.task_request) {
            self.task_request=[NSString stringWithFormat:@"%@",str];
        }
        else{
            self.task_request=[NSString stringWithFormat:@"%@|%@",self.task_request,str];
        }
        
    }
        
    
    for (NSString * str in self.markCell.dataArr) {
        if (!self.task_tag) {
            self.task_tag=[NSString stringWithFormat:@"%@",str];;
        }
        else{
            self.task_tag=[NSString stringWithFormat:@"%@|%@",self.task_tag,str];
        }
        
    }
    if (self.task_nameCell.nameField.text.length<=0) {
        [DWBToast showCenterWithText:@"请输入任务名称"];
    }
    else if (self.task_purposeCell.textView.text.length<=0)
    {
       [DWBToast showCenterWithText:@"请输入任务目的"];
    }
    else if (self.task_request.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入任务要求"];
    }
    else if (self.receiverCell.moneyField.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入佣金金额"];
    }
    else if (self.receiverCell.dateField.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入任务有效期"];
    }
    else if (self.task_tag.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入文字标签"];
    }
    else if (self.detailCell.textView.text.length<=0)
    {
        [DWBToast showCenterWithText:@"请输入任务详情"];
    }
    else if (self.imagePath.length == 0){
        [DWBToast showCenterWithText:@"请选择图片"];
    }
    else{
     
        [self  requestCommonDrunkery_post_add];
    }

}

- (void)reloadeViewWithLineCount:(NSInteger)count{
    _lineCount = count;
    [self.tableView reloadData];
}
#pragma mari-ZJNPublishTaskMaskCellDelegate
-(void)zjnReloadeViewWithLineCount:(NSInteger)count{
    _maskLineCount = count;
    [self.tableView reloadData];
}
- (void)cancleAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}



#pragma mark request
#pragma mark
-(void)requestCommonDrunkery_post_add
{
    NSString *payAmountStr = self.receiverCell.moneyField.text;
    CGFloat payAmount = 100*[payAmountStr floatValue];
    
    NSDictionary *parameters =@{@"token":USERTOKEN,@"task_type":@(self.task_type),@"task_type_child":@(self.task_type_child),@"task_name":self.task_nameCell.nameField.text,@"task_purpose":self.task_purposeCell.textView.text,@"task_request":self.task_request,@"pay_amount":[NSString stringWithFormat:@"%.f",payAmount],@"validity_time":self.receiverCell.dateField.text,@"task_tag":self.task_tag,@"task_description":self.detailCell.textView.text,@"task_img":self.imagePath,@"task_city":[[NSUserDefaults standardUserDefaults] objectForKey:@"locationCity"]};
    [[YBRequestManager sharedYBManager]postWithUrlString:Home_Task_addtask parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            
            
            [DWBToast showCenterWithText:@"发布成功"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
