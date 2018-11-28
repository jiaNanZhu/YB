//
//  TaskStarCell.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/24.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "TaskStarCell.h"

@interface TaskStarCell ()

@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation TaskStarCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initSubViews{
    _starLabel = [F_UI SL_UI_Label:@"一星" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentCenter textFont:14 numberOfLines:1];
    [self.contentView addSubview:_starLabel];
    [_starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-Width(10));
    }];
    
    _countLabel = [F_UI SL_UI_Label:@"3" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentCenter textFont:16 numberOfLines:1];
    [self.contentView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_centerY).offset(Width(10));
    }];
}

//- (void)setIndex:(NSInteger)index{
//    _index = index;
////    switch (_index) {
////        case 0:
////            _starLabel.text = @"一星";
////            _countLabel.text = [self.dict[@"one"] stringValue];
////            break;
////        case 1:
////            _starLabel.text = @"二星";
////            _countLabel.text = [self.dict[@"tow"] stringValue];
////            break;
////        case 2:
////            _starLabel.text = @"三星";
////            _countLabel.text =[self.dict[@"three"] stringValue];
////            break;
////        case 3:
////            _starLabel.text = @"四星";
////            _countLabel.text =[self.dict[@"fore"] stringValue];
////            break;
////        case 4:
////            _starLabel.text = @"五星";
////            _countLabel.text = [self.dict[@"five"] stringValue];
////            break;
////        case 5:
////            _starLabel.text = @"总计";
////            _countLabel.text = [self.dict[@"total"] stringValue];
////            break;
////        default:
////            break;
////    }
//}
//
//-(void)setDict:(NSDictionary *)dict
//{
//    _dict =dict;
//}
-(void)configurationindex:(NSInteger)index dict:(TasksvalueModel *)model
{
    _index = index;
    switch (_index) {
        case 0:
            _starLabel.text = @"一星";
            _countLabel.text = model.one;
            break;
        case 1:
            _starLabel.text = @"二星";
            _countLabel.text = model.two;
            break;
        case 2:
            _starLabel.text = @"三星";
            _countLabel.text =model.three;
            break;
        case 3:
            _starLabel.text = @"四星";
            _countLabel.text =model.fore;
            break;
        case 4:
            _starLabel.text = @"五星";
            _countLabel.text =model.five;
            break;
        case 5:
            _starLabel.text = @"总计";
            _countLabel.text = model.total;
            break;
        default:
            break;
    }
}
@end
