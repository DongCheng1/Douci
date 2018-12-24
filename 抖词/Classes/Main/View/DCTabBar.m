//
//  DCTabBar.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/11.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCTabBar.h"
#import "JPVideoPlayerDouyinViewController.h"

@interface DCTabBar ()
@property (nonatomic,weak) UIButton *plusButton;
@end

@implementation DCTabBar

- (UIButton *)plusButton {
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [plusButton sizeToFit];
    [plusButton addTarget:self action:@selector(PBact) forControlEvents:UIControlEventTouchUpInside];
    _plusButton = plusButton;
    
    [self addSubview:_plusButton];
    return _plusButton;
}

//点击跳转
- (void)PBact {
    //JPVideoPlayerDouyinViewController *jpVc = [[JPVideoPlayerDouyinViewController alloc]init];
    NSLog(@"我是中间的button");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //布局tabBarButton
    NSLog(@"--->%@",self.subviews);
    CGFloat btnX = 0;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width/(self.items.count + 1);
    NSInteger i = 0;
    for(UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
        }
    }
    
    self.plusButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
}

@end
