//
//  ZJNIndividualCertificationViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNIndividualCertificationViewController.h"
#import "ZJNTextFieldTableViewCell.h"
#import "ZJNPhotoTableViewCell.h"
#import "ZJNSelectBankView.h"
#import "ZJNSelectAreaView.h"
#import "ZJNIndividualModel.h"
@interface ZJNIndividualCertificationViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZJNTextFieldTableViewCellDelegate>{
    NSArray *titleArray;
    NSArray *placeHolderArr;
    NSArray *photoTitleArr;
    NSArray *photoPHArr;
    NSIndexPath *signIndexPath;//选照片时记录照片类型
}
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)ZJNSelectBankView *bankView;
@property (nonatomic ,strong)ZJNIndividualModel *individualModel;
@end

@implementation ZJNIndividualCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _individualModel = [[ZJNIndividualModel alloc]init];
    self.title = @"个人实名认证";
    titleArray = @[@[@"姓名",@"身份证"],@[@"开户地区",@"银行卡号",@"开户行"],@[@"联系人姓名",@"联系人手机"]];
    placeHolderArr = @[@[@"请输入您的姓名",@"请输入身份证号"],@[@"请选择开户地区",@"请输入银行卡号",@"银行卡开户行"],@[@"请输入紧急联系人姓名",@"请输入紧急联系人的手机号码"]];
    photoTitleArr = @[@"上传身份证照片",@"上传银行卡照片",@"手持身份证照片"];
    photoPHArr = @[@[@"请上传身份证正面照",@"请上传身份证反面照"],@[@"请上传银行卡正面照"],@[@"请上传手持身份证照"]];
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
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
-(ZJNSelectBankView *)bankView{
    if (!_bankView) {
        _bankView = [[ZJNSelectBankView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self)weakSelf = self;
        _bankView.selectBankBlock = ^(NSString * _Nonnull text) {
            ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
            cell.textField.text = text;
            weakSelf.individualModel.khh = text;
        };
    }
    return _bankView;
}
#pragma mark-UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 2 || section == 3) {
        return 2;
    }else if (section == 1){
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        return AdFloat(90);
    }else{
        return AdFloat(380);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3 || section == 4 || section == 5) {
        return AdFloat(90);
    }else if (section == 0){
        return AdFloat(20);
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AdFloat(16);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3 || section == 4 || section == 5) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = SetFont(AdFloat(28));
        titleLabel.textColor = [UIColor hex:@"444444"];
        titleLabel.text = photoTitleArr[section-3];
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
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        static NSString *cellid = @"cellid";
        ZJNTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ZJNTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1 && (indexPath.row == 0||indexPath.row == 2)) {
            cell.imgV.hidden = NO;
            cell.textField.userInteractionEnabled = NO;
        }else{
            cell.imgV.hidden = YES;
            cell.textField.userInteractionEnabled = YES;
        }
        
        if ((indexPath.section == 0 && indexPath.row == 1) || (indexPath.section == 2 && indexPath.row == 1)) {
            cell.textField.keyboardType = UIKeyboardTypePhonePad;
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            cell.textField.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        
        cell.leftLabel.text = titleArray[indexPath.section][indexPath.row];
        cell.textField.placeholder = placeHolderArr[indexPath.section][indexPath.row];
        __weak typeof(self)weakSelf = self;
        cell.verifyBankBlock = ^(NSString * _Nonnull bankName) {
            ZJNIndividualCertificationViewController *strongSelf = weakSelf;
            strongSelf.individualModel.khh = bankName;
            ZJNTextFieldTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
            cell.textField.text = bankName;
        };
        cell.textFieldChangedBlock = ^(NSString * _Nonnull text) {
            ZJNIndividualCertificationViewController *strongSelf = weakSelf;
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    strongSelf.individualModel.name = text;
                }else{
                    strongSelf.individualModel.idCard = text;
                }
            }else if (indexPath.section == 1){
                if (indexPath.row == 1) {
                    strongSelf.individualModel.bankCard = text;
                }
            }else{
                if (indexPath.row == 0) {
                    strongSelf.individualModel.linkName = text;
                }else{
                    strongSelf.individualModel.linePhone = text;
                }
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
        cell.centerLabel.text = photoPHArr[indexPath.section-3][indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5) {
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
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NSLog(@"选择银行卡开户地区");
            ZJNSelectAreaView *areaView = [[ZJNSelectAreaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            __weak typeof(self)weakSelf = self;
            areaView.selectAreaBlock = ^(NSString * _Nonnull text) {
                ZJNTextFieldTableViewCell *cell = (ZJNTextFieldTableViewCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                
                NSArray *strArr = [text componentsSeparatedByString:@":"];
                NSString *province = strArr[0];
                
                weakSelf.individualModel.khProvince = [province stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSString *city = strArr[1];
                weakSelf.individualModel.khCity = [city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                cell.textField.text = [strArr componentsJoinedByString:@" "];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:areaView];
        }else if (indexPath.row == 2){
            NSLog(@"选择银行卡开户行");
            [[UIApplication sharedApplication].keyWindow addSubview:self.bankView];
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
        NSData *imgData = [Utile reSizeImageData:image maxImageSize:800 maxSizeWithKB:512.0];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imgData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (signIndexPath.section == 3) {
            if (signIndexPath.row == 0) {
                self.individualModel.idCardA = responseObject[@"data"][@"imgurl"];
            }else{
                self.individualModel.idCardB = responseObject[@"data"][@"imgurl"];
            }
        }else if (signIndexPath.section == 4){
            self.individualModel.bankCardPhoto = responseObject[@"data"][@"imgurl"];
        }else{
            self.individualModel.scIdCard = responseObject[@"data"][@"imgurl"];
        }
        [KVNProgress dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [KVNProgress dismiss];
    }];
}
-(void)submitBtnClick{
    if (self.individualModel.name.length == 0) {
        [DWBToast showCenterWithText:@"请输入您的姓名"];
        return;
    }
    if (self.individualModel.idCard.length == 0) {
        [DWBToast showCenterWithText:@"请输入身份证号"];
        return;
    }
    if (self.individualModel.khProvince.length == 0) {
        [DWBToast showCenterWithText:@"请选择开户地区"];
        return;
    }
    if (self.individualModel.khh.length == 0) {
        [DWBToast showCenterWithText:@"请选择银行卡开户行"];
        return;
    }
    if (self.individualModel.bankCard.length == 0) {
        [DWBToast showCenterWithText:@"请输入银行卡号"];
        return;
    }
    if (self.individualModel.linkName.length == 0) {
        [DWBToast showCenterWithText:@"请输入紧急联系人姓名"];
        return;
    }
    if (self.individualModel.linePhone.length == 0) {
        [DWBToast showCenterWithText:@"请输入紧急联系人的手机"];
        return;
    }
    if (self.individualModel.idCardA.length == 0) {
        [DWBToast showCenterWithText:@"请上传身份证正面照"];
        return;
    }
    if (self.individualModel.idCardB.length == 0) {
        [DWBToast showCenterWithText:@"请上传身份证反面照"];
        return;
    }
    if (self.individualModel.bankCardPhoto.length == 0) {
        [DWBToast showCenterWithText:@"请上传银行卡正面照"];
        return;
    }
    if (self.individualModel.scIdCard.length == 0) {
        [DWBToast showCenterWithText:@"请上传手持身份证照"];
        return;
    }
    
    NSArray *keyArr = @[@"token",@"name",@"id_card",@"province",@"city",@"yh_khh",@"yh_card",@"lianxi_name",@"lianxi_mobile",@"identity_front",@"identity_behind",@"yh_img",@"shouchi_img",@"yh_name"];
    NSArray *valueArr = @[USERTOKEN,self.individualModel.name,self.individualModel.idCard,self.individualModel.khProvince,self.individualModel.khCity,self.individualModel.khh,self.individualModel.bankCard,self.individualModel.linkName,self.individualModel.linePhone,self.individualModel.idCardA,self.individualModel.idCardB,self.individualModel.bankCardPhoto,self.individualModel.scIdCard,self.individualModel.name];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArr forKeys:keyArr];
    [KVNProgress show];
    [[YBRequestManager sharedYBManager] postWithUrlString:NewRegister parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            [DWBToast showCenterWithText:@"认证信息已提交审核"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showInfoWithText:data[@"msg"]];
        }
        [KVNProgress dismiss];
    } failure:^(NSError *error) {
        [self showInfoWithText:@"连接服务器失败"];
        [KVNProgress dismiss];
    }];
}

-(void)showInfoWithText:(NSString *)text{
    [DWBToast showCenterWithText:text duration:2];
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
