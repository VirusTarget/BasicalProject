//
//  UploadEngine.m
//  BasicalProject
//
//  Created by chenjintian on 17/5/10.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "UploadEngine.h"

@implementation UploadEngine

#pragma mark- public method
- (void)cancleTask {
    return;
}

+ (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock {
    
    [[UploadEngine new] startRequestWithConfig:config successBlock:successBlock failBlock:nil];
}

+ (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock
                     failBlock:(void(^)(NSDictionary* dict))failBlock {
    [[UploadEngine new] startRequestWithConfig:config successBlock:successBlock failBlock:failBlock];
}

@end
