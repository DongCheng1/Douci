//
//  DCFriendshipViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/10.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCFriendshipViewController.h"
#import "UIBarButtonItem+Item.h"

@interface DCFriendshipViewController ()

@end

@implementation DCFriendshipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //设置导航条
    [self setupNavBar];
}


//设置导航条
- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:nil];
    self.navigationItem.title = @"我的关注";
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
