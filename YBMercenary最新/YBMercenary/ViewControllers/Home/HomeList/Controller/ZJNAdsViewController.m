//
//  ZJNAdsViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/8/10.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNAdsViewController.h"

@interface ZJNAdsViewController ()
@property (nonatomic ,strong)UIWebView *webV;
@end

@implementation ZJNAdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
