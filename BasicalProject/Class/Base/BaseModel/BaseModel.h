//
//  BaseModel.h
//  BasicalProject
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 基础模型
 */
@interface BaseModel : NSObject

/// 属性字典
@property (nonatomic, copy, readonly) NSDictionary *modelDict;

#pragma mark- method

/**
 通过字典初始化模型
 
 @param dict 源字典数据
 @return 模型
 */
+ (BaseModel *)modelWithDict:(NSDictionary *)dict;

/**
 通过字典初始化模型
 
 @param dict 源字典数据
 @return 模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 加载字典
 */
- (void)loadDict:(NSDictionary *)dict;
@end
