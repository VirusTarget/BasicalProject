//
//  SCToastView.h
//  Sannong12316
//
//  Created by 广为网络 on 16/7/28.
//  Copyright © 2016年 广为网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCToastView : UIView
{
    NSInteger _timeInt;//时间
    NSTimer * _timer;//定时器
}
@property (nonatomic,strong)UILabel * toastLabel;
//初始化单列类
+ (id)toastViewMain;
//字体显示
+ (void)toastFontDisplay:(NSString *)string;
@end
