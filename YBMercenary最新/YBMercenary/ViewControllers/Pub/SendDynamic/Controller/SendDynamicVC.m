//
//  SendDynamicVC.m
//  Ranch
//
//  Created by 龙青磊 on 2018/3/8.
//  Copyright © 2018年 xfkeji_Ranch. All rights reserved.
//

#import "SendDynamicVC.h"
#import "AddDynamicImageCell.h"
#import "PhotosNavigationController.h"

#define ImageWidth (kScreenWidth - Width(70)) / 4

@interface SendDynamicVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PhotosNavigationControllerDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageList;

@end

@implementation SendDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageList = [NSMutableArray array];
    [self configNav];
    [self creatSubViews];
    
}

- (void)configNav{
    self.navigationItem.title = @"发帖子";
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"发布" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(sendMethod) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)creatSubViews{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Width(5));
        make.right.equalTo(self.view.mas_right).offset(-Width(5));
        make.top.equalTo(self.view).offset(Width(10));
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = [UIColor hex:@"444444"];
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView).offset(Width(15));
        make.right.equalTo(backView.mas_right).offset(-Width(15));
        make.height.mas_equalTo(Width(150));
    }];
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.text = @"请输入帖子内容";
    _tipLabel.textColor = [UIColor hex:@"666666"];
    _tipLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView).offset(Width(8));
        make.left.equalTo(_textView).offset(Width(8));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(ImageWidth, ImageWidth);
    layout.minimumInteritemSpacing = Width(10);//单元格之间的横间隙
    layout.minimumLineSpacing = Width(10);//单元格之间的纵间隙
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[AddDynamicImageCell class] forCellWithReuseIdentifier:@"AddDynamicImageCell"];
    _collectionView.collectionViewLayout = layout;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_textView);
        make.top.equalTo(_textView.mas_bottom).offset(Width(15));
        make.height.mas_equalTo(ImageWidth);
        make.bottom.equalTo(backView.mas_bottom).offset(-Width(15));
    }];
}

- (void)configCollectionView{
    if (self.imageList.count >= 9) {
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(ImageWidth*3 + Width(20));
        }];
    }else{
        NSInteger excess = (self.imageList.count + 1) % 4;
        NSInteger line = (self.imageList.count + 1) / 4;
        if (excess == 0) {
            [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(ImageWidth*(line) + Width(10) * (line - 1));
            }];
        }else{
            [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(ImageWidth*(line+1) + Width(10) * line);
            }];
        }
    }
    [self.view updateConstraints];
    [self.view layoutIfNeeded];
    [KVNProgress dismiss];
    [self.collectionView reloadData];
}


#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.imageList.count == 9) {
        return 9;
    }else{
        return self.imageList.count + 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddDynamicImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddDynamicImageCell" forIndexPath:indexPath];
    if(indexPath.row +1== self.imageList.count+1){
        //        cell.imageString = @"方图片3";
        cell.zoneImageView.image= [UIImage imageNamed:@"添加图片"];
        cell.deleteBtn.hidden=YES;
    }
    else{
        cell.zoneImageView.image=self.imageList[indexPath.row];
        cell.deleteBtn.hidden=NO;
    }
    cell.deleteimg = ^{
        
        [self.imageList removeObjectAtIndex:indexPath.row];
        [self configCollectionView];
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.row == self.imageList.count) {
        [self chosephoto];
    }
}

// 调整单元格与父视图边界的相对位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark  发布方法
- (void)sendMethod{
    
    
    [self uploadIMG];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
//    KWeakSelf(self);
//    [KVNProgress show];
//    [[UserHelper shareInstance] sendDynamicWithContent:self.textView.text images:[CLTools dataToJsondString:self.imageList] finish:^(BOOL result, id data) {
//        if (result) {
//            [DWBToast showCenterWithText:data];
//            [weakself.navigationController popToRootViewControllerAnimated:YES];
//        }
//    }];
}

