//
//  UITableView+ShowHind.m
//  OverseasRealEstateProject
//
//  Created by 险峰科技 on 2018/6/22.
//  Copyright © 2018年 XianFeng. All rights reserved.
//

#import "UITableView+ShowHind.h"

@implementation UITableView (ShowHind)
-(void)showHind{
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    UILabel *label = [[UILabel alloc]init];
    label.tag = 10;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = SetFont(AdFloat(28));
    label.text = @"暂无数据";
    label.textColor = [UIColor hex:@"666666"];
    [backV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backV);
        make.height.mas_equalTo(AdFloat(40));
        make.center.equalTo(backV);
    }];
    self.backgroundView = backV;
}
-(void)hideHind{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.backgroundView = whiteView;
}
@end
