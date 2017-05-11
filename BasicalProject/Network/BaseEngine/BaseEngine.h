//
//  BaseRequest.h
//  XWSDCarLoan
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetClient.h"

@interface BaseAPIConfig : NSObject
/// 地址
@property (nonatomic, copy) NSString *url;
/// 方法
@property (nonatomic, copy) NSString *method;
/// 参数
@property (nonatomic, copy) NSDictionary *param;

@end
/**
 基础请求
 */
@interface BaseEngine : NSObject <NetClientDelegate>
/// 成功回调
@property (nonatomic, strong) void (^success)(NSDictionary* dict);
/// 失败回调
@property (nonatomic, strong) void (^fail)(NSDictionary* dict);
/// 数据任务
@property (nonatomic, strong) NSURLSessionDataTask *task;
/// 接口配置
@property (nonatomic, strong) BaseAPIConfig *config;

#pragma mark- method
/**
 上传并返回数值
 */
- (void)startRequestWithConfig:(BaseAPIConfig *)config
                 successBlock:(void(^)(NSDictionary* dict))successBlock
                    failBlock:(void(^)(NSDictionary* dict))failBlock;

/**
 上传并返回数值
 */
- (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock;

/**
 取消任务
 */
- (void)cancleTask;
@end
