//
//  LoanBusinessTabbarView.m
//  XWSDCarLoan
//
//  Created by chenjintian on 17/4/24.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import "BaseTabBarView.h"

#import "UIView+Base.h"

#define Screen_Width  [[UIScreen mainScreen] bounds].size.width//设备宽度
#define Screen_Height [[UIScreen mainScreen] bounds].size.height//设备高度
@implementation BaseTabBarView
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self createUI];
    }
}

- (void)createUI {
    NSMutableArray *tabbarBtnArr = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIButton *tabBarBtn = [UIButton buttonWithType:0];
        [tabBarBtn setTitle:@[@"首页",@"任务",@"我的",@"信息"][i] forState:UIControlStateNormal];
        
        [tabBarBtn setTitleColor:COLOR_HEX(0x999999) forState:UIControlStateNormal];
        [tabBarBtn setTitleColor:COLOR_HEX(0x32a9f2) forState:UIControlStateSelected];
        [tabBarBtn setImage:[UIImage imageNamed:@[@"home_menu_home-Selected",@"home_menu_task-Selected",@"home_menu_my-Selected",@"home_menu_news-Selected"][i]] forState:UIControlStateSelected];
        [tabBarBtn setImage:[UIImage imageNamed:@[@"home_menu_home-Unchecked",@"home_menu_task-Unchecked",@"home_menu_my-Unchecked",@"home_menu_news-Unchecked"][i]] forState:UIControlStateNormal];
        
        tabBarBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        tabBarBtn.frame = CGRectMake(i*Screen_Width/4.0,0,Screen_Width/4.0,49);
        [self addSubview:tabBarBtn];
        
        tabBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [tabBarBtn setTitleEdgeInsets:UIEdgeInsetsMake(tabBarBtn.imageView.frame.size.height+10,-tabBarBtn.imageView.width, 0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [tabBarBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,20, -tabBarBtn.titleLabel.width)];//图片距离右边框距离减少图片的宽度，其它不边
        
        [tabbarBtnArr addObject:tabBarBtn];
        
        [tabBarBtn addTarget:self action:@selector(addAnimationToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.tabBarBtnArr = tabbarBtnArr;
}

#pragma mark- private method

/// 增加按钮的点击动画
- (void)addAnimationToBtn:(UIButton *)sender {
    
    CALayer * animationLayer = [CALayer layer];
    animationLayer.frame = sender.bounds;
    CALayer * pulsingLayer = [CALayer layer];
    pulsingLayer.frame = CGRectMake(sender.width/2.0, sender.height/2.0, 10, 10);
    pulsingLayer.backgroundColor = [UIColor greenColor].CGColor;
    pulsingLayer.cornerRadius = 5;
    
    CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    // 组动画
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 0.5;
    animationGroup.repeatCount = 1;
    animationGroup.timingFunction = defaultCurve;
    
    // 缩放动画
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.4;
    scaleAnimation.toValue = @4.9;
    
    // 透明度动画
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
    opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
    [animationLayer addSublayer:pulsingLayer];
    
    [sender.layer addSublayer:animationLayer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationLayer removeFromSuperlayer];
    });
}

@end
