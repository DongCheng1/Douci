//
//  FirstViewController.m
//  抖词
//
//  Created by 董成 on 2018/11/22.
//  Copyright © 2018 董成. All rights reserved.
//

#import "FirstViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController2.h"
#import "UIImageView+WebCache.h"
#import "DefaultInstance.h"
//定义数字3
#define COL_NUM 1
//在哪儿个视图中加集合视图，就要在这个视图中加集合视图的协议
@interface FirstViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>



//存数据
@property(strong,nonatomic) NSArray *words;
//建立collection对象
@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic) NSDictionary *dicword;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hahaahahahaha");
    //获取json的所有数据
    NSURL *url = [NSURL URLWithString:@"http://www.studynumber.com/wordskill/json/words.json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.words = (NSArray *)jsonObj;
    //下面这个方法用来实现集合视图
    [self setupCollectionView];
}

-(void)setupCollectionView{
    //首先要设置collection的布局为流式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    layout.itemSize = CGSizeMake(screenSize.width, 310);
    //layout.sectionInset = UIEdgeInsetsMake(15, 15, 30, 15);
    //if (screenSize.height>586) {
      //  layout.itemSize = CGSizeMake(500, 500);
        //layout.sectionInset = UIEdgeInsetsMake(15, 15, 20, 15);
    //}
    //layout.minimumInteritemSpacing = 2;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册集合视图cell
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    //让集合视图实现两个协议
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //添加集合视图到视图中
    [self.view addSubview:self.collectionView];
}

//集合视图的数据源协议datasource
//设置节的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    int num = [self.words count] % COL_NUM;
    if (num==0) {
        return [self.words count]/COL_NUM;
    }else{
        return [self.words count]/COL_NUM+1;
    }
}

//设置完节后，再设置每个节中的cell量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return COL_NUM;
}

//获取Document目录
- (NSString *)getDocumentPath{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [docPaths lastObject];
    return documentPath;
}


//设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSInteger idx = indexPath.section * COL_NUM + indexPath.row;
    if (self.words.count <= idx) {
        return cell;
    }
    self.dicword = self.words[idx];
    
    //获取所有数据
    //[[NSUserDefaults standardUserDefaults] setObject:self.dicword forKey:@"firstdata"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    //从网络获取图片
    NSString *urlstring = self.dicword[@"imageurl"];
    NSURL *url = [NSURL URLWithString:urlstring];
    [cell.imageView1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    UITapGestureRecognizer *gr1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gr1)];
    [cell.imageView1 addGestureRecognizer:gr1];
    cell.imageView1.userInteractionEnabled = YES;
    
    //将缓存图片存储到本地文件夹
    //NSData *data = UIImageJPEGRepresentation(cell.imageView1.image, 1.0);
    //NSString *docPath = [self getDocumentPath];
    //NSString *testPath = [docPath stringByAppendingPathComponent:@"抖词"];
    //NSString *name = [testPath stringByAppendingPathComponent:@"图片"];
    //NSLog(@"%@", docPath);
    //[data writeToFile:name atomically:YES];
    
    NSString *urlstring2 = self.dicword[@"imageurl"];
    NSURL *url2 = [NSURL URLWithString:urlstring2];
    [cell.imageView2 sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    
    
    NSString *urlstring3 = self.dicword[@"imageurl"];
    [cell.label1 setText:urlstring3];
    
    
    
    NSString *urlstring4 = self.dicword[@"imageurl"];
    [cell.label2 setText:urlstring4];
    
    
    
    
    //返回cell
    return cell;
}





//集合视图的委托协议delegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  //self.dicword = self.words[indexPath.section * COL_NUM + indexPath.row];
    //DetailViewController2 *detailViewController2 = [[DetailViewController2 alloc]init];
    //detailViewController2.title = self.dicword[@"name"];
    //detailViewController2.rowdict = self.dicword;
    //push到指定的视图
    //[self.navigationController pushViewController:detailViewController2 animated:YES];
    //这个就是设置点击cell之后跳转到navigationController视图
    //[self presentViewController:navigationController animated:TRUE completion:nil];
//}





-(void)gr1{
   
    DetailViewController2 *detailViewController2 = [[DetailViewController2 alloc]init];
    //[self.navigationController pushViewController:detailViewController2 animated:YES];
    
    
    [self presentViewController:detailViewController2 animated:YES completion:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
