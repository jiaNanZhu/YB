//
//  YBUser.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBUser : NSObject<NSCopying>

@property(nonatomic ,copy)NSString *age;
@property(nonatomic ,copy)NSString *business_license;
@property(nonatomic ,copy)NSString *certificate;
@property(nonatomic ,copy)NSString *create_time;
@property(nonatomic ,copy)NSString *experience;
@property(nonatomic ,copy)NSString *head_img;
@property(nonatomic ,copy)NSString *id_card;
@property(nonatomic ,copy)NSString *identity_front;
@property(nonatomic ,copy)NSString *industry;
@property(nonatomic ,copy)NSString *is_check;
@property(nonatomic ,copy)NSString *mail;
@property(nonatomic ,copy)NSString *mobile;
@property(nonatomic ,copy)NSString *name;
@property(nonatomic ,copy)NSString *nick_name;
@property(nonatomic ,copy)NSString *sex;
@property(nonatomic ,copy)NSString *speciality;
@property(nonatomic ,copy)NSString *user_type;
@property(nonatomic ,copy)NSString *workyear;
@property(nonatomic ,copy)NSString *money;
@property(nonatomic ,copy)NSString *id;
@property(nonatomic ,copy)NSString *isagree;//0:未同意推广守则，1:已同意推广守则
//类型强转
+(NSString *)stringValueOf:(id)_string;

//暂时用做判断是否登录
+(void)setBoolLogin:(id)string;
+(NSString *)boolLogin;
//判断是否同意了用户推广守则
+(void)setIsAgreeRules:(BOOL)isAgree;
+(BOOL)isAgreeRules;
//获取字符串宽度
+(float)widthForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width  andHeight:(float)height;
//获取字符串的高度
+(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width  andHeight:(float)height;
@end
