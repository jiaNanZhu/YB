//
//  YBMyCollectRWTableViewCell.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyCollectRWTableViewCell.h"

@implementation YBMyCollectRWTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        _titleLab = [F_UI SL_UI_Label:@"搬家" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
        _titleLab.frame = CGRectMake(AdFloat(30), AdFloat(30), AdFloat(350), AdFloat(30));
        [self addSubview:_titleLab];
        
        _contentLab = [F_UI SL_UI_Label:@"限北京市区搬运" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(28) numberOfLines:1];
        _contentLab.frame = CGRectMake(AdFloat(30), _titleLab.maxY+AdFloat(20), d_Device_width-AdFloat(60), AdFloat(30));
        [self addSubview:_contentLab];
        
        _numLab = [F_UI SL_UI_Label:@"¥888.00" color:[UIColor hex:@"FFC90E"] textAlignment:NSTextAlignmentRight textFont:AdFloat(38) numberOfLines:1];
        _numLab.frame = CGRectMake(d_Device_width-AdFloat(300), AdFloat(30), AdFloat(270), AdFloat(40));
        [self addSubview:_numLab];
        
        _CompletedIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"已完成"] cornerRadius:0];
        _CompletedIMG.frame = CGRectMake(d_Device_width-AdFloat(120), _contentLab.maxY+AdFloat(10), AdFloat(90), AdFloat(70));
        _CompletedIMG.hidden = YES;
        [self addSubview:_CompletedIMG];
        
        UIView *xianView = [F_UI SL_UI_View:COlOR_R_G_B_A(242, 242, 242, 1) cornerRadius:0 borderColor:nil borderWidth:0  ];
        xianView.frame = CGRectMake(AdFloat(30), AdFloat(218), d_Device_width-AdFloat(60), AdFloat(2));
        [self addSubview:xianView];
        
        
        
        
        
        
        
    }
    return self;
}

-(void)networkDataCell:(NSDictionary *)dic row:(int)row type:(int)type{
    //type (1.全部 2.收藏、已报名、任务中、审核中 3.已完成)
    NSArray *arr = @[@"赚钱很快",@"赚钱快",@"钱快",@"快"];
    CGFloat w = 0;
    CGFloat h = AdFloat(140);
    for (int i = 0; i < arr.count; i++) {
        float labW = [YBUser widthForString:arr[i] fontSize:AdFloat(24) andWidth:AdFloat(200) andHeight:AdFloat(20)];
        UILabel *lab = [F_UI SL_UI_Label:arr[i] color:[UIColor hex:@"F5513C"] textAlignment:NSTextAlignmentCenter textFont:AdFloat(24) numberOfLines:1];
        lab.frame = CGRectMake(i== 0 ? AdFloat(30) : AdFloat(20)+w, h, labW+AdFloat(20), AdFloat(40));
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = AdFloat(4);
        lab.layer.borderColor = [UIColor hex:@"F5513C"].CGColor;//边框颜色
        lab.layer.borderWidth = AdFloat(2);//边框宽度
        [self addSubview:lab];
        w = lab.width + lab.x;
    }
    if (type == 1) {
        if (row == 3) {
            _CompletedIMG.hidden = NO;
        }
    }else if (type == 2){
        _CompletedIMG.hidden = YES;
    }else{
        _CompletedIMG.hidden = NO;
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

-(void)configurationwithmodel:(YBMyIssueModel *)model
{
    self.titleLab.text=model.task_name;
    self.contentLab.text=model.task_description;
    self.numLab.text=[NSString stringWithFormat:@"¥%@",model.pay_amount];
    
    NSArray *arr = [model.task_tag componentsSeparatedByString:@"|"];
    CGFloat w = 0;
    CGFloat h = AdFloat(140);
    for (int i = 0; i < arr.count; i++) {
        
        if (i == 3) {
            break;
        }
        float labW = [YBUser widthForString:arr[i] fontSize:AdFloat(24) andWidth:AdFloat(200) andHeight:AdFloat(20)];
        UILabel *lab = [F_UI SL_UI_Label:arr[i] color:[UIColor hex:@"F5513C"] textAlignment:NSTextAlignmentCenter textFont:AdFloat(24) numberOfLines:1];
        lab.frame = CGRectMake(i== 0 ? AdFloat(30) : AdFloat(20)+w, h, labW+AdFloat(20), AdFloat(40));
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = AdFloat(4);
        lab.layer.borderColor = [UIColor hex:@"F5513C"].CGColor;//边框颜色
        lab.layer.borderWidth = AdFloat(2);//边框宽度
        
        [self addSubview:lab];
        w = lab.width + lab.x;
    }
    
    //已完成
    if ([model.task_status intValue] ==6) {
        _CompletedIMG.hidden = NO;
    }
    else{
        _CompletedIMG.hidden = YES;
    }
}
@end
