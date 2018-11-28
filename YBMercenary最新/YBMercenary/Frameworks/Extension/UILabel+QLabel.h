//
//  UILabel+QLabel.h
//  ZoneDome
//
//  Created by 龙青磊 on 2018/2/24.
//  Copyright © 2018年 龙青磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZoneTextModel : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) NSRange range;

@end

@interface UILabel (QLabel)

///是否显示点击效果，默认是打开
@property (nonatomic, assign) BOOL isShowTagEffect;

///TagArray  点击的字符串数组
- (void)onTapRangeActionWithString:(NSArray <NSString *> *)TagArray tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

@end
