//
//  BaseRequest.m
//  XWSDCarLoan
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import "BaseEngine.h"

@implementation BaseEngine

#pragma mark- <NetClientDelegate>
- (void)netClientSuccess:(NSDictionary *)successDict {
    self.task = nil;
    if (self.success) {
        self.success(successDict);
    }
}

- (void)netClientFail:(NSDictionary *)failDict {
    self.task = nil;
    if (self.fail) {
        self.fail(failDict);
    }
}

#pragma mark- public method
- (void)cancleTask {
    if (self.task && [self.task respondsToSelector:@selector(cancel)]) {
        [[NetClient shareNetClient] cancleTask:self.task];
        self.task = nil;
    }
    
}

- (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock {
    [self startRequestWithConfig:config successBlock:successBlock failBlock:nil];
}

- (void)startRequestWithConfig:(BaseAPIConfig *)config
                 successBlock:(void(^)(NSDictionary* dict))successBlock
                    failBlock:(void(^)(NSDictionary* dict))failBlock {
    self.success = successBlock;
    self.fail = failBlock;
    self.task = [[NetClient shareNetClient] postToMethod:config.method WithDict:config.param delegate:self];
}
@end
