//
//  PostsModel.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PostsCommentListModel;
@interface PostsCommentModel : NSObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *iconImage;

@property (nonatomic, copy) NSString *creatTime;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *imageList;

@property (nonatomic, strong) NSArray *commentList;//评论列表

@property(nonatomic, assign) CGFloat commentHeight;

@property(nonatomic, strong) NSString  *create_time;
@property(nonatomic, strong) NSArray <PostsCommentListModel *>*huifu;
@property(nonatomic, strong) NSString  *id;
@property(nonatomic, strong) NSString  *liuyan_content;
@property(nonatomic, strong) NSString  *liuyan_user_headimg;
@property(nonatomic, strong) NSString  *liuyan_user_name;

@end

@interface PostsCommentListModel : NSObject

@property (nonatomic, strong) NSDictionary  *commenter;//评论人

@property (nonatomic, copy) NSString *content;//评论内容

@property(nonatomic, assign) CGFloat height;


@property (nonatomic, strong) NSString  *huifu_user_name;
@property (nonatomic, strong) NSString  *huifu_content;


@end
