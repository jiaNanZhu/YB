//
//  PublishErrandPoiAddressView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/20.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishErrandPoiAddressView : UIView
@property (nonatomic ,copy)void (^selectedAddressBlock)(NSString *address);
@property (nonatomic ,copy)NSArray *dataArr;
@end
