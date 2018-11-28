//
//  ZJNTextFieldTableViewCell.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZJNTextFieldTableViewCellDelegate <NSObject>

-(void)showInfoWithText:(NSString *)text;

@end
@interface ZJNTextFieldTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *leftLabel;
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UIImageView *imgV;
@property (nonatomic ,copy)void (^textFieldChangedBlock)(NSString *text);
//验证银行卡号
@property (nonatomic ,copy)void (^verifyBankBlock)(NSString *bankName);

@property (nonatomic ,weak)id<ZJNTextFieldTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
