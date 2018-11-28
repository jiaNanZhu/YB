//
//  SignTool.m
//  YBMercenary
//
//  Created by JW on 2018/7/5.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "SignTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation SignTool
+(NSString *)signStr:(NSDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSString *categoryId in sortedArray) {
        
            [contentString appendFormat:@"%@=%@", categoryId, [dict objectForKey:categoryId]];
    }
    
    NSString *signStr = [SignTool md5:[contentString stringByAppendingString:APPSignkeySecret]];
    return signStr;
}
+(NSString *)md5:(NSString *)str
{
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}


@end
