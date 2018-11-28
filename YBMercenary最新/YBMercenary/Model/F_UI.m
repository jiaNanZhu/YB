//
//  F_UI.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "F_UI.h"

@implementation F_UI
+(nullable UIAlertController *)SL_UI_Alert:(nullable UIViewController *)BSelf PromptMassage:(nullable NSString *)prompt titles:(nullable NSString *)titles determine:(nullable void(^)(UIAlertAction  * _Nonnull action))hander ;
{
    /*
     typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
     UIAlertControllerStyleActionSheet = 0,//下铺
     UIAlertControllerStyleAlert //弹出
     }
     */
    UIAlertController * alertView =[UIAlertController alertControllerWithTitle:prompt message:titles preferredStyle:UIAlertControllerStyleAlert];
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,//无状态
     UIAlertActionStyleCancel,//蓝色
     UIAlertActionStyleDestructive//红色
     }
     */
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * determine =[UIAlertAction actionWithTitle:@"Determine" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        hander(action);
    }];
    [alertView addAction:cancel];
    [alertView addAction:determine];
    [BSelf presentViewController:alertView animated:YES completion:nil];
    return alertView;
}

+(nullable UILabel *)SL_UI_Label:(nullable NSString *)text color:(nullable UIColor *)textcolor textAlignment:(NSTextAlignment)textAlignment textFont:(NSInteger)sizeNum numberOfLines:(NSInteger)numberOfLines;
{
    UILabel * label =[[UILabel alloc]init];
    label.text=text;
    label.textColor =textcolor;
    label.font=[UIFont fontSize:sizeNum];
    label.textAlignment =textAlignment;
    label.numberOfLines =numberOfLines;
    
    return label;
}
+(nullable UIView *)SL_UI_View:(nullable UIColor *)viewColor cornerRadius:(NSInteger)sizeNum borderColor:(nullable UIColor *)borderColor borderWidth:(NSInteger)with{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = viewColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = sizeNum;
    view.layer.borderColor = borderColor.CGColor;//边框颜色
    view.layer.borderWidth = with;//边框宽度
    return view;
}
+(nullable UIButton *)SL_UI_Btn:(nullable NSString *)title Color:(nullable UIColor *)titleColor Font:( NSInteger)sizeNum bgimage:(nullable UIImage *)image selecteImage:(nullable UIImage *)selecteImage target:(nullable id)target action:( nonnull SEL)action cornerRadius:(NSInteger)size;
{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:sizeNum];
    btn.layer.cornerRadius = size;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:selecteImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(nullable UIImageView *)SL_UI_UIimg:(nullable UIImage *)image cornerRadius:(NSInteger)size;
{
    UIImageView *imageName =[[UIImageView alloc]init];
    imageName.image =image;
    imageName.layer.cornerRadius = size;
    imageName.layer.masksToBounds = YES;
    return imageName;
}
+(nullable UITextField *)SL_UI_Field:(nullable NSString *)placeholderString font:(NSInteger)sizeNum textAlignment:(NSTextAlignment)textAlignment borderStyle:(UITextBorderStyle)borderStyle clearOnBeginEditing:(BOOL)clear secure:(BOOL)secure keyBoardStyle:(UIKeyboardType)keyBoardStyle;
{
    UITextField * textField =[[UITextField alloc]init];
    textField.placeholder =placeholderString;
    textField.font =[UIFont boldSystemFontOfSize:sizeNum];
    textField.textAlignment =textAlignment;
    textField.borderStyle =borderStyle;
    textField.clearsOnBeginEditing =clear;
    textField.secureTextEntry =secure;
    textField.keyboardType =keyBoardStyle;
    return textField;
}
+(nullable UILabel *)SL_NavTitle:(nullable NSString *)title;
{
    UILabel * label =[[UILabel alloc]init];
    label.bounds =CGRectMake(0, 0, 100, 25);
    label.text =title;
    label.textColor =[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0];
    label.font =[UIFont systemFontOfSize:16];
    label.numberOfLines =2;
    label.textAlignment =NSTextAlignmentCenter;
    
    return label;
}

+(nullable UIBarButtonItem *)SL_BackBtn:(nullable UIImage *)image target:(nullable id)target action:(nonnull SEL)action;
{
    UIButton * backBtn =[F_UI SL_UI_Btn:nil Color:nil Font:1 bgimage:image selecteImage:nil target:target action:action cornerRadius:0];
    backBtn.bounds =CGRectMake(0, 0, 10, 17.42);
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    return backItem;
}
+(nullable UILabel *)SL_AnimationLabel:(nullable NSString *)string;
{
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(d_Device_width * 0.1, d_Device_height * 0.88, d_Device_width * 0.8, d_Device_height * 0.08)];
    label.text =string;
    label.font =[UIFont systemFontOfSize:14];
    label.backgroundColor =[UIColor blackColor];
    label.textColor =[UIColor whiteColor];
    label.textAlignment =NSTextAlignmentCenter;
    label.layer.cornerRadius =5;
    label.layer.masksToBounds =YES;
    label.numberOfLines =2;
    
    [UIView  animateWithDuration:2 animations:^{
        label.alpha =0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
    
    return label;
}

+ (UIButton *_Nullable)creatBtnWithTager:(nullable id)target title:(NSString *)title font:(NSInteger)font image:(UIImage *)image backImage:(UIImage *)backiamge color:(UIColor *)color textColor:(UIColor *)textColor cornerRadius:(CGFloat)radius action:(SEL)action{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    if (title.length) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (backiamge) {
        [btn setBackgroundImage:backiamge forState:UIControlStateNormal];
    }
    if (color) {
        btn.backgroundColor = color;
    }
    if (textColor) {
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (radius) {
        btn.layer.cornerRadius = radius;
        btn.layer.masksToBounds = YES;
    }
    if (font) {
        btn.titleLabel.font = [UIFont fontSize:font];
    }
    if (action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

@end
