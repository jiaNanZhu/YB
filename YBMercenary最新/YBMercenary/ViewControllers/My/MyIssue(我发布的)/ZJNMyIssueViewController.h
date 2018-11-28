//
//  ZJNMyIssueViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/27.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"

@interface ZJNMyIssueViewController : BaseViewController
@property (nonatomic ,assign)NSInteger type;
-(void)getDataFromServiceWithPara:(NSDictionary *)dic urlStr:(NSString *)url successfulToast:(NSString *)toast;
@end
