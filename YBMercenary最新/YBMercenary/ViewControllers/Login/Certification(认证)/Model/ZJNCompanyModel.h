//
//  ZJNCompanyModel.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNCompanyModel : NSObject
@property (nonatomic ,strong)NSString * toekn;
@property (nonatomic ,strong)NSString * name;//姓名
@property (nonatomic ,strong)NSString * khArea;//开户地区
@property (nonatomic ,strong)NSString * idCard;//身份证号
@property (nonatomic ,strong)NSString * linkName;//联系人姓名
@property (nonatomic ,strong)NSString * linePhone;//联系人手机
@property (nonatomic ,strong)NSString * kfName;//开户名
@property (nonatomic ,strong)NSString * bankCard;//银行卡号
@property (nonatomic ,strong)NSString * khh;//开户行
@property (nonatomic ,strong)NSString * fzfArea;//分账方地址
@property (nonatomic ,strong)NSString * yezz;//营业执照
@property (nonatomic ,strong)NSString * company;//企业名称
@property (nonatomic ,strong)NSString * legalPerson;//法人
@property (nonatomic ,strong)NSString * idCardA;//身份证正面
@property (nonatomic ,strong)UIImage  * idCardAImg;
@property (nonatomic ,strong)NSString * idCardB;//身份证反面
@property (nonatomic ,strong)UIImage  * idCardBImg;
@property (nonatomic ,strong)NSString * yyzz;//营业执照
@property (nonatomic ,strong)UIImage  * yyzzImg;
@property (nonatomic ,strong)NSString * zzjg;//组织机构代码证
@property (nonatomic ,strong)UIImage  * zzjgImg;
@property (nonatomic ,strong)NSString * yhkkh;//银行卡开户许可证
@property (nonatomic ,strong)UIImage  * yhkkhImg;
@property (nonatomic ,strong)NSString * swdj;//税务登记
@property (nonatomic ,strong)UIImage  * swdjImg;
@end

NS_ASSUME_NONNULL_END
