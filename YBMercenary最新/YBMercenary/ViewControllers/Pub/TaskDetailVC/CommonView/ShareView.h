//
//  ShareView.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShareViewDelegate<NSObject>
-(void)shareViewShareBtnClickWithTag:(NSInteger)tag;
@end
@interface ShareView : UIView
@property (nonatomic ,weak)id<ShareViewDelegate>delegate;
@end
