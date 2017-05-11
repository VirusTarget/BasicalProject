//
//  UNIT.h
//  Car-Loan
//
//  Created by chenjintian on 16/9/30.
//  Copyright © 2016年 微小时贷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SetToLocal(a,b) [[NSUserDefaults standardUserDefaults] setObject:a forKey:b]
#define GetFromLocal(a) [[NSUserDefaults standardUserDefaults] valueForKey:a]

@interface UnitTools : NSObject

/**
 返回目前时间的字符串
 */
+ (NSString *)Share_StringDateFromFormatter;

/**
 将字典中的数组的值返回到字典中
 */
+ (NSDictionary *)ArrDictFromDict:(NSDictionary *)dict WithKey:(NSString *)Key;

/**
 获取当前控制器
 */
+ (UIViewController *)getCurrentVC;
@end

/**
 字符串相关
 */
@interface UnitTools(jsonString)
/**
 字典转json字符串
 */
+ (NSString *)jsonStringFormDict:(NSDictionary *)dict;

/**
 数组转json字符串
 */
+ (NSString *)jsonStringFormArray:(NSArray *)array;

/**
 判断是否空字符串
 */
+ (NSString *)dictString:(NSString *)string;
@end

@interface UnitTools (System)

/**
 获取设备型号
 */
+ (NSString *)deviceType;

/**
 截屏
 */
+ (UIImage *)screenShot;
@end

