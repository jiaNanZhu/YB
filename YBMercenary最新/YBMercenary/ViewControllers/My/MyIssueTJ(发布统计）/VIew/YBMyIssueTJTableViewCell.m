//
//  YBMyIssueTJTableViewCell.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyIssueTJTableViewCell.h"

@implementation YBMyIssueTJTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){

        _titleLab = [F_UI SL_UI_Label:@"杀人放火" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(30) numberOfLines:1];
        _titleLab.frame = CGRectMake(AdFloat(30), 0, AdFloat(300), AdFloat(102));
        [self addSubview:_titleLab];
        
        _numLab = [F_UI SL_UI_Label:@"¥30000.00" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentRight textFont:AdFloat(30) numberOfLines:1];
        _numLab.frame = CGRectMake(d_Device_width-AdFloat(300), 0, AdFloat(270), AdFloat(102));
        [self addSubview:_numLab];
        
        UIView *xianView = [F_UI SL_UI_View:COlOR_R_G_B_A(242, 242, 242, 1) cornerRadius:0 borderColor:nil borderWidth:0  ];
        xianView.frame = CGRectMake(AdFloat(30), AdFloat(102), d_Device_width-AdFloat(60), AdFloat(2));
        [self addSubview:xianView];
        
    }
    return self;
}

-(void)networkDataCell:(NSDictionary *)dic{
    
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
