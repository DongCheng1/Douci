//
//  DCTabBarController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/11.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCTabBarController.h"
#import "DCMeViewController.h"
#import "DCNewViewController.h"
#import "DCEssenceViewController.h"
#import "DCPublishViewController.h"
#import "DCFriendshipViewController.h"
#import "UIImage+image.h"
#import "DCTabBar.h"
#import "UIView+Frame.h"

@interface DCTabBarController ()

@end

@implementation DCTabBarController

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
    //创建根控制器的子视图控制器对象并添加
    [self setupAllChildViewController];
    //设置tabBar的内容
    [self setupAllChild2Details];
    //自定义tabBar
    [self setupTabBar];
    
}


//自定义tabBar
- (void)setupTabBar {
    DCTabBar *dcTabBar = [[DCTabBar alloc]init];
    [self setValue:dcTabBar forKey:@"tabBar"];
    NSLog(@"--->%@",self.tabBar);
}



 //创建根控制器的子视图控制器对象并添加
- (void)setupAllChildViewController {
    DCEssenceViewController *essenceVc = [[DCEssenceViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    DCNewViewController *newVc = [[DCNewViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    //DCPublishViewController *publishVc = [[DCPublishViewController alloc]init];
    //[self addChildViewController:publishVc];
    DCFriendshipViewController *fsVc = [[DCFriendshipViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:fsVc];
    [self addChildViewController:nav3];
    //手动加载我的界面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([DCMeViewController class]) bundle:nil];
    DCMeViewController *meVc = [storyboard instantiateInitialViewController];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

//设置tabBar的内容
- (void)setupAllChild2Details {
    self.childViewControllers[0].tabBarItem.title = @"精华";
    self.childViewControllers[0].tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_essence_icon"];
    self.childViewControllers[0].tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    self.childViewControllers[1].tabBarItem.title = @"新帖";
    self.childViewControllers[1].tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_new_icon"];
    self.childViewControllers[1].tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    //self.childViewControllers[2].tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
    //self.childViewControllers[2].tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    //self.childViewControllers[2].tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    self.childViewControllers[2].tabBarItem.title = @"关注";
    self.childViewControllers[2].tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_friendTrends_icon"];
    self.childViewControllers[2].tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    self.childViewControllers[3].tabBarItem.title = @"我";
    self.childViewControllers[3].tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_me_icon"];
    self.childViewControllers[3].tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
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
