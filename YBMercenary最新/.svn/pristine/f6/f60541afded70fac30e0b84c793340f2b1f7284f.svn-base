//
//  YBTabBar.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/21.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBTabBar.h"
#import "UIView+Size.h"
#import "UIButton+Edge.h"
#import "ZJNTabBarView.h"
@interface YBTabBar()
@property (nonatomic, strong) ZJNTabBarView *tabBarV;
@end
@implementation YBTabBar
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //  不透明背景
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
//        backView.backgroundColor = [UIColor whiteColor];
//        [self insertSubview:backView atIndex:0];
        self.opaque = YES;
        
        ZJNTabBarView *tabbarView = [[ZJNTabBarView alloc]init];
        [tabbarView.sendBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabbarView];
        self.tabBarV = tabbarView;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    DBLog(@"------哈哈哈哈-------");
    CGFloat w = self.bounds.size.width/5.0;
    self.tabBarV.size = CGSizeMake(w, 70);
    self.tabBarV.centerX = self.width / 2;
    self.tabBarV.centerY = 12;
    
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++)
    {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class])
        {
            view.width = self.width / 5.0;
            view.x = self.width * j / 5.0;
            j++;
            if (j == 2)
            {
                j++;
            }
        }
    }
    
}
// 发布
- (void)didClickPublishBtn:(UIButton*)sender {
    if (self.didMiddBtn) {
        self.didMiddBtn();
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden == NO)
    {
        CGPoint newP = [self convertPoint:point toView:self.tabBarV.sendBtn];
        if ( [self.tabBarV.sendBtn pointInside:newP withEvent:event])
        {
            return self.tabBarV.sendBtn;
        }else
        {
            return [super hitTest:point withEvent:event];
        }
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
