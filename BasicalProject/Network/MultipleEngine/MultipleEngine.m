//
//  MultipleEngine.m
//  BasicalProject
//
//  Created by chenjintian on 17/5/10.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "MultipleEngine.h"

@implementation MultipleEngine

#pragma mark- <NetClientDelegate>
- (void)netClientSuccess:(NSDictionary *)successDict WithTask:(NSURLSessionDataTask *)task {
    if ([self.tasksArray containsObject:task]) {
        [self.tasksArray removeObject:task];
    }
    
    if (self.success) {
        self.success(successDict);
    }
}

- (void)netClientFail:(NSDictionary *)failDict WithTask:(NSURLSessionDataTask *)task {
    if ([self.tasksArray containsObject:task]) {
        [self.tasksArray removeObject:task];
    }
    if (self.fail) {
        self.fail(failDict);
    }
}
#pragma mark- public method
- (void)cancleAllTask {
    for (NSURLSessionDataTask *task in self.tasksArray) {
        [[NetClient shareNetClient] cancleTask:task];
    }
    [self.tasksArray removeAllObjects];
}

- (void)cancleTaskAtIndex:(NSInteger)index {
    if (index >= self.tasksArray.count) {
        return;
    }
    [[NetClient shareNetClient] cancleTask:self.tasksArray[index]];
    [self.tasksArray removeObjectAtIndex:index];
}

- (void)cancleTask {
    if (self.task && [self.task respondsToSelector:@selector(cancel)]) {
        [[NetClient shareNetClient] cancleTask:self.task];
        self.task = nil;
        [self.tasksArray removeObject:self.task];
    }
    
}
- (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock
                     failBlock:(void(^)(NSDictionary* dict))failBlock {
    // 只保存一次的task
    [super startRequestWithConfig:config successBlock:successBlock failBlock:failBlock];
    [self.tasksArray addObject:self.task];
}

#pragma mark - getter/setter
- (NSMutableArray *)tasksArray {
    if (!_tasksArray) {
        _tasksArray = [NSMutableArray array];
    }
    return _tasksArray;
}
@end
