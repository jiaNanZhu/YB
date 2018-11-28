//
//  ZJNSystemMessageModel.h
//  YBMercenary
//
//  Created by 险峰科技 on 2018/10/22.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNSystemMessageModel : NSObject

//id
@property (nonatomic ,copy)NSString * id;
//对应的系统消息id
@property (nonatomic ,copy)NSString * system_push_id;
//对应任务id
@property (nonatomic ,copy)NSString * task_id;
//对应帖子id
@property (nonatomic ,copy)NSString * post_id;
//用户id
@property (nonatomic ,copy)NSString * user_id;
//消息内容
@property (nonatomic ,copy)NSString * content;
//消息发送时间（时间戳）
@property (nonatomic ,copy)NSString * time;
//读取状态（0:未读，1：已读)
@property (nonatomic ,copy)NSString * read_status;

@end

NS_ASSUME_NONNULL_END
