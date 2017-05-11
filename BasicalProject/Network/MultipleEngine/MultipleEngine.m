//
//  MultipleEngine.m
//  BasicalProject
//
//  Created by chenjintian on 17/5/10.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "MultipleEngine.h"

@implementation MultipleEngine
- (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock
                     failBlock:(void(^)(NSDictionary* dict))failBlock {
    // 只保存一次的task
    [super startRequestWithConfig:config successBlock:successBlock failBlock:failBlock];
}
@end
