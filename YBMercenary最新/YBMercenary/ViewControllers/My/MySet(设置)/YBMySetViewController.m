//
//  YBMySetViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMySetViewController.h"
#import "YBMySetImportViewController.h"
#import "YBMySetAccountViewController.h"
#import "YBMySetHelpViewController.h"
#import "YBMySetFeedbackViewController.h"
#import "YBMySetAboutUsViewController.h"
#import "AppDelegate.h"
#import "YBLoginViewController.h"

//#import "MyCertificationViewController.h"
#import "ZJNIndividualCertificationViewController.h"
#import <RongCloudIM/RongIMLib/RCIMClient.h>
#import "YBTabbarViewController.h"

@interface YBMySetViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *titleArr;
    
    UIImageView *picIMG;
    UILabel *nicknameLab;
    UILabel *nameLab;
    UILabel *sexLab;
    UILabel *ageLab;
    UILabel *cacheLab;
    
    
    UILabel *CertificationLab;
    
    NSString *certificationtext;
    
    UISwitch *mainSwitch;
}
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,assign)BOOL issecurity;
@end

@implementation YBMySetViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestuserInfo];
    
    [self requestUserCenter_get_zili];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    titleArr = @[@"头像",@"昵称",@"姓名",@"性别",@"年龄",@"个人实名认证",@"账号与安全",@"清除缓存",@"接收消息",@"帮助",@""];
    
    
    [self.view addSubview:self.tableView];
    
    [self nav];
}

#pragma mark - NAV
-(void)nav{
    UIButton *rightBtn = [F_UI SL_UI_Btn:@"显示真实姓名" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(rightBtn:) cornerRadius:0];
    rightBtn.frame = CGRectMake(0, 0, AdFloat(80), AdFloat(30));
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)rightBtn:(UIButton*)btn
{
    
    self.issecurity=!self.issecurity;
    
    [btn setTitle:self.issecurity?@"隐藏真实姓名":@"显示真实姓名" forState:UIControlStateNormal];
    
    [self.tableView reloadData];
    
}
-(UITableView *)tableView
{
    if (_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AdFloat(16), d_Device_width, d_Device_height-iPhone_X_bool_Nav_height-AdFloat(16))];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.backgroundColor = [UIColor hex:@"F2F2F2"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        
    }
    return _tableView;
}
#pragma mark - 分组cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return AdFloat(120);
    }
    
    else if (indexPath.row == 4 ||indexPath.row == 5){
        return AdFloat(106);
    }
    
    else if (  indexPath.row == 7){
        return AdFloat(90);
    }
    else if (  indexPath.row == 8){
        return AdFloat(90);
    }
    
    else if (  indexPath.row == 10){
        return AdFloat(150);
    }
