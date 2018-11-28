//
//  YBTaskMsgViewController.h
//  YBMercenary
//
//  Created by JW on 2018/8/3.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface YBTaskMsgViewController : UIViewController//RCConversationViewController


@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSString *type;

@property(nonatomic,strong)NSString *post_type;

@property(nonatomic,strong)NSString *message_id;

@property(nonatomic,strong)NSString *toUserId;


@end
