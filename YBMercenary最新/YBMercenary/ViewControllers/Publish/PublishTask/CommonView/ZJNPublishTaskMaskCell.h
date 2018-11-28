//
//  ZJNPublishTaskMaskCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZJNPublishTaskMaskCellDelegate<NSObject>
- (void)zjnReloadeViewWithLineCount:(NSInteger)count;
@end
@interface ZJNPublishTaskMaskCell : UITableViewCell
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, assign) NSInteger linecount;
@property(nonatomic, copy) void (^publishTaskMaskBlock)(NSArray *mask);
@property (nonatomic, weak) id<ZJNPublishTaskMaskCellDelegate> delegate;

+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;
@end
