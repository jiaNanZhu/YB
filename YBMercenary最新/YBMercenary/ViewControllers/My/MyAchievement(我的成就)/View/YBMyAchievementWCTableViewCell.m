//
//  YBMyAchievementWCTableViewCell.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/29.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBMyAchievementWCTableViewCell.h"
#import "DateTool.h"
@implementation YBMyAchievementWCTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){

        _titleLab = [F_UI SL_UI_Label:@"挫折" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
        _titleLab.frame = CGRectMake(AdFloat(30), AdFloat(20), AdFloat(476), AdFloat(40));
        [self addSubview:_titleLab];
        
        _introLab = [F_UI SL_UI_Label:@"成就简介：杀人放火次数超过10000次" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(26) numberOfLines:1];
        _introLab.frame = CGRectMake(AdFloat(30), _titleLab.maxY+AdFloat(14), AdFloat(500), AdFloat(36));
        [self addSubview:_introLab];
        
        _timeLab = [F_UI SL_UI_Label:@"2018-03-29 17:51:36" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(24) numberOfLines:1];
        _timeLab.frame = CGRectMake(AdFloat(30), _introLab.maxY+AdFloat(14), AdFloat(476), AdFloat(34));
        _timeLab.hidden = YES;
        [self addSubview:_timeLab];
        
        _scheduleView = [F_UI SL_UI_View:[UIColor hex:@"E5E5E5"] cornerRadius:AdFloat(8) borderColor:nil borderWidth:0];
        _scheduleView.frame = CGRectMake(AdFloat(30), _introLab.maxY+AdFloat(18), AdFloat(420), AdFloat(16));
        _scheduleView.hidden = YES;
        [self addSubview:_scheduleView];
        
        _scheduleView1 = [F_UI SL_UI_View:[UIColor hex:@"FDC72C"] cornerRadius:AdFloat(8) borderColor:nil borderWidth:0];
        _scheduleView1.frame = CGRectMake(0, 0, AdFloat(380), AdFloat(16));
        [_scheduleView addSubview:_scheduleView1];
        
        _countLab = [F_UI SL_UI_Label:@"0/0" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
        _countLab.frame = CGRectMake(_scheduleView.maxX+AdFloat(12), _introLab.maxY+AdFloat(4), AdFloat(150), AdFloat(40));
        _countLab.hidden = YES;
        [self addSubview:_countLab];
        
        _picIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"3"] cornerRadius:0];
        _picIMG.frame = CGRectMake(d_Device_width-AdFloat(150), AdFloat(30), AdFloat(120), AdFloat(120));
        [self addSubview:_picIMG];
        
        UIView *xianView = [F_UI SL_UI_View:COlOR_R_G_B_A(242, 242, 242, 1) cornerRadius:0 borderColor:nil borderWidth:0  ];
        xianView.frame = CGRectMake(AdFloat(30), AdFloat(180), d_Device_width-AdFloat(60), AdFloat(2));
        [self addSubview:xianView];
        
    }
    return self;
}

-(void)networkDataCell:(NSDictionary *)dic row:(int)row section:(int)section{
    
    
    _titleLab.text= dic[@"name"];
    
    _introLab.text=[NSString stringWithFormat:@"成就简介：%@",dic[@"complete"]];
    
    if (section == 0) {
        _timeLab.hidden = NO;
//        _picIMG.image = [UIImage imageNamed:@"勋章"];
        [_picIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,dic[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
        
        _timeLab.text =[DateTool timeStampToString:[dic[@"get_time"] integerValue]];

        
    }else{
        _scheduleView.hidden = NO;
        _countLab.hidden = NO;
        _picIMG.image = [UIImage imageNamed:@"勋章"];
        
        [_picIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,dic[@"medal"]]] placeholderImage:[UIImage imageNamed:@"勋章"]];
        
        _countLab.text=[NSString stringWithFormat:@"%@/%@",dic[@"get_times"],dic[@"need_times"]];
        
        
        
        NSInteger  get_times=[dic[@"get_times"] intValue];
        NSInteger need_times =[dic[@"need_times"] integerValue];
        CGFloat  width=0;
        if (need_times != 0) {
            width=  (get_times/need_times)*AdFloat(420);
        }
        
        
        _scheduleView1.frame = CGRectMake(0, 0, width, AdFloat(16));
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
