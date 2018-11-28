//
//  FCHeadlinesDetailsCommentKeyBoardView.m
//  OverseasRealEstateProject
//
//  Created by JW on 2018/4/24.
//  Copyright © 2018年 险峰科技. All rights reserved.
//

#import "FCHeadlinesDetailsCommentKeyBoardView.h"
#define kTopToolbarH    AdFloat(49*2)   //顶部工具栏高度

#define kBotContainerH  200 //底部表情高度

#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000
@implementation FCHeadlinesDetailsCommentKeyBoardView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setUp];
    return self;
}
-(UIButton *)emojiBtn
{
    if (!_emojiBtn) {
        _emojiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
//        [_emojiBtn setImage:SetImage(@"笑脸") forState:UIControlStateNormal];
        
        [_emojiBtn addTarget:self action:@selector(clcik:) forControlEvents:UIControlEventTouchUpInside];
        _emojiBtn.hidden=YES;
    }
    
    return _emojiBtn;
}
-(UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font=[UIFont systemFontOfSize:AdFloat(16*2)];
        [_sendBtn setTintColor:[UIColor hex:Nav_Color]];
        
        [_sendBtn addTarget:self action:@selector(clcik:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendBtn;
}
-(UIView *)textFieldView
{
    if (!_textFieldView) {
        _textFieldView=[[UIView alloc]init];
        
        _textFieldView.clipsToBounds=YES;
        _textFieldView.layer.cornerRadius=15.f;
        _textFieldView.layer.borderWidth=AdFloat(1*2);
        _textFieldView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    }
    
    return _textFieldView;
}
-(UITextView*)textView
{
    if (!_textView) {
        _textView=[[UITextView alloc]init];
//        _textView.placeholderText=kLocalizedString(@"请输入评论内容", @"请输入评论内容");
//        _textView.placeholderFont=[UIFont fontWithName:@"PingFangSC-Regular" size:AdFloat(16*2)];
//        _textView.placeholderTextColor=SetColor(0xFF999999);
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _textView.font=[UIFont fontWithName:@"PingFangSC-Regular" size:AdFloat(16*2)];
        //        _textView.extraAccessoryViewHeight = kToolbarHeight;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.alwaysBounceVertical = NO;
//        _textView.allowsCopyAttributedString = NO;
        
        _textView.inputAccessoryView = [UIView new];
        
        _textView.scrollsToTop = NO;
        _textView.enablesReturnKeyAutomatically = YES;
        _textView.textContainerInset = UIEdgeInsetsMake(3, 0, 0, 0);
        //        YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
        //        parser.emoticonMapper = mapper;
        //        _textView.textParser=parser;
        
//        YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
//        modifier.fixedLineHeight = 24;
//        _textView.linePositionModifier=modifier;
        
        _textView.delegate=self;
        
    }
    return _textView;
}

- (void)setUp {
    
    self.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:self.emojiBtn];
    [self addSubview:self.sendBtn];
    
    [self addSubview:self.textFieldView];
    [self.textFieldView addSubview:self.textView];
    
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(AdFloat(10*2));
        make.left.equalTo(self.mas_left).offset(AdFloat(15*2));
        
        make.bottom.equalTo(self.mas_bottom).offset(-AdFloat(10*2));
        make.right.equalTo(self.emojiBtn.mas_left).offset(-AdFloat(16*2));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.textFieldView);
        make.left.equalTo(self.textFieldView.mas_left).offset(AdFloat(12*2));
        make.right.equalTo(self.textFieldView.mas_right).offset(-AdFloat(12*2));
    }];
    
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.mas_top).offset(AdFloat(14*2));
        
        make.bottom.equalTo(self.mas_bottom).offset(-AdFloat(5*2));
        make.height.mas_equalTo(AdFloat(33*2));
        make.width.mas_equalTo(0);
        make.right.equalTo(self.sendBtn.mas_left).offset(-AdFloat(10*2));
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.mas_top).offset(AdFloat(14*2));
        
        make.bottom.equalTo(self.mas_bottom).offset(-AdFloat(5*2));
        make.height.width.mas_equalTo(AdFloat(33*2));
        make.right.equalTo(self.mas_right).offset(-AdFloat(15*2));
    }];
    
    
   
    
}

-(void)clcik:(UIButton *)btn
{
    if (self.emojiBtn == btn) {
        if ([self.delegate respondsToSelector:@selector(clickEmotion:)]) {
            [self.delegate clickEmotion:btn];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(send)]) {
            [self.delegate send];
        }
    }
    
}

-(void)textViewDidChangeSelection:(UITextView *)textView
{
   
    [self layoutIfNeeded];
    
    CGSize size =[textView.layoutManager usedRectForTextContainer:textView.textContainer].size;
    CGFloat textH = [textView.layoutManager usedRectForTextContainer:textView.textContainer].size.height;
   
    CGRect newFrame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame) - size.height, size.width, size.height);
    
    //输入框高度
    CGFloat h_inputV = kTopToolbarH - 2*AdFloat(10*2);

    if (textH <=h_inputV) {

        CGFloat toolbarH = h_inputV + 2*AdFloat(10*2) ;
        self.top=self.top-(toolbarH-self.height);
        self.height=kTopToolbarH;
        
    }else{
        //工具栏高度
        
        if (textH>=50) {
            textH=50;
        }
        CGFloat toolbarH = ceil(textH)+1 + 2*AdFloat(10*2) ;
        
        
        self.top=self.top-(toolbarH-self.height);
        self.height=toolbarH;
        
    }
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
    }];
    
    [textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//   NSString *hexstr = @"";
//
//   for (int i=0;i< [text length];i++)
//     {
//              hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%1X ",[text characterAtIndex:i]]];
//          }
//   NSLog(@"UTF16 [%@]",hexstr);
//
//    hexstr = @"";
//
//    long slen = strlen([text UTF8String]);
//
//    for (int i = 0; i < slen; i++)
//     {
//             //fffffff0 去除前面六个F & 0xFF
//            hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%X ",[text UTF8String][i] & 0xFF ]];
//        }
//    NSLog(@"UTF8 [%@]",hexstr);
//
//    hexstr = @"";
//
//    if ([text length] >= 2) {
// 
//      for (int i = 0; i < [text length] / 2 && ([text length] % 2 == 0) ; i++)
//          {
//         // three bytes
//         if (([text characterAtIndex:i*2] & 0xFF00) == 0 ) {
//                 hexstr = [hexstr stringByAppendingFormat:@"Ox%1X 0x%1X",[text characterAtIndex:i*2],[text characterAtIndex:i*2+1]];
//             }
//         else
//             {// four bytes
//                   hexstr = [hexstr stringByAppendingFormat:@"U+%1X ",MULITTHREEBYTEUTF16TOUNICODE([text characterAtIndex:i*2],[text characterAtIndex:i*2+1])];
//              }
//  
//     }
//      NSLog(@"(unicode) [%@]",hexstr);
//  }
//    else
//      {
//              NSLog(@"(unicode) U+%1X",[text characterAtIndex:0]);
//          }
//
//    return YES;
//}

@end