//    else if (indexPath.row == 9){
//        return AdFloat(106);
//    }
    return AdFloat(90);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor whiteColor];
    UIView *xianView = [F_UI SL_UI_View:[UIColor hex:@"F2F2F2"] cornerRadius:0 borderColor:nil borderWidth:0];
    xianView.frame = CGRectMake(AdFloat(30), AdFloat(88), d_Device_width-AdFloat(60), AdFloat(2));
    [cell addSubview:xianView];
    
    UILabel *lab = [F_UI SL_UI_Label:titleArr[indexPath.row] color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
    
    
    [cell addSubview:lab];
    
    UIImageView *img = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"返回-4 copy 6"] cornerRadius:0];
    img.frame = CGRectMake(d_Device_width-AdFloat(42), AdFloat(34), AdFloat(12), AdFloat(24));
    [cell addSubview:img];
    if (indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 11) {
        
    }
    if (indexPath.row == 0) {
        xianView.frame = CGRectMake(AdFloat(30), AdFloat(118), d_Device_width-AdFloat(60), AdFloat(2));
        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(120));
        img.frame = CGRectMake(d_Device_width-AdFloat(42), AdFloat(48), AdFloat(12), AdFloat(24));
        
        picIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"Group1"] cornerRadius:AdFloat(40)];
        picIMG.frame = CGRectMake(d_Device_width-AdFloat(146), AdFloat(20), AdFloat(80), AdFloat(80));
        
        [picIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,self.user.head_img]] placeholderImage:[UIImage imageNamed:@"Group1"]];
        [cell addSubview:picIMG];
    }else if (indexPath.row == 1){
        nicknameLab = [F_UI SL_UI_Label:self.user.nick_name color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
        nicknameLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(434), AdFloat(90));
        [cell addSubview:nicknameLab];
    }else if (indexPath.row == 2){
        
        img.hidden = YES;
 lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
        NSString *name=nil;
        if (self.issecurity) {
            
            name=self.user.name;
            
        }
        else{
            if (!self.user.name || [self.user.name isEqualToString:@""]) {
                self.user.name=@" ";
            }
            
            NSMutableString * num = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@"
                                                                       ,self.user.name]];
            [num replaceCharactersInRange:NSMakeRange(1, self.user.name.length-1)  withString:@"***"];
            NSLog(@"%@",num);
            
            name =[NSString stringWithFormat:@"%@",num];
        }
        
        nameLab = [F_UI SL_UI_Label:name color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
        nameLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(470), AdFloat(90));
        [cell addSubview:nameLab];
    }else if (indexPath.row == 3){
        img.hidden = YES;
        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
        sexLab = [F_UI SL_UI_Label:[self.user.sex boolValue]?@"女":@"男" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
        sexLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(470), AdFloat(90));
        [cell addSubview:sexLab];
    }else if (indexPath.row == 4){
        img.hidden = YES;
 lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
        xianView.frame = CGRectMake(0, AdFloat(90), d_Device_width, AdFloat(16));
        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
        
        ageLab = [F_UI SL_UI_Label:self.user.age color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
        ageLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(470), AdFloat(90));
        
        [cell addSubview:ageLab];
    }else if (indexPath.row == 5 ){
        
        
        CertificationLab =[F_UI SL_UI_Label:certificationtext color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
        CertificationLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(434), AdFloat(90));
        
        [cell addSubview:CertificationLab];
        xianView.frame = CGRectMake(0, AdFloat(90), d_Device_width, AdFloat(16));
        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
    }
    
    else if (indexPath.row == 6){
        
        
        
        xianView.frame = CGRectMake(0, AdFloat(90), d_Device_width, AdFloat(16));
        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
    }
    
    else if (indexPath.row == 7){
        
       
        
        img.hidden = YES;
        
        unsigned long long size = [SDImageCache sharedImageCache].getSize;
        
        //设置文件大小格式
        NSString *sizeText = nil;
        if (size >= pow(10, 9)) {
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        }else if (size >= pow(10, 6)) {
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        }else if (size >= pow(10, 3)) {
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        }else {
            sizeText = [NSString stringWithFormat:@"%lluB", size];
        }
        
        
        cacheLab = [F_UI SL_UI_Label:sizeText color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentRight textFont:AdFloat(28) numberOfLines:1];
        cacheLab.frame = CGRectMake(d_Device_width-AdFloat(500), 0, AdFloat(470), AdFloat(90));
        
        lab.frame=CGRectMake(AdFloat(30), 3, AdFloat(200), AdFloat(90));
        [cell addSubview:cacheLab];
    }else if (indexPath.row == 8){
        
        img.hidden = YES;
        xianView.frame = CGRectMake(0, AdFloat(90), d_Device_width, AdFloat(16));
        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
        
        mainSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(d_Device_width-AdFloat(132), AdFloat(14), AdFloat(102), AdFloat(62))];
        mainSwitch.on = YES;
        [cell addSubview:mainSwitch];
        
        
        
        NSString *ison = [[NSUserDefaults standardUserDefaults]objectForKey:@"msgswitch"];
        
        if ([ison isEqualToString:@"1"] ||ison==nil) {
            // 设置开关状态(默认是 关)
            [mainSwitch setOn:YES animated:NO];
        }
        else{
            // 设置开关状态(默认是 关)
            [mainSwitch setOn:NO animated:NO];  //animated
        }
        //添加事件监听
        [mainSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        //onTintColor 开状态下的背景颜色
        mainSwitch.onTintColor = [UIColor hex:@"0386FF"];
    }else if (indexPath.row == 10){
//        xianView.frame = CGRectMake(0, AdFloat(90), d_Device_width, AdFloat(16));
//        lab.frame = CGRectMake(AdFloat(30), 0, AdFloat(200), AdFloat(90));
        
        
        img.hidden = YES;
        cell.backgroundColor = [UIColor hex:@"F2F2F2"];
        
        UIButton *logoutBtn = [F_UI SL_UI_Btn:@"退出登录" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(logoutBtn) cornerRadius:AdFloat(45)];
        logoutBtn.frame = CGRectMake(AdFloat(60), AdFloat(60), d_Device_width-AdFloat(120), AdFloat(90));
//        [logoutBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
        [logoutBtn setBackgroundImage:SetImage(@"nav") forState:UIControlStateNormal];
        [cell addSubview:logoutBtn];
        
    }else if (indexPath.row == 9){
        lab.frame = CGRectMake(AdFloat(30), 3, AdFloat(200), AdFloat(90));
    }else{
//        img.hidden = YES;
//        cell.backgroundColor = [UIColor hex:@"F2F2F2"];
//
//        UIButton *logoutBtn = [F_UI SL_UI_Btn:@"退出登录" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(logoutBtn) cornerRadius:AdFloat(45)];
//        logoutBtn.frame = CGRectMake(AdFloat(60), AdFloat(60), d_Device_width-AdFloat(120), AdFloat(90));
//        [logoutBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
//        [cell addSubview:logoutBtn];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBLog(@"------ 点击%ld行 ------",(long)indexPath.row);
    if (indexPath.row == 0) {
        [self headBtn];
    }else if (indexPath.row == 1){
        YBMySetImportViewController *vc = [[YBMySetImportViewController alloc] init];
        vc.title = @"修改昵称";
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
        
//        YBMySetImportViewController *vc = [[YBMySetImportViewController alloc] init];
//        vc.title = @"姓名";
//        vc.type = 2;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
//        [self sexBtn];
    }else if (indexPath.row == 4){
//        YBMySetImportViewController *vc = [[YBMySetImportViewController alloc] init];
//        vc.title = @"年龄";
//        vc.type = 3;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 6){
        
        
        YBMySetAccountViewController *vc = [[YBMySetAccountViewController alloc] init];
        vc.user=self.user;
        vc.title = @"账号与安全";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 7){
        
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"清除缓存"
                              
                                                       message:nil
                              
                                                      delegate:self
                              
                                             cancelButtonTitle:@"取消"
                              
                                             otherButtonTitles:@"确定", nil];
        
        [alert show];
        
        
    }else if (indexPath.row == 5){
        
        ZJNIndividualCertificationViewController *vc = [[ZJNIndividualCertificationViewController alloc] init];
//        vc.title = @"个人实名认证";
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 9){
        YBMySetHelpViewController *vc = [[YBMySetHelpViewController alloc] init];
        vc.title = @"帮助";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 9){
        YBMySetFeedbackViewController *vc = [[YBMySetFeedbackViewController alloc] init];
        vc.title = @"问题反馈";
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if (indexPath.row == 10){
//        YBMySetAboutUsViewController *vc = [[YBMySetAboutUsViewController alloc] init];
//        vc.title = @"关于我们";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

#pragma mark - 头像
-(void)headBtn{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBLog(@"------ 从相册中选取 ------");
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    [showAllInfoAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *pickAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBLog(@"------ 拍照 ------");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [pickAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        DBLog(@"------ 取消 ------");
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    [actionSheetController addAction:pickAction];
    [actionSheetController addAction:showAllInfoAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
    
}
#pragma mark - 性别
-(void)sexBtn{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBLog(@"------ 女 ------");
        
        [self requestUserCenter_setinfowithsex:1];
    }];
    [showAllInfoAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *pickAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBLog(@"------ 男 ------");
        [self requestUserCenter_setinfowithsex:0];
    }];
    [pickAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        DBLog(@"------ 取消 ------");
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    [actionSheetController addAction:pickAction];
    [actionSheetController addAction:showAllInfoAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}
#pragma mark - 退出登录
-(void)logoutBtn{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //退出登录
        [YBUser setBoolLogin:@""];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPUserTokenKey];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPUserRCTokenKey];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:PREFECTINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[RCIMClient sharedRCIMClient] logout];
        
        self.navigationController.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
        YBLoginViewController *loginvc =[[YBLoginViewController alloc]init];
        UINavigationController *nav =  [[UINavigationController alloc]initWithRootViewController:loginvc];
        [self.navigationController.tabBarController  presentViewController:nav animated:YES completion:nil];
    }];
    [alertC addAction:cancelAction];
    [alertC addAction:okAction];
    [self presentViewController:alertC animated:YES completion:nil];
    
}
#pragma mark - 消息开关
-(void)switchAction:(UISwitch *)sender{
    if (sender.on) {
        NSLog(@"switch is on");
    }else{
        NSLog(@"switch is off");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:sender.on?@"1":@"0" forKey:@"msgswitch"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark request
#pragma mark 基本信息设置
-(void)requestUserCenter_setinfowithsex:(NSInteger )sex
{
    
    NSDictionary *parameters=@{@"token":USERTOKEN,@"sex":@(sex)};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_setinfo parameters:parameters success:^(id data) {
        
        if ([data[@"code"]integerValue] ==0) {
            sexLab.text=sex?@"女":@"男";
        }
        else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 获取用户信息
-(void)requestuserInfo
{
    NSDictionary *parameters =@{@"token":USERTOKEN};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_getinfo parameters:parameters success:^(id data) {
        if ([data[@"code"]integerValue] ==0) {
            YBUser *user =[YBUser yy_modelWithDictionary:data[@"data"]];
            self.user=user;
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [KVNProgress dismiss];
                [self.tableView reloadData];

            });
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [KVNProgress dismiss];
                [DWBToast showCenterWithText:data[@"msg"]];
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [KVNProgress dismiss];

        });
    }];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self imguploadwithimg:portraitImg];
     [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imguploadwithimg:(UIImage *)image
{
   
    NSDictionary *parameters =@{@"token":USERTOKEN};
  
     [KVNProgress show];
    [[YBRequestManager sharedYBManager].sessionManager POST:[NSString stringWithFormat:@"%@%@",HOST,UserCenter_imgupload] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 0.8);        
//        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imgData



                                    name:@"image"



                                fileName:@"image.png"



                                mimeType:@"image/png"];


    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestuserInfo];
        
        
