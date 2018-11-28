//
//  ZJNRulesTableViewCell.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/4.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNRulesTableViewCell.h"
@interface ZJNRulesTableViewCell()
@property (nonatomic ,strong)UILabel *infoLabel;
@end
@implementation ZJNRulesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(AdFloat(30));
            make.right.equalTo(self.contentView).offset(-AdFloat(30));
            make.top.equalTo(self.contentView).offset(4);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
-(UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.font = SetFont(AdFloat(28));
        _infoLabel.textColor = [UIColor hex:@"999999"];
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}
-(void)setInfoStr:(NSString *)infoStr{
//    _infoStr = infoStr;
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setValue:[UIFont systemFontOfSize:AdFloat(28)] forKey:NSFontAttributeName];      // 字体大小
    [mutDic setValue:[UIColor hex:@"999999"] forKey:NSForegroundColorAttributeName];     // 字体颜色
//    [mutDic setValue:@5 forKey:NSKernAttributeName];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:infoStr attributes:mutDic];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 4;
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range: NSMakeRange(0, infoStr.length)];
   
    self.infoLabel.attributedText = attStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
