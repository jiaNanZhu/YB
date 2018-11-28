//
//  ErrandTimeCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ErrandTimeCellDelegate<NSObject>
-(void)didSelectRowwithtext:(NSString *)text index:(NSInteger)index;

- (void)ErrandTimeCelltextFieldDidEndEditing:(NSString *)str;

@end

@interface ErrandTimeCell : UITableViewCell
@property (nonatomic ,weak)id<ErrandTimeCellDelegate>delegate;
@property (nonatomic, strong) UILabel *arriveLabel;
@property (nonatomic, strong) UILabel *validLabel;

@property (nonatomic, strong) UITextField *validTextField;
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;

@end
