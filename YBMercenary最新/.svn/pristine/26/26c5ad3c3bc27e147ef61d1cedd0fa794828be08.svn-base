//
//  YBMessageSearchViewController.h
//  YBMercenary
//
//  Created by JW on 2018/7/25.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBMessagModel.h"
@protocol YBMessageSearchViewControllerDelegate <NSObject>
-(void)scrollToRowAtIndexPath:(NSString *)keyWord;
@end

@interface YBMessageSearchViewController : UIViewController
@property(nonatomic,strong)NSString *targetId;

@property(nonatomic,weak)id<YBMessageSearchViewControllerDelegate>delegate;


@property(nonatomic,strong)YBMessagModel*model;
@end
