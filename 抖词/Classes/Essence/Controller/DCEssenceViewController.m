//
//  DCEssenceViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/10.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCEssenceViewController.h"

@interface DCEssenceViewController ()

@end

@implementation DCEssenceViewController


//设置tabBarItem字体颜色
+ (void)load {
    UITabBarItem *item = [UITabBarItem appearance];
    //设置文字颜色
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    //设置文字大小
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dic2 forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //设置导航条
    [self setupNavBar];
}

//设置导航条
- (void)setupNavBar {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_item_game_click_iconN"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)game {
    NSLog(@"hahhaha");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
