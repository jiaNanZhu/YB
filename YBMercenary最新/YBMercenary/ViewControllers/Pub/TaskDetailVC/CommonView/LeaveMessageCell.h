//
//  LeaveMessageCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/13.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveMessageCell : BaseTableViewCell
@property (nonatomic ,assign)NSInteger taskId;
@property (nonatomic ,copy)void (^refreshMessageList)(void);
@end
