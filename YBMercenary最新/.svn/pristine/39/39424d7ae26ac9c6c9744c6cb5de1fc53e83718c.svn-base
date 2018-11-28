//
//  TypeItemCell.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol TypeItemCellDelegate<NSObject>

- (void)reloadWihtHeight:(CGFloat)height;

-(void)didSelectItemAtIndexPath:(NSInteger )selectIndex  tagName:(NSString *)tagName;
@end

@interface TypeItemCell : BaseTableViewCell

@property (nonatomic, weak) id<TypeItemCellDelegate> delegate;

@property(nonatomic, assign) NSInteger typeID;

@end
