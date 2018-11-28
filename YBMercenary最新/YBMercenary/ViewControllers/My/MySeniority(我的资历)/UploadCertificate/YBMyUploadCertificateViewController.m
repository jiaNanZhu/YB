//
//  YBMyUploadCertificateViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/5/7.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMyUploadCertificateViewController.h"

@interface YBMyUploadCertificateViewController ()
{
    UIView *imgBack;
    UIImageView *idcardImg;
    
}
@end

@implementation YBMyUploadCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
    [self nav];
}
#pragma mark - NAV
-(void)nav{
    UIButton *rightBtn = [F_UI SL_UI_Btn:@"提交" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(rightBtn) cornerRadius:0];
    rightBtn.frame = CGRectMake(0, 0, AdFloat(80), AdFloat(30));
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)makeUI{
    
    UIView *backView = [F_UI SL_UI_View:[UIColor whiteColor] cornerRadius:0 borderColor:nil borderWidth:0];
    backView.frame = CGRectMake(0, AdFloat(16), d_Device_width, AdFloat(480));
    [self.view addSubview:backView];
    
    UILabel *lab = [F_UI SL_UI_Label:@"上传证书" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
    lab.frame = CGRectMake(AdFloat(30), AdFloat(24), AdFloat(300), AdFloat(40));
    [backView addSubview:lab];
    
    UIView *imgBack = [F_UI SL_UI_View:[UIColor hex:@"EDEDED"] cornerRadius:0 borderColor:nil borderWidth:0];
    imgBack.frame = CGRectMake(AdFloat(40), lab.maxY+AdFloat(26), d_Device_width-AdFloat(80), AdFloat(360));
    [backView addSubview:imgBack];
    
    UIImageView *picIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"上传图片"] cornerRadius:0];
    picIMG.frame = CGRectMake(AdFloat(290), AdFloat(116), AdFloat(90), AdFloat(80));
    [imgBack addSubview:picIMG];
    
    
    UIButton *uploadBtn = [F_UI SL_UI_Btn:@"上传" Color:[UIColor whiteColor] Font:AdFloat(32) bgimage:nil selecteImage:nil target:self action:@selector(uploadBtn) cornerRadius:AdFloat(45)];
    uploadBtn.frame = CGRectMake(AdFloat(60),backView.maxY+AdFloat(60), d_Device_width-AdFloat(120), AdFloat(90));
    [uploadBtn setBackgroundColor:[UIColor hex:@"0386FF"]];
    [self.view addSubview:uploadBtn];
    
    
    idcardImg= [[UIImageView alloc]init];
    idcardImg.frame=CGRectMake(AdFloat(40), lab.maxY+AdFloat(26), d_Device_width-AdFloat(80), AdFloat(360));
    [backView addSubview:idcardImg];
    
}

-(void)uploadBtn{
    
    [self photographBtn];
}
-(void)rightBtn
{
    if (idcardImg.image == nil) {
       [DWBToast showCenterWithText:@"请选择证书上传"];
    }
    else{
      [self imguploadwithimg:idcardImg.image];
    }
    
}


-(void)photographBtn{
    
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //    picker.allowsEditing = YES;
    
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    idcardImg.image=portraitImg;
    imgBack.hidden=YES;
    
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
        //        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imgData
         
         
         
                                    name:@"image"
         
         
         
                                fileName:@"image.png"
         
         
         
                                mimeType:@"image/png"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        imgurlStr =responseObject[@"data"][@"imgurl"];
        
        idcardImg.image=image;
        imgBack.hidden=YES;
        
        [self requestUserCenter_set_zili:responseObject[@"data"][@"imgurl"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [KVNProgress dismiss];
        
    }];
    
    
    
    
}
#pragma mark request
#pragma mark
-(void)requestUserCenter_set_zili:(NSString *)imgurlstr
{
   
    NSDictionary *parameters=@{@"token":USERTOKEN,@"certificate":imgurlstr};
  
    [[YBRequestManager sharedYBManager]postWithUrlString:UserCenter_set_zili parameters:parameters success:^(id data) {
        
        
        //        [self.dataArr removeAllObjects];
        if ([data[@"code"]integerValue] ==0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [DWBToast showCenterWithText:@"上传成功"];
                [KVNProgress dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
            
        }
        else if ([data[@"code"]integerValue] ==1)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [KVNProgress dismiss];
                [DWBToast showCenterWithText:data[@"msg"]];
                
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
