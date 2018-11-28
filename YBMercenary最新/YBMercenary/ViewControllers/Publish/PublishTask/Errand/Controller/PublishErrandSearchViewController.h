//
//  PublishErrandSearchViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/20.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface PublishErrandSearchViewController : BaseViewController
@property (nonatomic ,copy)void(^selectAddressBlock)(NSString *address);
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,assign)CGFloat latitude;
@property (nonatomic ,assign)CGFloat longitude;
@property (nonatomic ,copy)NSString *searchText;
@end
