//
//  YBMyGeneralizeViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyGeneralizeViewController.h"

@interface YBMyGeneralizeViewController ()
@property (nonatomic ,strong)UIWebView *webV;
@end

@implementation YBMyGeneralizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:SetImage(@"分享") style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view addSubview:self.webV];
    [self.webV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UIWebView *)webV{
    if (!_webV) {
        _webV = [[UIWebView alloc]init];
        _webV.backgroundColor = [UIColor whiteColor];
    }
    return _webV;
}
-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    [self.webV loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
}

-(void)shareBtnClick{
    self.shareUrl = self.urlStr;
    self.shareTitle = @"佣兵天下";
    self.shareDesion = @"佣兵旨在为优秀的个人自由创业者提升服务质量，简化沟通，让优秀的创业者更专心的为用户提供更好的服务，更搞笑的打造自己的品牌。";
    [self showShareView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
