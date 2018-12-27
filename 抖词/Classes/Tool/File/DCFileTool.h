//
//  DCFileTool.h
//  抖词
//
//  Created by 董成 on 2018/12/26.
//  Copyright © 2018 董成. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

@interface DCFileTool : NSObject

//获取文件夹的大小，传入文件夹路径
+ (NSInteger)getFileSize:(NSString *)directoryPath;
//删除文件夹,传文件夹路径
+ (void)removeDirectoryPath:(NSString *)directoryPath;
@end
