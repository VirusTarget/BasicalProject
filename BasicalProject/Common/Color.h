//
//  Color.h
//  OrangeLife
//
//  Created by OrangeLife on 15/11/5.
//  Copyright © 2015年 Shenme Studio. All rights reserved.
//

#ifndef Color_h
#define Color_h

#define COLOR_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]// RGB颜色转换
#define COLORWithAL_HEX(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]// 16进制颜色转换
#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]// 16进制颜色转换(不带透明度的)

#define kTextColor COLOR_HEX(0x000000)
#define kWhiteBgColor COLOR_HEX(0xffffff)
#define kMainBgColor  COLOR_HEX(0xf4faff)
#define kshadowColor COLOR_HEX(0x32a9f2)
#define klineViewColor COLOR_HEX(0xcccccc)
#define kcellLineColor COLOR_HEX(0xf4f4f4)

#endif /* Color_h */
