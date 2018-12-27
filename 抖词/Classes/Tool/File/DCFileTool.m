//
//  DCFileTool.m
//  抖词
//
//  Created by 董成 on 2018/12/26.
//  Copyright © 2018 董成. All rights reserved.
//  处理文件缓存

#import "DCFileTool.h"

@implementation DCFileTool

//返回缓存数据大小
+ (NSInteger)getFileSize:(NSString *)directoryPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"路径错误" userInfo:nil];
        [excp raise];
    }
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

//删除文件夹
+ (void)removeDirectoryPath:(NSString *)directoryPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *arr = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in arr) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:filePath error:nil];
    }
}

@end
