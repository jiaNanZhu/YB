//
//  FCHeadlinesDetailsCommentKeyBoardView.h
//  OverseasRealEstateProject
//
//  Created by JW on 2018/4/24.
//  Copyright © 2018年 险峰科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+OverPosition.h"
@class FCHeadlinesDetailsCommentKeyBoardView;

@protocol FCHeadlinesDetailsCommentKeyBoardViewDelegate <NSObject>

//发送评论
-(void)send;
//点击表情按钮
-(void)clickEmotion:(UIButton *)emojiBtn;
@end

@interface FCHeadlinesDetailsCommentKeyBoardView : UIView<UITextViewDelegate>
@property(weak ,nonatomic)id<FCHeadlinesDetailsCommentKeyBoardViewDelegate>delegate;

@property(nonatomic,strong)UIButton *emojiBtn;
@property(nonatomic,strong)UIButton *sendBtn;

@property(nonatomic,strong)UIView *textFieldView;
@property(nonatomic,strong)UITextView *textView;

@end
