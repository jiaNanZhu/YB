//
//  PostsModel.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/11.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "PostsCommentModel.h"
#import "NSString+Size.h"

@implementation PostsCommentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"huifu" : [PostsCommentListModel class]};
}
- (void)setCommentList:(NSArray *)commentList{
    _commentList = commentList;
    CGFloat commentHeight = 0;
    for (PostsCommentListModel *model in _commentList) {
        NSString *commentname = [model.commenter objectForKey:@"username"];
        NSString *content = model.content;
        NSString *totalString = @"";
        totalString = [NSString stringWithFormat:@"%@: %@",commentname,content];
        CGFloat height = [totalString zoneCommentGetHeightWithWidth:(kScreenWidth - Width(110)) nameFont:[UIFont fontSize:14] conetnFont:[UIFont fontSize:14]];
        model.height = height + Width(10);
        NSLog(@"评论高度为 %f",model.height);
        commentHeight += (height + Width(10));
    }
    NSLog(@"心情的总的评论高度为 %f",commentHeight);
    self.commentHeight = commentHeight;
}


@end

@implementation PostsCommentListModel

@end
