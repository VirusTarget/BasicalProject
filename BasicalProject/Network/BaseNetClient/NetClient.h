//
//  NetHelper.h
//  XWSDCarLoan
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SVProgressHUD.h"

#define MAINURL @"http://xxx.xx"

@protocol NetClientDelegate <NSObject>

@required

/**
 请求成功

 @param successDict 请求结果
 */
- (void)netClientSuccess:(NSDictionary *)successDict;

@optional

/**
 请求失败

 @param failDict 失败原因
 */
- (void)netClientFail:(NSDictionary *)failDict;

@end

@interface NetClient : NSObject

@property (nonatomic, strong) id<NetClientDelegate> delegate;
#pragma mark- method

/**
 单例

 @return 返回单例
 */
+ (NetClient *)shareNetClient;

/**
 取消所有任务
 */
+ (void)cancleAllTasks;

/**
 取消单个任务

 @param task 任务
 */
+ (void)cancleTask:(NSURLSessionDataTask *)task;

/**
 取消所有任务
 */
- (void)cancleAllTasks;

/**
 取消单个任务
 
 @param task 任务
 */
- (void)cancleTask:(NSURLSessionDataTask *)task;

/**
 使用AFNetworkingPost数据
 
 @param method 方法名
 @param dict   非固定参数
 @param delegate  委托实现
 */
- (NSURLSessionDataTask *)postToMethod:(NSString*)method WithDict:(NSDictionary*)dict delegate:(id)delegate;

@end
