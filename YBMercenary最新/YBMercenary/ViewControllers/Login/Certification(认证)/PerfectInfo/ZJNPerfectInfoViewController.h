//
//  ZJNPerfectInfoViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface ZJNInfoModel : NSObject
@property (nonatomic ,strong)UIImage *headerImage;
@property (nonatomic ,strong)NSString *imageUrl;
@property (nonatomic ,strong)NSString *age;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *sex;
@property (nonatomic ,strong)NSString *nickName;
@end
@interface ZJNPerfectInfoViewController : BaseViewController
@property (nonatomic ,strong)ZJNInfoModel *infoModel;
@end

NS_ASSUME_NONNULL_END
