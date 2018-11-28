//
//  YBRequestManager.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/4.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface YBRequestManager : NSObject
@property (nonatomic ,strong)AFHTTPSessionManager *sessionManager;
/**
 请求成功回调

 @param data 请求成功返回数据
 */
typedef void (^HttpSuccess) (id data);

/**
 请求失败回调

 @param error 请求失败原因
 */
typedef void (^HttpFailure) (NSError *error);

/** 单例创建Manager */
+(YBRequestManager *)sharedYBManager;

/**
 get请求

 @param urlStr 请求接口
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getWithUrlString:(NSString *)urlStr success:(HttpSuccess)success failure:(HttpFailure)failure;

/**
 post请求

 @param urlStr 请求接口
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)postWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;


/**
 form表单提交图片

 @param urlStr 请求接口
 @param parameters 请求参数
 @param images 需要上传的图片
 @param success 成功回调
 @param failure 失败回调
 */
-(void)postWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameters images:(NSArray *)images success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
