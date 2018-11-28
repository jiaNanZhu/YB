//
//  TaskDetailModel.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/7/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskDetailModel : NSObject

/**
 开始地址
 */
@property (nonatomic ,copy)NSString * begin_address;

/**
 送达时间 时间戳格式
 */
@property (nonatomic ,copy)NSString * delivery_time;

/**
 目的地址
 */
@property (nonatomic ,copy)NSString * end_address;

/**
 发布人头像
 */
@property (nonatomic ,copy)NSString * head_img;

/**
 任务id
 */
@property (nonatomic ,copy)NSString * id;

/**
 是否已经报名该任务 1 已报名 0未报名
 */
@property (nonatomic ,copy)NSString * is_apply;

/**
 是否是发布任务人 1是 0不是本人
 */
@property (nonatomic ,copy)NSString * is_owner;

/**
 物品名称
 */
@property (nonatomic ,copy)NSString * itemname;

/**
 发布人姓名
 */
@property (nonatomic ,copy)NSString * name;

/**
 物品数量
 */
@property (nonatomic ,copy)NSString * numbers;

/**
 其他要求
 */
@property (nonatomic ,copy)NSString * other_request;

/**
 任务佣金
 */
@property (nonatomic ,copy)NSString * pay_amount;

/**
 任务发布时间 时间戳格式
 */
@property (nonatomic ,copy)NSString * publish_time;

/**
 发布人id
 */
@property (nonatomic ,copy)NSString * publisher_id;

/**
 任务详情
 */
@property (nonatomic ,copy)NSString * task_description;

/**
 任务相关图片
 */
@property (nonatomic ,copy)NSString * task_img;

/**
 任务名称
 */
@property (nonatomic ,copy)NSString * task_name;

/**
 任务目的
 */
@property (nonatomic ,copy)NSString * task_purpose;

/**
 任务要求
 */
@property (nonatomic ,copy)NSString * task_request;

/**
 任务状态 0 已发布等待管理员审核 1未决定 2任务中 3已完成待发布者审核 4已下架 5 管理员审核未通过，6发布者确认完成，待评价 7已评价
 */
@property (nonatomic ,copy)NSString * task_status;

/**
 任务标签
 */
@property (nonatomic ,copy)NSString * task_tag;

/**
 运输要求
 */
@property (nonatomic ,copy)NSString * transport;

/**
 任务有效期
 */
@property (nonatomic ,copy)NSString * validity_time;

/**
 收藏状态:1 已收藏 0 其他状态
 */
@property (nonatomic ,copy)NSString * collect;


/**
 选定人信息
 */
@property (nonatomic ,strong)NSDictionary *xuanding;


/**
 是否已报名
 */
@property (nonatomic ,copy)NSString *apply;
@end
