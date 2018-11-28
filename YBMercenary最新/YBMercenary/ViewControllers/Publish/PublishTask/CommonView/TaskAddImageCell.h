//
//  TaskAddImageCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskAddImageCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageString;
@property (nonatomic, strong) UIImageView *zoneImageView;
@property (nonatomic, strong) UIButton *deleteBtn;

@property (copy, nonatomic) void (^deleteimg)(void);
@end
