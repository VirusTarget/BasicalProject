//
//  Frame.h
//  OrangeLife
//
//  Created by OrangeLife on 15/11/5.
//  Copyright © 2015年 Shenme Studio. All rights reserved.
//

#ifndef Frame_h
#define Frame_h
#import <UIKit/UIKit.h>

#define Screen_Width  [[UIScreen mainScreen] bounds].size.width//设备宽度
#define Screen_Height [[UIScreen mainScreen] bounds].size.height//设备高度

#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)?YES:NO)

#define IOS8_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

const static CGFloat kNavHeight = 64.f;
const static CGFloat kInterval  = 10.f;
const static CGFloat kLineWidth = 0.5f;
const static CGFloat kCornerRadius = 5.f;
const static CGFloat kDockHeight = 50.f;
const static CGFloat kKeyboardHeight = 216.0f;
const static CGFloat kMinUserInteractionWidth = 40.f;
const static CGFloat kMinUserInteractionHeight = 40.f;
const static CGFloat MinFloat = 0.000000000000000000000000001f;
const static CGFloat kControlDefaultHeight = 44.0f;
const static CGFloat kControlDefaultMaxWidth = 80.0f;
const static CGFloat kTabbarHeight = 49.f;


#endif /* Frame_h */
