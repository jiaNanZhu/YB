//
//  BMNavigationBar.h
//  BMTNavigationBar
//
//  Created by Jashion on 2017/11/6.
//  Copyright © 2017年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ButtonType) {
    LeftButtonType      =       1,
    RightButtonType     =       1 << 1
};

@interface BMNavigationBar : UIView

@property (nonatomic, assign) ButtonType buttonType;
@property (nonatomic, strong) NSString *title;  //导航栏标题
@property (nonatomic, strong) NSString *btntitle;//item  title
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel  *titleLab; //导航栏标题Label

@property (nonatomic, strong) NSString *imgName;//按钮图片名

//导航栏上的searchBar 是否显示
@property (nonatomic, assign) BOOL isSearch;
@property(nonatomic,strong)UISearchBar*searchBarView;
@property (nonatomic, copy) void(^clickLeftButtonBlock)(UIButton *button);
@property (nonatomic, copy) void(^clickRightButtonBlock)(UIButton *button);

@end
