//
//  TaskAddImageCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/28.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskAddImageCell.h"

@interface TaskAddImageCell ()



@end


@implementation TaskAddImageCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    self.contentView.clipsToBounds = NO;
    _zoneImageView = [[UIImageView alloc]init];
    _zoneImageView.image = [UIImage imageNamed:@"添加图片"];
    _zoneImageView.contentMode = UIViewContentModeScaleToFill;
    _zoneImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_zoneImageView];
    [_zoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-Width(5));
        make.top.equalTo(self.contentView).offset(Width(5));
    }];
    
    _deleteBtn = [F_UI creatBtnWithTager:self title:nil font:0 image:[UIImage imageNamed:@"删"] backImage:nil color:nil textColor:nil cornerRadius:0 action:@selector(deleteImage)];
    [self.contentView addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_zoneImageView).offset(-Width(5));
        make.right.equalTo(_zoneImageView.mas_right).offset(Width(5));
        make.width.height.mas_equalTo(Width(15));
    }];
}

- (void)setImageString:(NSString *)imageString{
    _imageString = imageString;
   
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    if (_imageString.length) {
//        _zoneImageView.image = [UIImage imageNamed:@"方图片1"];
//        _deleteBtn.hidden = NO;
//    }else{
//        _zoneImageView.image = [UIImage imageNamed:@"添加图片"];
//        _deleteBtn.hidden = YES;
//    }
//}

- (void)deleteImage{
    self.deleteimg();
}

@end
