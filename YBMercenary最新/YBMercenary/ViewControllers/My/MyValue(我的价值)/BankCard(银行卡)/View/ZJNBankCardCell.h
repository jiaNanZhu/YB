//
//  ZJNBankCardCell.h
//  YBMercenary
//
//  Created by JW on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNBankCardCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *typeLab;
@property(nonatomic,strong)UILabel *cardNumLab;

@property(nonatomic,strong)UIButton *delegateBtn;
@end
