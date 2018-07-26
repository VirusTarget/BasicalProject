//
//  BaseModel.m
//  BasicalProject
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (BaseModel *)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self loadDict:dict];
    }
    return self;
}

- (void)loadDict:(NSDictionary *)dict {
    unsigned int count = 0;
    
    // 拷贝出变量列表
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        objc_property_t property = properties[i];
        
        // 成员变量名字
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        
        // 属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
        
        // 只针对对象的处理
        NSString *classString = [NSString stringWithFormat:@"%s",attrs[0].value];
        if ([classString hasPrefix:@"@\""] && classString.length > 3) {
            classString = [classString substringWithRange:NSMakeRange(2, classString.length-3)];
        }
        Class keyClass = NSClassFromString(classString);
        
        if (dict[key]) {
            if ([dict[key] isEqual:[NSNull null]]) {
                [self setValue:[keyClass new] forKey:key];
            }
            else {
                if ([keyClass isEqual:[NSString class]]) {
                    [self setValue:[NSString stringWithFormat:@"%@",dict[key]] forKey:key];
                }
                else if ([keyClass isEqual:[NSArray class]]) {
                    NSArray *protocols = [self getProtocolArrayFromAttribute:attrs attributeCount:attrCount inString:classString];
                    if (protocols && protocols.count) {
                        keyClass = NSClassFromString(protocols[0]);
                    }
                    [self setValue:dict[key] forKey:key];
                }
                else {
                    [self setValue:dict[key] forKey:key];
                }
            }
        }
        else {
            [self setValue:[keyClass new] forKey:key];
        }
    }
    
    // 释放
    free(properties);
}

- (NSArray *)getProtocolArrayFromAttribute:(objc_property_attribute_t *)attri attributeCount:(unsigned int)attrCount inString:(NSString *)string {
    NSMutableArray *protocols = nil;
    for (unsigned int i = 0; i < attrCount; i++) {
        if (attri[i].name[0] == 'P') {
            NSScanner *scanner = [NSScanner scannerWithString:string];
            while ([scanner scanString:@"<" intoString:NULL]) {
                NSString* protocol = nil;
                if ([scanner scanUpToString:@">" intoString: &protocol]) {
                    if (protocol.length) {
                        if (!protocols) protocols = [NSMutableArray new];
                        [protocols addObject:protocol];
                    }
                }
                [scanner scanString:@">" intoString:NULL];
            }
        }
    }
    return [protocols copy];
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
    
    // 拷贝出变量列表
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        objc_property_t property = properties[i];
        
        // 成员变量名字
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        
        if ([self valueForKey:key])
            dict[key] = [self valueForKey:key];
        else {
            dict[key] = @"";
        }
    }
    
    // 释放
    free(properties);
    return dict;
}
@end
