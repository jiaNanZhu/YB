//
//  ErrandAdressCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrandAdressCellDelegate<NSObject>
@optional
-(void)ErrandAdressCelldidSelectRowwithtext:(NSString *)text index:(NSInteger)index;
-(void)errandAddressCellSelectStardAddress;
-(void)errandAddressCellSelectEndAddress;
-(void)errandAddressCellDeleteStartAddress;
@end


@interface ErrandAdressCell : UITableViewCell
@property (nonatomic ,weak)id<ErrandAdressCellDelegate>delegate;
@property (nonatomic, strong) UILabel *beginLabel;
@property (nonatomic, strong) UILabel *goalLabel;
+ (instancetype)creatTableViewCellWithTableView:(UITableView *)tableView;


@end
