//
//  BaseView.h
//  BasicalProject
//
//  Created by chenjintian on 17/5/2.
//  Copyright © 2017年 CJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewProtocol <NSObject>

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
 基础视图
 */
@interface BaseView : UIView <BaseViewProtocol>

@end
