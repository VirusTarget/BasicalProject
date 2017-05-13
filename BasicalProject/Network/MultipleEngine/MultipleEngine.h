//
//  MultipleEngine.h
//  BasicalProject
//
//  Created by chenjintian on 17/5/10.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "BaseEngine.h"

/**
 同一时间单个对象可能会进行多个任务
 */
@interface MultipleEngine : BaseEngine

/// 任务数组
@property (nonatomic, strong) NSMutableArray *tasksArray;

@end