#pragma mark  UITextDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        _tipLabel.hidden = NO;
    }else{
        _tipLabel.hidden = YES;
    }
}

- (void)chosephoto{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DWBToast showCenterWithText:@"开启相机"];
        [self showCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showAlbum];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cameraAction];
    [alertVC addAction:albumAction];
    [alertVC addAction:cancle];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)showCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = NO;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
//    [self.images addObject:image];
//    [self reloadTableView];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    self.footView.frame = CGRectMake(0, 0, kScreenWidth, 130);
//    self.sumitBtn.hidden = NO;
//    [self reloadTableView];
}

- (void)showAlbum{
    PhotosNavigationController *navigation = [[PhotosNavigationController alloc] initWithChoseSingle:NO maxImagesCount:(9 - self.imageList.count) delegate:self];
    // 在这里设置imagePickerVc的外观
    navigation.navigationBar.barTintColor = [UIColor hex:Blue_Color];
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 用户点击了取消
- (void)PhotosNavigationControllerDidCancel:(PhotosNavigationController *)picker {
    
}

- (void)PhotosNavigationController:(PhotosNavigationController *)navigation didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets{
    KWeakSelf(self);
    NSArray *imagelist = [photos copy];
    [KVNProgress show];
    for (UIImage *image in imagelist) {
//        NSData *data = UIImageJPEGRepresentation(image, 0.2f);
//        [[UserHelper shareInstance] uploadingImageWithData:data path:@"users" finish:^(BOOL result, id data) {
//            if (result) {
//                [weakself.imageList addObject:data];
//                [weakself configCollectionView];
//            }
//        }];
        [weakself.imageList addObject:image];
    }
    [weakself configCollectionView];
}

- (void)deleteImageWithIndex:(NSInteger)index{

}


- (void)sumitImages{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uploadIMG
{
    
    [KVNProgress show];
    [[YBRequestManager sharedYBManager] postWithUrlString:ImageUpload parameters:@{@"token":USERTOKEN} images:self.imageList success:^(id data) {
        DBLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"0"]) {
            
            
            NSArray *arr= data[@"data"];//[data[@"data"][@"imgurl"] componentsSeparatedByString:@"|"];
            
            NSString *imgs =nil;
            for (NSDictionary *dict in arr) {
                
                
                if (!imgs) {
                    imgs=  [NSString stringWithFormat:@"%@",dict[@"post"]];
                }
                else{
                    imgs=  [NSString stringWithFormat:@"%@|%@",imgs,dict[@"post"]];
                }
              
            }
           
            
            [self  requestCommonDrunkery_post_addwithpost_img:imgs];
            
            
        }else{
            [KVNProgress dismiss];
            [DWBToast showCenterWithText:data[@"msg"]];
        }
    } failure:^(NSError *error) {
        DBLog(@"%@",error);
        [KVNProgress dismiss];
        [DWBToast showCenterWithText:ErrorInfo];
    }];
}
#pragma mark request
#pragma mark
-(void)requestCommonDrunkery_post_addwithpost_img:(NSString *)post_img
{
    
    NSDictionary *parameters =@{@"token":USERTOKEN,@"task_type":@(self.task_type),@"task_type_child":@(self.task_type_child),@"post_content":_textView.text,@"post_img":post_img};
    [[YBRequestManager sharedYBManager]postWithUrlString:CommonDrunkery_post_add parameters:parameters success:^(id data) {

        if ([data[@"code"]integerValue] ==0) {


            dispatch_async(dispatch_get_main_queue(), ^{
                [DWBToast showCenterWithText:@"发布成功"];
                [KVNProgress dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }
        else{
            
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [DWBToast showCenterWithText:data[@"msg"]];
                [KVNProgress dismiss];
            });
            
        }
    } failure:^(NSError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [KVNProgress dismiss];
        });
    }];
    
}
@end
