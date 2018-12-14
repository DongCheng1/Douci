//
//  DCNavigationViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/13.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCNavigationViewController.h"
#import "UIBarButtonItem+Item.h"

@interface DCNavigationViewController ()

@end

@implementation DCNavigationViewController

+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置导航条文字大小
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:dic];
    //导航条的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//设置导航条返回键
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { //非根控制器
        //设置返回键
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backitemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    //真正的跳转
    [super pushViewController:viewController animated:animated];
}
- (void)back {
    [self popViewControllerAnimated:YES];
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
