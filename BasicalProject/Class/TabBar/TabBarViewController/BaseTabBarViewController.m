//
//  LoanBusinessTabBarViewController.m
//  XWSDCarLoan
//
//  Created by chenjintian on 17/4/17.
//  Copyright © 2017年 XWSD. All rights reserved.
//

#import "BaseTabBarViewController.h"

#import "BaseTabBarView.h"
#import "UIButton+Badge.h"

@interface BaseTabBarViewController ()
{
    bool tabBarIsShow;
}
/// tabbar代替视图
@property (nonatomic, strong) BaseTabBarView *tabBarBackgroupView;
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupTabBar];
    [self addListener];
    tabBarIsShow = YES;
    
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    UINavigationController *missionNavi = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    UINavigationController *personNavi = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    UINavigationController *messageNavi = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    
    self.navigationArr = @[homeNavi,missionNavi,personNavi,messageNavi];
    for (UINavigationController *navi in self.navigationArr) {
        [self setupNavi:navi];
        
    }
}

#pragma mark- <UINavigationControllerDelegate>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 防止多次进入底部后出现白条
    self.view.subviews[0].frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    [self.tabBar removeFromSuperview];
    
    if (viewController.hidesBottomBarWhenPushed) {
        [self hideTabBar];
    }
    else {
        [self showTabBar];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.childViewControllers.count > 1) {
    [navigationController.interactivePopGestureRecognizer.view.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        /// 在子页面中取消手势操作
        if ([obj isMemberOfClass:[UIPanGestureRecognizer class]]) {
            obj.enabled = NO;
        }
    }];
    }
}
#pragma mark- event response
- (void)tabBarClicked:(UIButton *)sender {
    NSInteger index = [self.tabBarBackgroupView.tabBarBtnArr indexOfObject:sender];
    for (UIButton *button in self.tabBarBackgroupView.tabBarBtnArr) {
        button.selected = (button == sender);
    }
    [self setSelectedIndex:index];
}

/// 隐藏底部栏
- (void)hideTabBar {
    if (!tabBarIsShow) { //already hidden
        return;
    }
    [UIView animateWithDuration:0.35 animations:^{
        self.tabBarBackgroupView.y = Screen_Height;
    }];
    tabBarIsShow = NO;
}

/// 显示底部栏
- (void)showTabBar {
    if (tabBarIsShow) { // already showing
        return;
    }
    [UIView animateWithDuration:0.35 animations:^{
        self.tabBarBackgroupView.y = Screen_Height-49;
    }];
    tabBarIsShow = YES;
}

#pragma mark- public method
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    for (UIButton *button in self.tabBarBackgroupView.tabBarBtnArr) {
        button.selected = false;
    }
    ((UIButton*)self.tabBarBackgroupView.tabBarBtnArr[selectedIndex]).selected = true;
}

#pragma mark- private method
/// 设置导航栏
- (void)setupNavi:(UINavigationController *)navi {
    [self addChildViewController:navi];
    navi.delegate = self;
}

/// 设置导航栏
- (void)setupTabBar {
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview];
    
    [self.view addSubview:self.tabBarBackgroupView];
    
    for (int i=0; i<self.tabBarBackgroupView.tabBarBtnArr.count; i++) {
        // 点击事件
        [self.tabBarBackgroupView.tabBarBtnArr[i] addTarget:self action:@selector(tabBarClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/// 增加监听
- (void)addListener {
    // 增加notificationCenter监听
    
}

#pragma mark- getter/setter
- (UIView *)tabBarBackgroupView {
    if (!_tabBarBackgroupView) {
        _tabBarBackgroupView = [[BaseTabBarView alloc] initWithFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
        
        _tabBarBackgroupView.backgroundColor = [UIColor whiteColor];
    }
    return _tabBarBackgroupView;
}

@end
