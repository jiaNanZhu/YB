//
//  PublishErrandMapViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/20.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishErrandMapViewController : BaseViewController
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,copy)void (^startAddressBlock)(NSString *startAddress);
@property (nonatomic ,copy)void (^endAddressBlock)(NSString *endAddress);
@end
