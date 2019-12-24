//
//  YBAccountManager.h
//  YBManager_Example
//
//  Created by 氧车乐 on 2019/12/24.
//  Copyright © 2019 476018863@qq.com. All rights reserved.
//

#define kCache (NSStringFromSelector(_cmd).KeyForGS)
#define kAccountCacheFileName @"kAccountCacheFileName"


#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "NSString+KeyForGetterSetter.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^loginOutBlock)(void);  //获取随机数

@interface YBAccountManager : NSObject

+ (instancetype)shared;

@property (strong, atomic, readonly) YYCache *accountCache;

///是否登录成功
@property(assign,atomic)BOOL isLogin;

/// 账户名称
@property(strong,atomic) NSString * userName;

 ///密码
@property(strong,atomic) NSString * userPassword;

/// token
@property(strong,atomic) NSString * token;

/// 未读消息的数量
@property (strong,atomic) NSString * unreadMessageCount;

///退出登录
- (void)loginOut:(loginOutBlock)block;

@end

NS_ASSUME_NONNULL_END
