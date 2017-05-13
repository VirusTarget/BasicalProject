//
//  NetHelper.m
//  XWSDCarLoan
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import "NetClient.h"
#import "AFNetWorking.h"

@interface NetClient()
@property (nonatomic, strong) NSMutableArray<NSURLSessionDataTask *> *taskArray;
@end
@implementation NetClient
static NetClient *__shareClient;

#pragma mark- public method
+ (NetClient *)shareNetClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareClient = [[super allocWithZone:NULL] init];
    });
    return __shareClient;
}

+ (void)cancleAllTasks {
    [[NetClient shareNetClient] cancleAllTasks];
}

+ (void)cancleTask:(NSURLSessionDataTask *)task {
    [[NetClient shareNetClient] cancleTask:task];
}

- (void)cancleAllTasks {
    [self.taskArray enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    [self.taskArray removeAllObjects];
}

- (void)cancleTask:(NSURLSessionDataTask *)task {
    [task cancel];
    [self.taskArray removeObject:task];
}
/**
 使用AFNetworkingPost数据
 
 @param method 方法名
 @param dict   非固定参数
 @param delegate  委托实现
 */

- (NSURLSessionDataTask *)postToMethod:(NSString*)method WithDict:(NSDictionary*)dict delegate:(id)delegate {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /* Https 验证
     AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
     securityPolicy.validatesDomainName = NO;
     manager.securityPolicy = securityPolicy;
     */
    NSURLSessionDataTask *task = [manager POST:MAINURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.taskArray removeObject:task];
        
        if (/* DISABLES CODE */ (YES)) {
            if ([delegate respondsToSelector:@selector(netClientSuccess:WithTask:)]) {
                [delegate netClientSuccess:responseObject WithTask:(NSURLSessionDataTask *)task];
            }
        }
        else{
            if ([delegate respondsToSelector:@selector(netClientFail:WithTask:)]) {
                [delegate netClientFail:responseObject WithTask:(NSURLSessionDataTask *)task];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.taskArray removeObject:task];
        if ([delegate respondsToSelector:@selector(netClientFail:WithTask:)]) {
            [delegate netClientFail:nil WithTask:(NSURLSessionDataTask *)task];
        }
    }];
    
    [task resume];
    return task;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [NetClient shareNetClient];
}

- (id)copyWithZone:(NSZone *)zone{
    return [NetClient shareNetClient];
}

+ (id)copyWithZone:(struct _NSZone *)zone{
    return [NetClient shareNetClient];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [NetClient shareNetClient];
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return [NetClient shareNetClient];
}
@end
