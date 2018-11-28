//
//  DateTool.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/17.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool
+(NSString *)timeStampToString:(NSInteger)timeStamp{
//    timeStamp = timeStamp/1000;
    NSDate *dateStamp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateformt = [[NSDateFormatter alloc]init];
    [dateformt setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateformt stringFromDate:dateStamp];
    return dateStr;
}
+(NSString *)zjnTimeStampToString:(NSInteger)timeStamp{
//    timeStamp = timeStamp/1000;
    NSDate *dateStamp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateformt = [[NSDateFormatter alloc]init];
    [dateformt setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
    NSString *dateStr = [dateformt stringFromDate:dateStamp];
    return dateStr;
}
@end
