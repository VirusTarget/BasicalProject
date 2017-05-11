//
//  Func.h
//  OrangeLife
//
//  Created by OrangeLife on 15/11/5.
//  Copyright © 2015年 Shenme Studio. All rights reserved.
//

#ifndef Func_h
#define Func_h

#pragma mark - 数据安全
#define NotNull(obj) ([(obj) isEqual:[NSNull null]] ? nil : (obj))
#define NotNullSrt(str) NotNull(str)?str:(@"")
#define toString(obj) [NSString stringWithFormat:@"%@",NotNull(obj)]
#define toNullStr(obj) ([toString(obj) isEqualToString:@"(null)"] ? @"" : toString(obj))
//直接使用吐司的宏
#define TOAST(STR) [SCToastView toastFontDisplay:STR];
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)

#endif

#pragma mark - 非法判断
#define NSArrayIsValid(array) ((array) && ![(array) isEqual:[NSNull null]] && (array).count)
#define NSStringIsValid(string) ((string) && ![(string) isEqual:[NSNull null]] && (string).length)
#define NSDictionaryIsValid(dictionary) ((dictionary) && ![(dictionary) isEqual:[NSNull null]] && (dictionary).count)

#endif /* Func_h */
