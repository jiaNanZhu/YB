//
//  ZJNIndividualModel.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNIndividualModel : NSObject
@property (nonatomic ,strong)NSString * toekn;
@property (nonatomic ,strong)NSString * name;//姓名
@property (nonatomic ,strong)NSString * idCard;//身份证号
@property (nonatomic ,strong)NSString * khProvince;//开户省
@property (nonatomic ,strong)NSString * khCity;//开户市
@property (nonatomic ,strong)NSString * khh;//开户行
@property (nonatomic ,strong)NSString * bankCard;//银行卡号
@property (nonatomic ,strong)NSString * linkName;//联系人姓名
@property (nonatomic ,strong)NSString * linePhone;//联系人手机
@property (nonatomic ,strong)NSString * bankCardPhoto;//银行卡照片
@property (nonatomic ,strong)NSString * scIdCard;//手持身份证照片
@property (nonatomic ,strong)NSString * idCardA;//身份证正面
@property (nonatomic ,strong)NSString * idCardB;//身份证反面
@end

NS_ASSUME_NONNULL_END
