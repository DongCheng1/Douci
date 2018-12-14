//
//  DCEssenceViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/10.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCEssenceViewController.h"
#import "UIBarButtonItem+Item.h"

@interface DCEssenceViewController ()

@end

@implementation DCEssenceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //设置导航条
    [self setupNavBar];
}

//设置导航条
- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
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
