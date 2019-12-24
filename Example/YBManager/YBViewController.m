//
//  YBViewController.m
//  YBManager
//
//  Created by 476018863@qq.com on 08/29/2019.
//  Copyright (c) 2019 476018863@qq.com. All rights reserved.
//

#import "YBViewController.h"
#import "YBAccountManager.h"
@interface YBViewController ()

@end

@implementation YBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[YBAccountManager shared]loginOut:^{
        NSLog(@"退出登录后的操作2");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
