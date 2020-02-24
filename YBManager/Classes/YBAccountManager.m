//
//  YBAccountManager.m
//  YBManager_Example
//
//  Created by 氧车乐 on 2019/12/24.
//  Copyright © 2019 476018863@qq.com. All rights reserved.
//

#import "YBAccountManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <arpa/inet.h>

@implementation YBAccountManager

@synthesize accountCache = _accountCache;

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static YBAccountManager *sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [[YBAccountManager alloc]init];
    });
    
    return sharedManager;
}

- (YYCache *)accountCache{
    if (!_accountCache) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [paths lastObject];
        NSString *path = [docPath stringByAppendingPathComponent:kAccountCacheFileName];
        [self moveAccountCacheTo:path];
        _accountCache = [YYCache cacheWithPath:path];
        [_accountCache.memoryCache setCostLimit:50 * 1000 * 1000];//50M
        [_accountCache.memoryCache setAgeLimit:2 * 60];
    }
    return _accountCache;
}

- (void)moveAccountCacheTo:(NSString *)aPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cacheFolder stringByAppendingPathComponent:kAccountCacheFileName];
    
    if ([manager fileExistsAtPath:filePath]) {
        if ([manager moveItemAtPath:filePath toPath:aPath error:nil]) {
            NSLog(@"kAccountCacheFileName移动成功");
        } else {
            NSLog(@"kAccountCacheFileName移动失败");
            if ([manager removeItemAtPath:filePath error:nil]) {
                NSLog(@"kAccountCacheFileName删除成功");
            }else{
                NSLog(@"kAccountCacheFileName删除失败");
            }
        }
    }
}

- (void)setIsLogin:(BOOL)isLogin{
    [self.accountCache setObject:@(isLogin) forKey:kCache];
}

-(BOOL)isLogin{
    return ((NSNumber *)[self.accountCache objectForKey:kCache]).boolValue;
}

-(void)setUserName:(NSString *)userName{
    [self.accountCache setObject:userName forKey:kCache];
}
-(NSString *)userName{
    return (NSString *)[self.accountCache objectForKey:kCache];
}


-(void)setUserPassword:(NSString *)userPassword{
    [self.accountCache setObject:userPassword forKey:kCache];
}
-(NSString *)userPassword{
    return (NSString *)[self.accountCache objectForKey:kCache];
}


-(void)setToken:(NSString *)token{
    [self.accountCache setObject:token forKey:kCache];
}
-(NSString *)token{
    return (NSString *)[self.accountCache objectForKey:kCache];
}

-(void)setUnreadMessageCount:(NSString *)unreadMessageCount{
    [self.accountCache setObject:unreadMessageCount forKey:kCache];
}
-(NSString *)unreadMessageCount{
    return (NSString *)[self.accountCache objectForKey:kCache];
}


-(void)loginOut:(loginOutBlock)block{
    [self.accountCache removeAllObjects];//清空数据
    [YBAccountManager shared].isLogin = NO;
    if (block) {
        block();
    }
}
@end
