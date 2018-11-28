//
//  BaseTableVC.m
//  YBMercenary
//
//  Created by 龙青磊 on 2018/3/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor hex:Back_Color];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self configTableView];
}

- (void)configTableView{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor hex:Back_Color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)reloadTableView{
    KWeakSelf(self);
    [KVNProgress dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.tableView reloadData];
    });
    
}

@end
