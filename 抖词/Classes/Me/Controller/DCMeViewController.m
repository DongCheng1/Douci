//
//  DCMeViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/10.
//  Copyright © 2018 董成. All rights reserved.
//

#import "UIView+Frame.h"
#import "DCMeViewController.h"
#import "DCSettingViewController.h"
#import "DCSquareItem.h"
#import "DCSquareCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "DCWebViewController.h"


static NSString * const ID = @"cell";

@interface DCMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSMutableArray *squareItems;
@property (nonatomic,strong) NSMutableArray *squareItems2;
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation DCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNavBar];
    //设置tableview的底部视图
    [self setupFootView];
    //请求数据
    [self requestdata];
    //处理cell间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-34, 0, 0, 0);
}

#pragma mark - 请求数据
- (void)requestdata {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //NSLog(@"哈哈哈%@",responseObject);
        //[responseObject writeToFile:@"/Users/dongcheng/Desktop/Project collection/抖词/抖词/Classes/Me/square.plist" atomically:YES];
        NSArray *dicArr = responseObject[@"square_list"];
        NSMutableArray *dicArr2 = [[NSMutableArray alloc] init];
        [dicArr2 addObject:dicArr[13]];
        [dicArr2 addObject:dicArr[14]];
        
        //字典数组转模型数组
       _squareItems = [DCSquareItem mj_objectArrayWithKeyValuesArray:dicArr2];
        
        //处理数据
        [self resloveData];
        //设置collectionView的高度
        CGFloat itemWH2 = ([UIScreen mainScreen].bounds.size.width - 3)/4;
        self.collectionView.dc_height = 7 * itemWH2 + 5;
        //设置tableview的滚动范围
        self.tableView.tableFooterView = self.collectionView;
        //刷新表格
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 处理数据
- (void)resloveData {
    //判断cell缺几个
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % 4;
    if (exter) {
        exter = 4 - exter;
        for (int i = 0; i < exter; i++) {
            DCSquareItem *item = [[DCSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}
#pragma mark - 设置tableView的底部视图
- (void)setupFootView {
    //1.流式布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    NSInteger cols = 4;
    CGFloat marginF = 1;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWH = (screenWidth - (cols - 1)*marginF)/cols;
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumLineSpacing = marginF;
    flowLayout.minimumInteritemSpacing = marginF;
    //2.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    //3.添加到tableview的底部视图
    self.tableView.tableFooterView = collectionView;
    //设置数据源协议的对象
    collectionView.dataSource = self;
    //设置委托协议的对象
    collectionView.delegate = self;
    //禁止collection滚动
    collectionView.scrollEnabled = NO;
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"DCSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - 实现集合视图的委托协议方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //跳转界面   push跳转
    DCWebViewController *webVc = [[DCWebViewController alloc] init];
    DCSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    webVc.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - 实现集合视图的数据源协议方法
//这个方法决定了集合视图的小格子数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareItems.count;
}
//这个方法决定了小格子的样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DCSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.item];
    return cell;
}



//设置导航条
- (void)setupNavBar {
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    //self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    self.navigationItem.rightBarButtonItems = @[settingItem];
    self.navigationItem.title = @"休闲";
}

//跳转到设置界面
- (void)setting {
    DCSettingViewController *settingVC = [[DCSettingViewController alloc]init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:nil];
}

- (void)night:(UIButton *)button {
    button.selected = !button.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
