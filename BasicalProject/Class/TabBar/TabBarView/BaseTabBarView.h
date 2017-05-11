//
//  LoanBusinessTabbarView.h
//  XWSDCarLoan
//
//  Created by chenjintian on 17/4/24.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义 tabbar
 */
@interface BaseTabBarView : UIView
/// 按钮数组
@property (nonatomic, copy) NSArray<UIButton *> *tabBarBtnArr;
@end
