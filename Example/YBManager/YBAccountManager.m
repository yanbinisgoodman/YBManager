//
//  YBAccountManager.m
//  YBManager_Example
//
//  Created by 氧车乐 on 2019/12/24.
//  Copyright © 2019 476018863@qq.com. All rights reserved.
//

#import "YBAccountManager.h"

@implementation YBAccountManager

+ (YBAccountManager *)shared{
    static dispatch_once_t once = 0;
    static YBAccountManager *countManager;
    dispatch_once(&once, ^{
        countManager = [[YBAccountManager alloc] init];
    });
    return countManager;
}
@end
