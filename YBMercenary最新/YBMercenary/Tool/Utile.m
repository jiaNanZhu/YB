//
//  Utile.m
//  SYChuangKeProject
//
//  Created by 险峰科技 on 16/6/29.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import "Utile.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation Utile



+(void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    gesture.numberOfTouchesRequired = 1;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:gesture];
}
+(void)makeCorner:(CGFloat)corner view:(UIView *)view
{
    CALayer *layer = view.layer;
    layer.cornerRadius = corner;
    layer.masksToBounds = YES;
}
+(void)makecorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color
{
    CALayer *layer = view.layer;
    layer.borderColor = color.CGColor;
    layer.borderWidth = corner;
}
+(void)setFourSides:(UIView *)view direction:(NSString *)direction sizeW:(CGFloat)width color:(UIColor *)color
{
    if ([direction isEqualToString:@"left"]) {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, (view.frame.size.height-width)/2.0f, 0.5, width)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }else if ([direction isEqualToString:@"right"])
    {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width - 0.5, (view.frame.size.height-width)/2.0f, 0.5, width)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }else if ([direction isEqualToString:@"top"])
    {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }else if ([direction isEqualToString:@"bottom"])
    {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, width, 0.5)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }
}
+(void)setUILabel:(UILabel *)label data:(NSString *)data setData:(NSString *)setData color:(UIColor *)color font:(CGFloat)font underLine:(BOOL)isbool
{
    NSRange range = [label.text rangeOfString:setData];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:label.text];
        [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(data.length, setData.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(data.length, setData.length)];
        if (isbool) {
            [string addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(data.length, setData.length)];
        }
        label.attributedText = string;
    }
}

+(CGFloat)returnViewFrame:(UIView *)view direction:(NSString *)direction
{
    if ([direction isEqualToString:@"X"]) {
        return view.frame.origin.x+view.frame.size.width;
    }else
    {
        return view.frame.origin.y+view.frame.size.height;
    }
}
#pragma mark 判断字符是否为空
+ (BOOL)stringIsNil:(NSString *)strings{
    if ([strings isEqualToString:@""]||[strings isEqualToString:@"(null)"]||[strings isEqualToString:@"<null>"]||(strings.length == 0)||[strings isEqualToString:@"空字符"]||[strings isEqualToString:@"0"]) {
        return YES;
    }else{
        return NO;
    }
    
}
#pragma mark 判断字符是否为空
+ (BOOL)stringIsNilkong:(NSString *)strings{
    if ([strings isEqualToString:@""]||[strings isEqualToString:@"(null)"]||[strings isEqualToString:@"<null>"]||(strings.length == 0)||[strings isEqualToString:@"空字符"]) {
        return YES;
    }else{
        return NO;
    }
    
}

#pragma mark 判断字符是否为空
+ (BOOL)stringIsNilZero:(NSString *)strings{
    if ([strings isEqualToString:@""]||[strings isEqualToString:@"(null)"]||[strings isEqualToString:@"<null>"]||(strings.length == 0)) {
        return YES;
    }else{
        return NO;
    }
    
}

+(UIFont *)systemFontOfSize:(CGFloat)fontSize{
    
    //我是根据屏幕尺寸判断的设备，然后字体设置为0.8倍
    
    if (kScreenHeight < 568) {
        
        fontSize = fontSize * 0.8;
        
    }
    
    UIFont *newFont = [ UIFont preferredFontForTextStyle : UIFontTextStyleBody ];
    
    UIFontDescriptor *ctfFont = newFont.fontDescriptor ;
    
    NSString *fontString = [ctfFont objectForKey : @"NSFontNameAttribute"];
    
    //使用 fontWithName 设置字体
    
    return [UIFont fontWithName:fontString size:fontSize];
    
}
#pragma mark 图片翻转
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//判断手机号码格式是否正确
+(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
//颜色生成图片
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param size 图片尺寸
 *
 *  @return 生成的图片
 */
+(UIImage*)GetImageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGRect r= CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark-- 计算天数
+(int)daysWithStartDate:(NSString *)startDate endDate:(NSString *)endDate{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    //计算两个中间差值(秒)
    NSTimeInterval time = [[dateFormat dateFromString:endDate] timeIntervalSinceDate:[dateFormat dateFromString:startDate]];
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((NSInteger)time)/(3600*24);  //一天是24小时*3600秒
    
    return days;
}

//判断是否电话号
+(BOOL)isPhone:(NSString *)phone{
    NSString *mobile = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    return [regextestMobile evaluateWithObject:phone];
}
//判断是否全是中文，中间可以带一个小点点（新疆名字）
+(BOOL)isName:(NSString *)name{
    NSString *test = @"^([\u4e00-\u9fa5]{4,20}|[a-zA-Z\.\s]{4,20})$";
    NSPredicate *regextestName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",test];
    return [regextestName evaluateWithObject:name];
    
}
//判断是否是纯数字
+(BOOL)isNumber:(NSString *)number{
    NSString *test = @"^[1-9]\d*$";
    NSPredicate *regextestNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",test];
    return [regextestNumber evaluateWithObject:number];
}

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}

@end
