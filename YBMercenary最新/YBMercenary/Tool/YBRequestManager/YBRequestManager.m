//
//  YBRequestManager.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/4.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "YBRequestManager.h"

@interface YBRequestManager()

@end
@implementation YBRequestManager
static YBRequestManager *manager = nil;
+(YBRequestManager *)sharedYBManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YBRequestManager alloc]init];
        manager.sessionManager = [AFHTTPSessionManager manager];
        
        AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
        request.timeoutInterval = 30;
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        manager.sessionManager.requestSerializer = request;
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];
        manager.sessionManager.responseSerializer = response;
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        manager.sessionManager.securityPolicy = securityPolicy;
        
    });
    return manager;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
        manager.sessionManager = [AFHTTPSessionManager manager];
        
        AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
        request.timeoutInterval = 30;
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        manager.sessionManager.requestSerializer = request;
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];
        manager.sessionManager.responseSerializer = response;
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        manager.sessionManager.securityPolicy = securityPolicy;
    });
    return manager;
}

-(void)getWithUrlString:(NSString *)urlStr success:(HttpSuccess)success failure:(HttpFailure)failure{
    [self.sessionManager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)postWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure{
    
    NSString *URL = [HOST stringByAppendingString:urlStr];
    
    [self.sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
-(void)postWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameters images:(NSArray *)images success:(HttpSuccess)success failure:(HttpFailure)failure{
    NSString *URL = [HOST stringByAppendingString:urlStr];
    [self.sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i <images.count; i ++) {
            UIImage *image = images[i];
            NSData *imgData = [NSData dataWithData:UIImageJPEGRepresentation(image, 0.8)];
            
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"image%d",i] fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
