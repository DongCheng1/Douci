//
//  DCADViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/17.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCADViewController.h"
#import "DCADitem.h"
#import "DCTabBarController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface DCADViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak,nonatomic) UIImageView *adImageView;
@property (strong,nonatomic) DCADitem *item;
@property (weak,nonatomic) NSTimer *timer;
@end

@implementation DCADViewController

//点击跳转
- (IBAction)buttonActAD:(id)sender {
    DCTabBarController *tabBarVc = [[DCTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    [self.timer invalidate];
}


//懒加载广告图片
- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.adContainView addSubview:imageView];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        //替换
        _adImageView = imageView;
    }
    return _adImageView;
}
//实现手势
- (void)tap {
    //跳转到界面Safari
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url options:@{} completionHandler:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setupLaunchImage];
    //请求数据
    [self getData];
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange {
    static int i = 3;
    
    if (i == 0) {
        DCTabBarController *tabBarVc = [[DCTabBarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
        [self.timer invalidate];
    }
    i--;
    //设置跳转按钮
    [self.button setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
}

- (void) getData{
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc]init];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         [responseObject writeToFile:@"/Users/dongcheng/Desktop/Baisibudejie/Baisibudejie/Classes/AD/ad.plist" atomically:YES];
        NSDictionary *dic = [responseObject[@"ad"] lastObject];
        self.item = [DCADitem mj_objectWithKeyValues:dic];
        //创建展示图片
        //CGFloat w = [UIScreen mainScreen].bounds.size.width;
        //CGFloat h = w/self.item.w*[UIScreen mainScreen].bounds.size.height;
        self.adImageView.frame = CGRectMake(0, 0, 0, 0);
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)setupLaunchImage {
    if ([UIScreen mainScreen].bounds.size.height == 736) {
         self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if ([UIScreen mainScreen].bounds.size.height == 667) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if ([UIScreen mainScreen].bounds.size.height == 568) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    }else if ([UIScreen mainScreen].bounds.size.height == 480) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700@2x"];
    }else if ([UIScreen mainScreen].bounds.size.height == 812) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
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
