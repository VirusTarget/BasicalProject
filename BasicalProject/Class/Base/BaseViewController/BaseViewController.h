//
//  BaseViewController.h
//  ConsumerFinance
//
//  Created by chenjintian on 16/10/24.
//  Copyright © 2016年 XWSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewControllerProtocol <NSObject>

@optional
/**
 创建视图
 */
- (void)createUI;

/**
 设置视图尺寸等
 */
- (void)placeSubviews;

/**
 增加监听
 */
- (void)addListener;

@end

/**
 基础子类视图
 */
@interface BaseViewController : UIViewController <BaseViewControllerProtocol>

#pragma mark- method 

/**
 返回 可被子类覆盖
 */
- (void)back;
@end
