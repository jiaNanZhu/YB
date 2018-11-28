//
//  TaskMarkView.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskMarkView : UIView
@property (nonatomic, copy)void (^deleteMarkBlock)(NSString *mark);
@property (nonatomic, strong) NSArray *markArr;

- (void)startDelete;

- (void)stopDelete;

@end
