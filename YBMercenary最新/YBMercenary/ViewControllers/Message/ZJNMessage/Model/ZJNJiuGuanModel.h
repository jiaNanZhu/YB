//
//  ZJNJiuGuanModel.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/23.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNJiuGuanModel : NSObject
//消息id
@property (nonatomic ,copy)NSString * id;
//帖子id
@property (nonatomic ,copy)NSString * post_id;
//消息内容
@property (nonatomic ,copy)NSString * content;
//消息发送时间（时间戳）
@property (nonatomic ,copy)NSString * push_time;
//消息接收者id
@property (nonatomic ,copy)NSString * push_id;
//用户id
@property (nonatomic ,copy)NSString * user_id;
//读取状态（0:未读，1：已读）
@property (nonatomic ,copy)NSString * read_status;

@end

NS_ASSUME_NONNULL_END