//        [self requestUserCenter_setinfowithhead_img:responseObject[@"data"][@"head_img"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [KVNProgress dismiss];

    }];
    


    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{//点击弹窗按钮后
    
    if (buttonIndex == 0) {//取消
        
    }else if (buttonIndex == 1){//确定
        
        [self clearCacheClick];
    }
    
}

- (void)clearCacheClick
{
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                // 设置文字
                cacheLab.text = @"0B";
            });
        });
    }];
}




#pragma mark request
#pragma mark
-(void)requestUserCenter_get_zili
{

    NSDictionary *parameters =@{@"token":USERTOKEN};
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_get_zili parameters:parameters success:^(id data) {

        //        [self.dataArr removeAllObjects];
        if ([data[@"code"]integerValue] ==0) {

            if ([data[@"data"][@"is_check"] intValue] ==0) {
                certificationtext= @"未审核";
            }
            else if ([data[@"data"][@"is_check"] intValue] ==1)
            {
                certificationtext= @"审核中";
            }
            else if ([data[@"data"][@"is_check"] intValue] ==2)
            {
                certificationtext= @"审核通过";
            }
            else if ([data[@"data"][@"is_check"] intValue] ==3)
            {
                certificationtext= @"审核未通过";
            }
            [self.tableView reloadData];
        }
        else if ([data[@"code"]integerValue] ==1)
        {
//            [DWBToast showCenterWithText:data[@"msg"]];
        }
        else{
//            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {

    }];
}


@end
