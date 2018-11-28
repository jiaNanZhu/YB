//
//  Utile.h
//  SYChuangKeProject
//
//  Created by 险峰科技 on 16/6/29.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utile : NSObject
//添加单击手势
+(void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view;
//给某个控件添加圆角
+(void)makeCorner:(CGFloat)corner view:(UIView *)view;
//给某给控件添加边框
+(void)makecorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color;
//控件边缘添加灰色线条
+(void)setFourSides:(UIView *)view direction:(NSString *)direction sizeW:(CGFloat)width color:(UIColor *)color;
//设置label的不同颜色和大小
+(void)setUILabel:(UILabel *)label data:(NSString *)data setData:(NSString *)setData color:(UIColor *)color font:(CGFloat)font underLine:(BOOL)isbool;

//返回控件的坐标
+(CGFloat)returnViewFrame:(UIView *)view direction:(NSString *)direction;
+(BOOL)stringIsNil:(NSString *)strings;
+ (BOOL)stringIsNilZero:(NSString *)strings;
+ (BOOL)stringIsNilkong:(NSString *)strings;
+(UIFont *)systemFontOfSize:(CGFloat)fontSize;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+(BOOL)valiMobile:(NSString *)mobile;//正则表达式判断号码是否正确
//颜色生成图片
+(UIImage*)GetImageWithColor:(UIColor*)color andSize:(CGSize)size;

/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

/**
 输入起始时间和结束时间，计算之间有多少天

 @param startDate 起始时间
 @param endDate 结束时间
 @return 有多少天
 */
+(int)daysWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;
//判断是否电话号
+(BOOL)isPhone:(NSString *)phone;
//判断是否全是中文，中间可以带一个小点点（新疆名字）
+(BOOL)isName:(NSString *)name;
//判断是否是纯数字
+(BOOL)isNumber:(NSString *)number;
@end
