//
//  NSString+KeyForGetterSetter.m
//  customer
//
//  Created by yan on 2018/7/8.
//  Copyright © 2017年 Ningbo Otoc Automobile Service Co.,ltd. All rights reserved.
//

#import "NSString+KeyForGetterSetter.h"

@implementation NSString (KeyForGetterSetter)

- (NSString *)KeyForGS{
    return [self hasPrefix:@"set"] ? [self keyForSetter] : [self keyForGetter];
}

- (NSString *)keyForGetter{
    return self.lowercaseString;
}

- (NSString *)keyForSetter{
    return [[self substringToIndex:self.length - 1]substringFromIndex:@"set".length].lowercaseString;
}

@end
