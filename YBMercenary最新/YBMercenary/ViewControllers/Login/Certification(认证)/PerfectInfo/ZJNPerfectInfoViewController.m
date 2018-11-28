//
//  ZJNPerfectInfoViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNPerfectInfoViewController.h"
#import "ZJNTextFieldTableViewCell.h"
#import "ZJNSelectHeaderTableViewCell.h"
#import "ZJNIndividualCertificationViewController.h"

@implementation ZJNInfoModel

@end

@interface ZJNPerfectInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *titleArr;
    NSArray *placeHolderArr;
}
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation ZJNPerfectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善信息";
    self.infoModel = [ZJNInfoModel new];
    titleArr = @[@[@"",@"昵称",@"姓名",@"性别",@"年龄"],@[@"个人实名认证"]];
    placeHolderArr = @[@[@"",@"请输入昵称",@"请输入姓名",@"请选择性别",@"请输入年龄"],@[@""]];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [self tableFooterView];
    }
    return _tableView;
}
-(UIView *)tableFooterView{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, AdFloat(340))];
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundImage:SetImage(@"Rectangle 5") forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview);
        make.top.equalTo(bgview).offset(AdFloat(120));
        make.size.mas_equalTo(CGSizeMake(AdFloat(630), AdFloat(90)));
    }];

    return bgview;
}
#pragma mark-UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return AdFloat(120);
    }
    return AdFloat(90);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *cellid = @"cellID";
        ZJNSelectHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ZJNSelectHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *cellid = @"cellid";
        ZJNTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ZJNTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.textAlignment = NSTextAlignmentRight;
        cell.leftLabel.text = titleArr[indexPath.section][indexPath.row];
        cell.textField.placeholder = placeHolderArr[indexPath.section][indexPath.row];
        if ((indexPath.section == 0 && indexPath.row == 3)||indexPath.section == 1) {
            cell.textField.userInteractionEnabled = NO;
            cell.imgV.hidden = NO;
        }else{
            cell.textField.userInteractionEnabled = YES;
            cell.imgV.hidden = YES;
        }
        __weak typeof(self)weakSelf = self;
        cell.textFieldChangedBlock = ^(NSString * _Nonnull text) {
            ZJNPerfectInfoViewController *strongSelf = weakSelf;
            if (indexPath.section == 0) {
                if (indexPath.row == 1) {
                    strongSelf.infoModel.nickName = text;
                }else if (indexPath.row == 2){
                    strongSelf.infoModel.name = text;
                }else if (indexPath.row == 4){
                    strongSelf.infoModel.age = text;
                }
            }
        };
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //头像
            [self selectHeaderImageView];
        }else if (indexPath.row == 3){
            //性别
            [self selectSex];
        }
    }else{
        //个人认证
        ZJNIndividualCertificationViewController *viewC = [[ZJNIndividualCertificationViewController alloc]init];
        [self.navigationController pushViewController:viewC animated:YES];
    }
}
//选择性别
-(void)selectSex{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.textField.text = @"男";
        self.infoModel.sex = @"0";
    }];
    [manAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.textField.text = @"女";
        self.infoModel.sex = @"1";
    }];
    [womanAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    
    [alertController addAction:manAction];
    [alertController addAction:womanAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
//选择头像
-(void)selectHeaderImageView{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    [showAllInfoAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *pickAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [pickAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [cancelAction setValue:[UIColor hex:@"444444"] forKey:@"_titleTextColor"];
    [actionSheetController addAction:pickAction];
    [actionSheetController addAction:showAllInfoAction];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    ZJNSelectHeaderTableViewCell *cell = (ZJNSelectHeaderTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.headerImgV.image = portraitImg;

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
    [[YBRequestManager sharedYBManager].sessionManager POST:[NSString stringWithFormat:@"%@%@",HOST,UserCenter_singleimgup] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imgData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.infoModel.headerImage = image;
        self.infoModel.imageUrl = responseObject[@"data"][@"imgurl"];
        
        [KVNProgress dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [KVNProgress dismiss];
    }];
}

-(void)submitBtnClick{
    if (self.infoModel.imageUrl.length == 0) {
        [DWBToast showBottomWithText:@"请选择头像"];
        return;
    }
    if (self.infoModel.nickName.length == 0) {
        [DWBToast showBottomWithText:@"请输入昵称"];
        return;
    }
    if (![Utile isName:self.infoModel.nickName]) {
        [DWBToast showCenterWithText:@"请输入4-20个字符"];
        return;
    }
    if (self.infoModel.name.length == 0) {
        [DWBToast showCenterWithText:@"请输入姓名"];
        return;
    }
    if (self.infoModel.sex.length == 0) {
        [DWBToast showCenterWithText:@"请选择性别"];
        return;
    }
    if (self.infoModel.age.length == 0) {
        [DWBToast showCenterWithText:@"请输入年龄"];
        return;
    }
    NSArray *keyArr = @[@"token",@"head_img",@"nick_name",@"name",@"sex",@"age"];
    NSArray *valueArr = @[USERTOKEN,self.infoModel.imageUrl,self.infoModel.nickName,self.infoModel.name,self.infoModel.sex,self.infoModel.age];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArr forKeys:keyArr];
    [[YBRequestManager sharedYBManager] postWithUrlString:UserCenter_setinfo parameters:dic success:^(id data) {
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            [DWBToast showCenterWithText:@"完善信息成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:PREFECTINFO];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        [DWBToast showCenterWithText:@"完善信息失败"];
    }];
    
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
