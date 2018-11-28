//
//  ZJNTaskMessageModel.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/22.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNTaskMessageModel : NSObject
//消息内容
@property (nonatomic ,copy)NSString * content;
//消息id
@property (nonatomic ,copy)NSString * id;
//消息标题
@property (nonatomic ,copy)NSString * name;
//消息接收者id
@property (nonatomic ,copy)NSString * push_id;
//消息发送时间（时间戳）
@property (nonatomic ,copy)NSString * push_time;
//读取状态（0:未读，1：已读）
@property (nonatomic ,copy)NSString * read_state;
//任务ID
@property (nonatomic ,copy)NSString * task_id;
//任务名称
@property (nonatomic ,copy)NSString * task_name;
//用户id
@property (nonatomic ,copy)NSString * user_id;
//消息接收者用户头像
@property (nonatomic ,copy)NSString * push_head_img;
//用户头像
@property (nonatomic ,copy)NSString * user_head_img;
//消息接收者用户昵称
@property (nonatomic ,copy)NSString * push_nick_name;
//用户昵称
@property (nonatomic ,copy)NSString * user_nick_name;
@end

NS_ASSUME_NONNULL_END
