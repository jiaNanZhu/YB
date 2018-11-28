//
//  ZJNCompanyCertificationViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNCompanyCertificationViewController.h"
#import "ZJNTextFieldTableViewCell.h"
#import "ZJNPhotoTableViewCell.h"
#import "ZJNSelectBankView.h"
#import "ZJNSelectAreaView.h"
#import "ZJNCompanyModel.h"
@interface ZJNCompanyCertificationViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *titleArray;
    NSArray *placeHolderArr;
    NSArray *photoTitleArr;
    NSArray *photoPHArr;
    NSIndexPath *signIndexPath;//选照片时记录照片类型
}
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)ZJNCompanyModel *companyModel;
@end

@implementation ZJNCompanyCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业实名认证";
    self.companyModel = [[ZJNCompanyModel alloc]init];
    titleArray = @[@"姓名",@"开户地区",@"身份证号",@"联系人姓名",@"联系人手机",@"开户名",@"银行卡号",@"开户行",@"分帐方地区",@"营业执照号",@"企业名称",@"法人"];
    placeHolderArr = @[@"请输入您的姓名",@"请选择开户省份和城市",@"请输入法人身份证号",@"请输入联系人姓名",@"请输入联系人手机号",@"请输入银行卡开户名",@"请输入银行卡号",@"请选择银行卡开户行",@"请选择分帐方省份和城市",@"请输入营业执照号",@"请输入企业名称",@"请输入法人名称"];
    photoTitleArr = @[@"上传法人身份证照片",@"上传营业执照",@"组织机构代码证",@"银行开户许可证",@"税务登记证"];
    photoPHArr = @[@[@"请上传身份证正面照",@"请上传身份证反面照"],@[@"请上传营业执照"],@[@"请上传组织结构代码证"],@[@"请上传银行开户许可证"],@[@"请上传税务登记"]];

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
    [bgview addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview);
        make.top.equalTo(bgview).offset(AdFloat(120));
        make.size.mas_equalTo(CGSizeMake(AdFloat(630), AdFloat(90)));
    }];
    UILabel *warringLabel = [[UILabel alloc]init];
    warringLabel.textColor = [UIColor hex:@"999999"];
    warringLabel.font = SetFont(AdFloat(28));
    warringLabel.text = @"注：以上信息都为必填项";
    [bgview addSubview:warringLabel];
    [warringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview);
        make.top.equalTo(submitBtn.mas_bottom).offset(AdFloat(16));
    }];
    return bgview;
}
#pragma mark-UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }else if (section == 1){
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return AdFloat(90);
    }else{
        return AdFloat(380);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return AdFloat(20);
    }else{
        return AdFloat(90);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AdFloat(16);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = SetFont(AdFloat(28));
        titleLabel.textColor = [UIColor hex:@"444444"];
        titleLabel.text = photoTitleArr[section-1];
        [bgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(AdFloat(40));
            make.centerY.equalTo(bgView);
        }];
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(bgView);
            make.height.mas_equalTo(1);
            make.top.equalTo(bgView.mas_bottom);
        }];
        return bgView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellid = @"cellid";
        ZJNTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ZJNTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1||indexPath.row == 7 || indexPath.row == 8) {
            cell.imgV.hidden = NO;
            cell.textField.userInteractionEnabled = NO;
        }else{
            cell.imgV.hidden = YES;
            cell.textField.userInteractionEnabled = YES;
        }
        cell.leftLabel.text = titleArray[indexPath.row];
        cell.textField.placeholder = placeHolderArr[indexPath.row];
        __weak typeof(self) weakSelf = self;
        cell.textFieldChangedBlock = ^(NSString * _Nonnull text) {
            if (indexPath.row == 0) {
                weakSelf.companyModel.name = text;
            }else if (indexPath.row == 2){
                weakSelf.companyModel.idCard = text;
            }else if (indexPath.row == 3){
                weakSelf.companyModel.linkName = text;
            }else if (indexPath.row == 4){
                weakSelf.companyModel.linePhone = text;
            }else if (indexPath.row == 5){
                weakSelf.companyModel.kfName = text;
            }else if (indexPath.row == 6){
                weakSelf.companyModel.bankCard = text;
            }else if (indexPath.row == 9){
                weakSelf.companyModel.yyzz = text;
            }else if (indexPath.row == 10){
                weakSelf.companyModel.company = text;
            }else if (indexPath.row == 11){
                weakSelf.companyModel.legalPerson = text;
            }
        };
        return cell;
    }else{
        static NSString *cellid = @"cellID";
        ZJNPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ZJNPhotoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.centerLabel.text = photoPHArr[indexPath.section-1][indexPath.row];
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.coverImageView.image = self.companyModel.idCardAImg;
            }else{
                cell.coverImageView.image = self.companyModel.idCardBImg;
            }
        }else if (indexPath.section == 3){
            cell.coverImageView.image = self.companyModel.yyzzImg;
        }else if (indexPath.section == 4){
            cell.coverImageView.image = self.companyModel.zzjgImg;
        }else if (indexPath.section == 5){
            cell.coverImageView.image = self.companyModel.yhkkhImg;
        }else if (indexPath.section == 6){
            cell.coverImageView.image = self.companyModel.swdjImg;
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        signIndexPath = indexPath;
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
        
    }else if (indexPath.section == 0){
        if (indexPath.row == 1) {
            NSLog(@"选择开户省份和城市");
            ZJNSelectAreaView *areaView = [[ZJNSelectAreaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            __weak typeof(self) weakSelf = self;
            areaView.selectAreaBlock = ^(NSString * _Nonnull text) {
                ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                cell.textField.text = text;
                weakSelf.companyModel.khArea = text;
            };
            [[UIApplication sharedApplication].keyWindow addSubview:areaView];
        }else if (indexPath.row == 7){
            NSLog(@"选择银行卡开户行");
            ZJNSelectBankView *bankView = [[ZJNSelectBankView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            __weak typeof(self)weakSelf = self;
            bankView.selectBankBlock = ^(NSString * _Nonnull text) {
                ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                cell.textField.text = text;
                weakSelf.companyModel.khh = text;
            };
            [[UIApplication sharedApplication].keyWindow addSubview:bankView];
            
        }else if (indexPath.row == 8){
            NSLog(@"请选择分帐方省份和城市");
            ZJNSelectAreaView *areaView = [[ZJNSelectAreaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            __weak typeof(self) weakSelf = self;
            areaView.selectAreaBlock = ^(NSString * _Nonnull text) {
                ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                cell.textField.text = text;
                weakSelf.companyModel.fzfArea = text;
            };
            [[UIApplication sharedApplication].keyWindow addSubview:areaView];
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    ZJNPhotoTableViewCell *cell = (ZJNPhotoTableViewCell *)[self.tableView cellForRowAtIndexPath:signIndexPath];
    cell.coverImageView.image = portraitImg;
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
        NSLog(@"%@",responseObject);
        if (signIndexPath.section == 2) {
            if (signIndexPath.row == 0) {
                self.companyModel.idCardA = responseObject[@"data"][@"imgurl"];
                self.companyModel.idCardAImg = image;
            }else{
                self.companyModel.idCardB = responseObject[@"data"][@"imgurl"];
                self.companyModel.idCardBImg = image;
            }
        }else if (signIndexPath.section == 3){
            self.companyModel.yyzz = responseObject[@"data"][@"imgurl"];
            self.companyModel.yyzzImg = image;
        }else if (signIndexPath.section == 4){
            self.companyModel.zzjg = responseObject[@"data"][@"imgurl"];
            self.companyModel.zzjgImg = image;
        }else if (signIndexPath.section == 5){
            self.companyModel.yhkkh = responseObject[@"data"][@"imgurl"];
            self.companyModel.yhkkhImg = image;
        }else if (signIndexPath.section == 6){
            self.companyModel.swdj = responseObject[@"data"][@"imgurl"];
            self.companyModel.swdjImg = image;
        }
        [KVNProgress dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [KVNProgress dismiss];
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
