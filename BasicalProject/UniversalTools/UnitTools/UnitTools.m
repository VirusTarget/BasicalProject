//
//  UNIT.m
//  Car-Loan
//
//  Created by chenjintian on 16/9/30.
//  Copyright © 2016年 微小时贷. All rights reserved.
//

#import "UnitTools.h"

#import <sys/utsname.h>

@implementation UnitTools

+ (NSString *)Share_StringDateFromFormatter {
    static  NSDateFormatter *formatter  ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter   = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddhhmmss";
    });
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSDictionary *)ArrDictFromDict:(NSDictionary *)dict WithKey:(NSString *)Key{
    NSMutableDictionary *mutableDict    =   [NSMutableDictionary dictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            for (int i=0; i<((NSArray *)obj).count; i++) {
                NSString    *mutableKey =   [NSString stringWithFormat:@"%@[%@]",Key,key];
                if ([obj[i] isKindOfClass:[NSDictionary class]]) {
                    [mutableDict addEntriesFromDictionary:[self ArrDictFromDict:obj[i] WithKey:mutableKey]];
                }
                else {
                    mutableDict[mutableKey] =   [NSString stringWithFormat:@"%@",obj];
                }
            }
        }
        
        else {
            NSString    *mutableKey =   [NSString stringWithFormat:@"%@[%@]",Key,key];
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [mutableDict addEntriesFromDictionary:[self ArrDictFromDict:obj WithKey:mutableKey]];
            }
            else
                mutableDict[mutableKey] =   [NSString stringWithFormat:@"%@",obj];
        }
        
    }];
    
    return mutableDict;
};

+ (NSString *)dictString:(NSString *)string {
    if (!string || [string isEqual:[NSNull null]]) {
        return @"";
    }
    if (![string isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",string];
    }
    return string;
}

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC;
        while (((UIViewController *)nextResponder).presentedViewController) {
            nextResponder = ((UIViewController *)nextResponder).presentedViewController;
        }
        
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UIViewController * viewController = tabbar.viewControllers[tabbar.selectedIndex];
        //        UIViewController * viewController = tabbar.selectedViewController ; 上下两种写法都行
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            result=viewController.childViewControllers.lastObject;
        }
        else{
            result=viewController;
        }
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

+ (NSString *)jsonStringFormDict:(NSDictionary *)dict {
    NSMutableString *jsonString = [NSMutableString string];
    [jsonString appendString:@"{"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (jsonString.length > 1) {
            [jsonString appendString:@","];
        }
        [jsonString appendFormat:@"\"%@\":",key];
        
        if ([obj isKindOfClass:[NSArray class]]) {
            [jsonString appendString:[self jsonStringFormArray:obj]];
        }
        
        else {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [jsonString appendString:[self jsonStringFormDict:obj]];
            }
            else {
                [jsonString appendFormat:@"\"%@\"",obj];
            }
        }
    }];
    [jsonString appendString:@"}"];
    return jsonString;
}

+ (NSString *)jsonStringFormArray:(NSArray *)array {
    NSMutableString *jsonString = [NSMutableString string];
    [jsonString appendString:@"["];
    
    for (int i=0; i<array.count; i++) {
        
        if (i != 0) {
            [jsonString appendString:@","];
        }
        if ([array[i] isKindOfClass:[NSDictionary class]]) {
            [jsonString appendString:[self jsonStringFormDict:array[i]]];
        }
        else {
            if ([array[i] isKindOfClass:[NSArray class]]) {
                [jsonString appendString:[self jsonStringFormArray:array[i]]];
            }
            else {
                [jsonString appendFormat:@"\"%@\"",array[i]];
            }
        }
    }
    [jsonString appendString:@"]"];
    return jsonString;
}

+ (NSString *)deviceType {
    NSString *deviceType = @"";
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) deviceType = @"iPhone2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) deviceType = @"iPhone3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) deviceType = @"iPhone3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) deviceType = @"iPhone4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) deviceType = @"iPhone4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) deviceType = @"iPhone4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) deviceType = @"iPhone4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) deviceType = @"iPhone5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) deviceType = @"iPhone5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) deviceType = @"iPhone5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) deviceType = @"iPhone5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) deviceType = @"iPhone5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) deviceType = @"iPhone5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) deviceType = @"iPhone6Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) deviceType = @"iPhone6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) deviceType = @"iPhone6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) deviceType = @"iPhone6sPlus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) deviceType = @"iPhoneSE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) deviceType = @"iPhone7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) deviceType = @"iPhone7Plus";
    return deviceType;
}

+ (UIImage *)screenShot {
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:context];
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

