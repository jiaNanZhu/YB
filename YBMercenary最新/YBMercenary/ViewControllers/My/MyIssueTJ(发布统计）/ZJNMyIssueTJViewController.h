//
//  ZJNMyIssueTJViewController.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/30.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseViewController.h"
typedef enum :NSInteger{
    ZJNMyIssueTjType = 0,
    ZJNMyAceeptTjType
}ZJNTaskTjType;
@interface ZJNMyIssueTJViewController : BaseViewController
@property (nonatomic ,assign)ZJNTaskTjType taskTjType;
-(id)initWithTaskTyType:(ZJNTaskTjType)type;
@end
