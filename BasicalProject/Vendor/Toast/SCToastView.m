//
//  SCToastView.m
//  Sannong12316
//
//  Created by 广为网络 on 16/7/28.
//  Copyright © 2016年 广为网络. All rights reserved.
//
#define Fnt [UIFont fontWithName:@"HelveticaNeue" size:17.0f]
#define TimeI 3

#import "SCToastView.h"

@implementation SCToastView
#pragma mark - 初始化
- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:0.7];
        self.clipsToBounds=YES;
        self.layer.cornerRadius=5;
        self.alpha=0;
        
      
    }
    return self;
}
//初始化单列类
+ (id)toastViewMain
{
    static SCToastView * toastView = nil;
    @synchronized(self) {
        if (!toastView) {
            toastView = [[self alloc] init];
        }
    }
    return toastView;
}
+ (void)toastFontDisplay:(NSString *)string
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [[self toastViewMain] allocToastFontDisplay:string];
    });
}
- (void)allocToastFontDisplay:(NSString *)string
{
    if (self.toastLabel == nil) {
        [self createDisplayInterface];
    }
    
    [self createDisplayInterface:string];
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1;
    }];
    
    [self timerProcessing];
}
- (void)createDisplayInterface:(NSString *)string
{
    // 根据字体得到NSString的尺寸
    CGRect tmpRect = [string boundingRectWithSize:CGSizeMake(Screen_Width-50, Screen_Height-200) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:Fnt,NSFontAttributeName, nil] context:nil];
    self.frame = CGRectMake(Screen_Width/2-(tmpRect.size.width+20)/2, Screen_Height-tmpRect.size.height-100, tmpRect.size.width+20, tmpRect.size.height+20);
    self.toastLabel.frame = CGRectMake(10, 10, tmpRect.size.width, tmpRect.size.height);
    self.toastLabel.text = string;
    UIWindow *window = [[[UIApplication sharedApplication] delegate]window];//找Window
    [window addSubview:self];
}
//创建显示界面
- (void)createDisplayInterface
{
    UILabel * tostLabel = [UILabel new];
    tostLabel.font = Fnt;
    tostLabel.textAlignment = NSTextAlignmentCenter;
    tostLabel.textColor = [UIColor whiteColor];
    tostLabel.numberOfLines= 0;
    [self addSubview:tostLabel];
    
    self.toastLabel = tostLabel;
}
//定时器处理
- (void)timerProcessing
{
    _timeInt = TimeI;
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
        //将定时器添加到线程
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)timerSelector
{
    _timeInt --;
    if (_timeInt == 0) {
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        [_timer invalidate];
        _timer = nil;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
