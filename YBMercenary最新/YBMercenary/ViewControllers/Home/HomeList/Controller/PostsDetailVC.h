//
//  PostsDetailVC.h
//  YBMercenary
//
//  Created by 龙青磊 on 2018/4/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "BaseTableVC.h"
#import "FCHeadlinesDetailsCommentKeyBoardView.h"
@interface PostsDetailVC : BaseTableVC
@property (nonatomic, strong) NSString *detailid;
@property(nonatomic,strong)FCHeadlinesDetailsCommentKeyBoardView *commentView;
@end
