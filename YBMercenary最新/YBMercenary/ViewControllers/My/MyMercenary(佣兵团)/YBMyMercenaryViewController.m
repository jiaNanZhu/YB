//
//  YBMyMercenaryViewController.m
//  YBMercenary
//
//  Created by 飞哥 on 2018/3/23.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "YBMyMercenaryViewController.h"

@interface YBMyMercenaryViewController ()

@end

@implementation YBMyMercenaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *tip=[[UILabel alloc]init];
    tip.frame=self.view.frame;
    tip.textAlignment=NSTextAlignmentCenter;
    tip.text=@"敬请期待";
    [self.view addSubview:tip];
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
