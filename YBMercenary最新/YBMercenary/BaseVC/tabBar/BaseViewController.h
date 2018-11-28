//
//  BaseViewController.h
//  DSSManito
//
//  Created by Sunny on 2018/2/1.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic ,copy)NSString *shareUrl;
@property (nonatomic ,copy)NSString *shareTitle;
@property (nonatomic ,copy)NSString *shareDesion;

-(void)showShareView;
-(void)pushToChatViewControllerWithChatId:(NSString *)chatID title:(NSString *)title;
@end
