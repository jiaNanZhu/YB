//
//  YBUser.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBUser.h"

@implementation YBUser
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; }
+(NSString *)stringValueOf:(id)_string{
    return ([_string isKindOfClass:[NSString class]]?_string:[_string stringValue]);
}
#pragma mark 临时判断是否登录
+(void)setBoolLogin:(id)string{
    [[NSUserDefaults standardUserDefaults] setObject:[YBUser stringValueOf:string] forKey:YBMercenary_key_Bool_Login];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)boolLogin{
    return [[NSUserDefaults standardUserDefaults] objectForKey:YBMercenary_key_Bool_Login];
}
#pragma mark-判断是否同意了用户推广守则
+(void)setIsAgreeRules:(BOOL)isAgree{
    [[NSUserDefaults standardUserDefaults] setBool:isAgree forKey:@"isAgree"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)isAgreeRules{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isAgree"];
}
//获取字符串的高度
+(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width  andHeight:(float)height
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize labelSize = [value boundingRectWithSize:CGSizeMake(width, height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelSize.height;
}
//获取字符串的宽度
+(float)widthForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width  andHeight:(float)height
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize labelSize = [value boundingRectWithSize:CGSizeMake(width, height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelSize.width;
}
@end
