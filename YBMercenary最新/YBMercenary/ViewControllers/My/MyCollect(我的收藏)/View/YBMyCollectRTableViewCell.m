//
//  YBMyCollectRTableViewCell.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyCollectRTableViewCell.h"
#import "DateTool.h"
#import "UIView+OverPosition.h"
@implementation YBMyCollectRTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        _picIMG = [F_UI SL_UI_UIimg:[UIImage imageNamed:@"Group1"] cornerRadius:AdFloat(40)];
        _picIMG.frame = CGRectMake(AdFloat(30), AdFloat(30), AdFloat(80), AdFloat(80));
        [self addSubview:_picIMG];
        
        
        _nameLab = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"444444"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(30) numberOfLines:1];
        _nameLab.frame =CGRectMake(_picIMG.maxX+AdFloat(24), AdFloat(26), d_Device_width-AdFloat(230), AdFloat(40)); //CGRectMake(_picIMG.maxX+AdFloat(24), 0, AdFloat(400), AdFloat(140));
        
        [self addSubview:_nameLab];
        
        UIView *xianView = [F_UI SL_UI_View:COlOR_R_G_B_A(242, 242, 242, 1) cornerRadius:0 borderColor:nil borderWidth:0];
        xianView.frame = CGRectMake(AdFloat(30), AdFloat(138), d_Device_width-AdFloat(60), AdFloat(2));
        [self addSubview:xianView];
        
        

      
        
        _contentLab = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"666666"] textAlignment:NSTextAlignmentLeft textFont:AdFloat(26) numberOfLines:1];
        _contentLab.frame = CGRectMake(_nameLab.left, _nameLab.maxY+AdFloat(10), d_Device_width-AdFloat(60), AdFloat(40));
        [self addSubview:_contentLab];
        
        _timeLab = [F_UI SL_UI_Label:@"" color:[UIColor hex:@"999999"] textAlignment:NSTextAlignmentRight textFont:AdFloat(26) numberOfLines:1];
        _timeLab.frame = CGRectMake(d_Device_width-AdFloat(230), AdFloat(26), AdFloat(200), AdFloat(30));
        [self addSubview:_timeLab];
        
        
        _read_status =[[UIView alloc]init];
        _read_status.hidden=YES;
        _read_status.backgroundColor=[UIColor redColor];
        
        _read_status.frame=CGRectMake(_picIMG.right-10, _picIMG.top, 10, 10);

        _read_status.clipsToBounds=YES;
        _read_status.layer.cornerRadius=5;
        
        [self addSubview:_read_status];
        
        
    }
    return self;
}

-(void)networkDataCell:(YBMessagModel *)model
{
    _nameLab.text=model.touser_name;
    [_picIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.touserhead_img]] placeholderImage:[UIImage imageNamed:@"Group1"]];
    
    _timeLab.text=[self updateTimeForRow:model.msgtime];
    
    _contentLab.text=model.content;
    
    _read_status.hidden=[model.read_status intValue];
}

-(void)networkdatawithmodel:(YBMyCollectUserModel *)model
{
    _nameLab.text=model.name;
    [_picIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.head_img]] placeholderImage:nil];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)networkdatawithmsg:(SearchResultModel *)msg{
    
    
    

    _nameLab.text=msg.name;
    [_picIMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,msg.portraitUri]] placeholderImage:[UIImage imageNamed:@"Group1"]];
    
    _timeLab.text=[RCKitUtility ConvertMessageTime:msg.time / 1000];;
    
//    _contentLab.text=msg.otherInformation;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.searchString];
    UIColor *highlightedColor = [UIColor hex:@"0099ff"];
    
    NSRange range =[self.searchString rangeOfString:msg.otherInformation];
    
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:highlightedColor range:range];
    _contentLab.attributedText = attributedString;
    
    _read_status.hidden=YES;
    
}

- (NSString *)updateTimeForRow:(NSString *)createTimeString {
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval createTime = [createTimeString longLongValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;

    NSInteger sec = time/60;
    
    if (time <60) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}
@end
