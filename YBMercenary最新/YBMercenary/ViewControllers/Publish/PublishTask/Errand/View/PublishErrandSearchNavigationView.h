//
//  PublishErrandSearchNavigationView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/21.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishErrandSearchNavigationView : UIView
@property (nonatomic ,copy)void (^searchTextBlock)(NSString *text);
@end
