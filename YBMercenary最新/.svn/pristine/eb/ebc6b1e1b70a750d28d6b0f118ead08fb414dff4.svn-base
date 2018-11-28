//
//  F_UI.h
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface F_UI : NSObject
//alert
+(nullable UIAlertController *)SL_UI_Alert:(nullable UIViewController *)BSelf PromptMassage:(nullable NSString *)prompt titles:(nullable NSString *)titles determine:(nullable void(^)(UIAlertAction  * _Nonnull action))hander ;
//UILabel
+(nullable UILabel *)SL_UI_Label:(nullable NSString *)text color:(nullable UIColor *)textcolor textAlignment:(NSTextAlignment)textAlignment textFont:(NSInteger)sizeNum numberOfLines:(NSInteger)numberOfLines;
//UIView
+(nullable UIView *)SL_UI_View:(nullable UIColor *)viewColor cornerRadius:(NSInteger)sizeNum borderColor:(nullable UIColor *)borderColor borderWidth:(NSInteger)with;
//UIButton
+(nullable UIButton *)SL_UI_Btn:(nullable NSString *)title Color:(nullable UIColor *)titleColor Font:( NSInteger)sizeNum bgimage:(nullable UIImage *)image selecteImage:(nullable UIImage *)selecteImage target:(nullable id)target action:( nonnull SEL)action cornerRadius:(NSInteger)sizeNum;
//UIImageView
+(nullable UIImageView *)SL_UI_UIimg:(nullable UIImage *)image cornerRadius:(NSInteger)size;
//UITextfield
+(nullable UITextField *)SL_UI_Field:(nullable NSString *)placeholderString font:(NSInteger)sizeNum textAlignment:(NSTextAlignment)textAlignment borderStyle:(UITextBorderStyle)borderStyle clearOnBeginEditing:(BOOL)clear secure:(BOOL)secure keyBoardStyle:(UIKeyboardType)keyBoardStyle;
//导航条 title
+(nullable UILabel *)SL_NavTitle:(nullable NSString *)title;
//导航条BackBtn
+(nullable UIBarButtonItem *)SL_BackBtn:(nullable UIImage *)image target:(nullable id)target action:(nonnull SEL)action;
//提示Label
+(nullable UILabel *)SL_AnimationLabel:(nullable NSString *)string;

+ (UIButton *_Nullable)creatBtnWithTager:(nullable id)target title:(NSString *)title font:(NSInteger)font image:(UIImage *)image backImage:(UIImage *)backiamge color:(UIColor *)color textColor:(UIColor *)textColor cornerRadius:(CGFloat)radius action:(SEL)action;
@end
