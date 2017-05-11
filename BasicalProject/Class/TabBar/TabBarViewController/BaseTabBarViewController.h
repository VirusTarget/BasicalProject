//
//  LoanBusinessTabBarViewController.h
//  XWSDCarLoan
//
//  Created by chenjintian on 17/4/17.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义 TabBar 控制器
 */
@interface BaseTabBarViewController : UITabBarController <UINavigationControllerDelegate>

/// 导航栏数据
@property (nonatomic, strong) NSArray<UINavigationController *> *navigationArr;

@end
