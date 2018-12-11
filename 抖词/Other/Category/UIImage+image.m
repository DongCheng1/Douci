//
//  UIImage+image.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/11.
//  Copyright © 2018 董成. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+ (UIImage *)imageOriginalWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
