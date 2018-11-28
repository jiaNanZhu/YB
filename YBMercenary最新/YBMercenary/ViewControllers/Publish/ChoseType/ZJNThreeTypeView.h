//
//  ZJNThreeTypeView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZJNThreeTypeViewDelegate<NSObject>
-(void)zjnThreeTypeViewButtonSelectedWithTag:(NSInteger)tag;
@end
@interface ZJNThreeTypeView : UIView
@property (nonatomic ,strong)NSArray *infoArr;
@property (nonatomic ,weak)id<ZJNThreeTypeViewDelegate>delegate;
@end
