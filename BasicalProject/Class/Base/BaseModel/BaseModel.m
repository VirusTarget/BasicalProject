//
//  BaseModel.m
//  BasicalProject
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

+ (BaseModel *)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark- public method
- (NSString *)debugDescription {
    return [self description];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.missionDict];
}

#pragma mark- private method

/**
 字典字符串处理

 @param string 字典字符串
 @return 字符串判断空处理
 */
- (NSString *)dictString:(NSString *)string {
    if (!string || [string isEqual:[NSNull null]]) {
        return @"";
    }
    if (![string isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",string];
    }
    return string;
}

#pragma mark- getter/setter
- (NSDictionary *)missionDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    
    // 拷贝出所胡的成员变量列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        
        // 成员变量名字
        NSString *key = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        // 成员变量的数据类型
//        NSString *value = [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        if ([self valueForKey:key])
            dict[key] = [self valueForKey:key];
        else {
            dict[key] = @"";
        }
    }
    
    // 释放
    free(ivars);
    return dict;
}
@end
