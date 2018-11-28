//
//  ZJNRulesViewController.m
//  YBMercenary
//
//  Created by 险峰科技 on 2018/9/6.
//  Copyright © 2018年 xfkeji_yongbing. All rights reserved.
//

#import "ZJNRulesViewController.h"

@interface ZJNRulesViewController ()
@property (nonatomic ,strong)UIWebView *webV;
@end

@implementation ZJNRulesViewController

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
-(void)setType:(NSString *)type{

    NSString *urlStr = [NSString stringWithFormat:@"%@/%@?type=%@",HOST,@"register/zhunze.html",type];
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
