//
//  UploadEngine.h
//  BasicalProject
//
//  Created by chenjintian on 17/5/10.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import "BaseEngine.h"

/**
 类似上传的 api （不能取消的，无需实例化）
 */
@interface UploadEngine : BaseEngine


#pragma mark - method
/**
 上传并返回数值
 */
+ (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock
                     failBlock:(void(^)(NSDictionary* dict))failBlock;

/**
 上传并返回数值
 */
+ (void)startRequestWithConfig:(BaseAPIConfig *)config
                  successBlock:(void(^)(NSDictionary* dict))successBlock;
@end
