//
//  TableInfoEngine.m
//  BasicalProject
//
//  Created by chenjintian on 17/5/10.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "TableInfoEngine.h"

@implementation TableInfoEngine

#pragma mark- public method
- (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock
                     failBlock:(void(^)(NSDictionary* dict))failBlock {
    // 只保存一次的task
    if (self.task && [self.task respondsToSelector:@selector(cancel)]) {
        [self.task cancel];
    }
    
    [super startRequestWithConfig:config successBlock:successBlock failBlock:failBlock];
}

@end
