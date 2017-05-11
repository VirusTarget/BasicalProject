//
//  XWSDKeyChain.h
//  XWSDCarLoan
//
//  Created by chenjintian on 17/2/13.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 密码本地化
 */
@interface BaseKeyChain : NSObject

/**
 保存加密数据到本地

 @param service 服务
 @param account 账号
 @param data 数据
 */
+ (void)save:(NSString *)service account:(NSString *)account data:(id)data;

/**
 获取保存到本地的加密数据
 
 @param service 服务
 @param account 账号
 */
+ (id)load:(NSString *)service account:(NSString *)account;

/**
 删除保存到本地的加密数据
 
 @param service 服务
 @param account 账号
 */
+ (void)delete:(NSString *)service account:(NSString *)account;

@end
