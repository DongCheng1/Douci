//
//  DCNewViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/10.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCNewViewController.h"

@interface DCNewViewController ()

@end

@implementation DCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    //设置导航条
    [self setupNavBar];
}

//设置导航条
- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:nil];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
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
