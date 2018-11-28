//
//  YBMyIssueModel.h
//  YBMercenary
//
//  Created by JW on 2018/7/18.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBMyIssueModel : NSObject

@property (nonatomic ,strong)NSString *id;
@property (nonatomic ,strong)NSString *task_name;
@property (nonatomic ,strong)NSString *pay_amount;
@property (nonatomic ,strong)NSString *task_description;
@property (nonatomic ,strong)NSString *task_tag;
@property (nonatomic ,strong)NSString *task_status;
@property (nonatomic ,copy)  NSString *apply_status;
@property (nonatomic ,copy)  NSString *task_person_id;
@property (nonatomic ,copy)  NSString *task_type;
@property (nonatomic ,strong)NSString *share_num;
@property (nonatomic ,strong)NSString *view_num;
@property (nonatomic ,strong)NSString *refuse_cause;//审核未通过原因
@property (nonatomic ,strong)NSString *is_yanqi;//0未延期 1延期
@property (nonatomic ,strong)NSString *yanqi_days;//延期天数
@property (nonatomic ,strong)NSString *yanqi_start;//延期日期
@property (nonatomic ,strong)NSString *yanqi_reason;//延期原因
@property (nonatomic ,strong)NSString *fabu_money;//退款：发布人金额
@property (nonatomic ,strong)NSString *fabu_name;//任务发布人姓名
@property (nonatomic ,strong)NSString *fafang_money;//退款：跑腿人金额
@property (nonatomic ,strong)NSString *ticheng;//平台提成
@property (nonatomic ,strong)NSString *zfpt_ticheng;//支付提成
@property (nonatomic ,strong)NSString *settle_status;//1未申请 2已申请 3已发放 4发放失败
@end
