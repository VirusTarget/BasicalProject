//
//  BaseViewController.m
//  ConsumerFinance
//
//  Created by chenjintian on 16/10/24.
//  Copyright © 2016年 XWSD. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 直接使用 UIBarButtonItem 有时候会出现bug
    UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
    [aButton setImage:[UIImage imageNamed:@"navagation_back"] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *anUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = anUIBarButtonItem;
    
    // 标题字体颜色
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    // bar 的背景色
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    // bar 不透明
    self.navigationController.navigationBar.translucent = NO;
    // 视图默认背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.hidesBottomBarWhenPushed = (self.navigationController.childViewControllers.firstObject != self );
}

#pragma mark- event response

/**
 返回
 */
- (void)back {
    if (self.navigationController.childViewControllers.firstObject == self)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI {
    
}

- (void)placeSubviews {
    
}

- (void)addListener {
    
}
@end
