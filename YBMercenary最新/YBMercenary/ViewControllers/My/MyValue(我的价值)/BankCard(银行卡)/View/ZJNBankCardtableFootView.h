//
//  ZJNBankCardtableFootView.h
//  YBMercenary
//
//  Created by JW on 2018/8/2.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZJNBankCardtableFootViewDelegate <NSObject>

- (void)addcard;
@end;

@interface ZJNBankCardtableFootView : UIView

@property(weak ,nonatomic)id  <ZJNBankCardtableFootViewDelegate>delegate;
@property(nonatomic,strong)UIButton *btn;
@end
