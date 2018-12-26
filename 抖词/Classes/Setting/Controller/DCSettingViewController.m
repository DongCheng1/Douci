//
//  DCSettingViewController.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/14.
//  Copyright © 2018 董成. All rights reserved.
//

#import "DCSettingViewController.h"
#import "UIBarButtonItem+Item.h"
@interface DCSettingViewController ()

@end

@implementation DCSettingViewController
//注册cell前必须要先定义一个标识符
static NSString * const ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    //计算整个应用数据的缓存数据，整个应用程序的缓存数据存放在沙盒中
    cell.textLabel.text = [self sizeStr];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cell;
}

//点击cell的动作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *arr = [mgr contentsOfDirectoryAtPath:cachePath error:nil];
    for (NSString *subPath in arr) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:filePath error:nil];
    }
    [self.tableView reloadData];
}


//缓存数据大小
- (NSString *)sizeStr {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSInteger totalSize = [self getFileSize:cachePath];
    NSString *sizeStr = @"清除缓存";
    if (totalSize > 1000 * 1000) {
        CGFloat sizeF = totalSize / 1000.0 /1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.lfMB)",sizeStr,sizeF];
    }else if (totalSize > 1000) {
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.lfkB)",sizeStr,sizeF];
    }else if (totalSize > 0) {
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    return sizeStr;
}


//应用数据的缓存
- (NSInteger)getFileSize:(NSString *)directoryPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    NSInteger totalSize = 0;
    for (NSString *subPath in subPaths) {
        //获取文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        if ([filePath containsString:@".DS"]) continue;
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        NSDictionary *dic = [mgr attributesOfItemAtPath:directoryPath error:nil];
        NSInteger fileSize = [dic fileSize];
        totalSize += fileSize;
    }
    return totalSize;
}
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
